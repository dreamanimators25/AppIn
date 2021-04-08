//
//  EditProfileVC.swift
//  AppIn
//
//  Created by sameer khan on 22/06/20.
//  Copyright © 2020 Sameer khan. All rights reserved.
//

import UIKit
import DropDown
import Alamofire
import SwiftyJSON

class EditProfileVC: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var txtFName: UITextField!
    @IBOutlet weak var txtFContactNo: UITextField!
    @IBOutlet weak var txtFEmail: UITextField!
    @IBOutlet weak var txtFAddress: UITextField!
    @IBOutlet weak var txtFCountry: UITextField!
    @IBOutlet weak var txtFDate: UITextField!
    @IBOutlet weak var txtFAgeFeel: UITextField!
    @IBOutlet weak var txtFBiography: UITextField!
    
    @IBOutlet weak var lblNameError: UILabel!
    @IBOutlet weak var lblContactNoError: UILabel!
    @IBOutlet weak var lblEmailError: UILabel!
    @IBOutlet weak var lblAddressError: UILabel!
    @IBOutlet weak var lblCountryError: UILabel!
    @IBOutlet weak var lblDateError: UILabel!
    @IBOutlet weak var lblAgeFeelError: UILabel!
    @IBOutlet weak var lblBiographyError: UILabel!
    
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var contactNoView: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var addressView: UIView!
    @IBOutlet weak var countryView: UIView!
    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var ageFeelView: UIView!
    @IBOutlet weak var biographyView: UIView!
    
    let labelDropDown = DropDown()
    var strImageSendToServer = ""
    var selectedImage : UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.width/2
        
        self.setStatusBarColor()

        self.txtFDate.addTarget(self, action: #selector(tapDateField), for: .allEditingEvents)
        self.txtFAgeFeel.addTarget(self, action: #selector(tapAgeFeelField), for: .allEditingEvents)
        self.txtFBiography.addTarget(self, action: #selector(tapBioField), for: .allEditingEvents)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.callGetMyProfileWebService()
        
        self.tabBarController?.tabBar.isHidden = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(CreateAccountVC.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        // Initialization code
        labelDropDown.backgroundColor = UIColor.white
        //labelDropDown.layer.cornerRadius = 10.0
        //labelDropDown.frame.size.width = self.txtFLabel.frame.size.width
        //labelDropDown.clipsToBounds = true
        
        labelDropDown.anchorView = self.txtFAgeFeel
        labelDropDown.dataSource = ["Youth", "Young Adult", "Middle Aged", "Senior"]
        labelDropDown.cellConfiguration = { (index, item) in return "\(item)" }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: Keyboard Notification methods
    @objc func keyboardWillShow(notification: NSNotification) {
        if ((notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            
            self.lblNameError.isHidden = true
            self.lblContactNoError.isHidden = true
            self.lblEmailError.isHidden = true
            self.lblAddressError.isHidden = true
            self.lblCountryError.isHidden = true
            self.lblDateError.isHidden = true
            self.lblAgeFeelError.isHidden = true
            self.lblBiographyError.isHidden = true
            
            self.nameView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
            self.contactNoView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
            self.emailView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
            self.addressView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
            self.countryView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
            self.dateView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
            self.ageFeelView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
            self.biographyView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
            
        }
    }
    
    @objc func tapDateField() {
        
        DispatchQueue.main.async {
            self.view.endEditing(true)
            
            let vc = DesignManager.loadViewControllerFromSettingStoryBoard(identifier: "DatePopUpVC") as! DatePopUpVC
            
            vc.setDate = { strDate in
                self.txtFDate.text = strDate
            }
            
            vc.modalPresentationStyle = .overCurrentContext
            //vc.modalTransitionStyle = .crossDissolve
            self.present(vc, animated: true, completion: nil)
        }
        
    }
    
    @objc func tapAgeFeelField() {
        
        self.view.endEditing(true)
        
        labelDropDown.selectionAction = { (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.txtFAgeFeel.text = item
        }

        labelDropDown.width = self.txtFAgeFeel.bounds.width
        labelDropDown.bottomOffset = CGPoint(x: 0, y:(labelDropDown.anchorView?.plainView.bounds.height)!)
        labelDropDown.show()
    
    }
    
    @objc func tapBioField() {
    
        DispatchQueue.main.async {
            self.view.endEditing(true)
            
            let vc = DesignManager.loadViewControllerFromSettingStoryBoard(identifier: "EditBiographyVC") as! EditBiographyVC
            
            vc.setBio = { strBio in
                self.txtFBiography.text = strBio
            }
            
            vc.modalPresentationStyle = .overCurrentContext
            //vc.modalTransitionStyle = .crossDissolve
            self.present(vc, animated: true, completion: nil)
        }
        
    }
    
    //MARK: IBAction
    @IBAction func backBtnClicked(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveBtnClicked(_ sender: UIButton) {
        
//        guard self.Validation() else {
//            return
//        }
        
        self.view.endEditing(true)
        
        if txtFName.text!.isEmpty {
            self.nameView.layer.borderColor = #colorLiteral(red: 0.9215686275, green: 0.3411764706, blue: 0.3411764706, alpha: 1)
            self.lblNameError.text = "Please Enter Name"
            self.lblNameError.isHidden = false
        }else {
            self.callEditProfileWebService()
        }
        
    }
   
    @IBAction func changeProfileImageBtnClicked(_ sender: UIButton) {
        let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.importImageFromGallery(src: "Camera")
        })
        
        let galleryiAction = UIAlertAction(title: "Gallery", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.importImageFromGallery(src: "Photo Library")
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in
        })
        
        optionMenu.addAction(cameraAction)
        optionMenu.addAction(galleryiAction)
        optionMenu.addAction(cancelAction)
        
        optionMenu.view.tintColor = AppThemeColor
        self.present(optionMenu, animated: true, completion: nil)
    }
    
    //MARK: Custom Methods
    func importImageFromGallery(src:String) {
        let image = UIImagePickerController()
        image.delegate = self
        
        if src == "Photo Library" {
            image.sourceType = UIImagePickerController.SourceType.photoLibrary
        } else if src == "Camera" {
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                image.sourceType = UIImagePickerController.SourceType.camera
            } else {
                print("not select")
            }
        }
        
        image.allowsEditing = false
        
        self.present(image, animated: true) {
            // code
        }
    }
    
    //MARK:- image picker delegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //let image = (info[UIImagePickerController.InfoKey.originalImage] as? UIImage)!
        //self.profileImageView.image = image
        
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        //let imageData:NSData = image.jpegData(compressionQuality: 0.50)! as NSData
        //let strBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
        //self.strImageSendToServer = strBase64
        
        self.selectedImage = image
        
        dismiss(animated: true) {
            self.callChangeProfilePicWebService(imgdata: self.selectedImage ?? UIImage())
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: Validation Methods
    func Validation() -> Bool {
        
        self.view.endEditing(true)
        
        if txtFName.text!.isEmpty {
            
            self.nameView.layer.borderColor = #colorLiteral(red: 0.9215686275, green: 0.3411764706, blue: 0.3411764706, alpha: 1)
            self.lblNameError.text = "Please Enter Name"
            self.lblNameError.isHidden = false
            return false
        }
        else if txtFContactNo.text!.isEmpty {
            
            self.contactNoView.layer.borderColor = #colorLiteral(red: 0.9215686275, green: 0.3411764706, blue: 0.3411764706, alpha: 1)
            self.lblContactNoError.text = "Please Enter Contact No"
            self.lblContactNoError.isHidden = false
            return false
        }
        else if txtFEmail.text!.isEmpty {
            
            self.emailView.layer.borderColor = #colorLiteral(red: 0.9215686275, green: 0.3411764706, blue: 0.3411764706, alpha: 1)
            self.lblEmailError.text = "Please Enter E-mail Address"
            self.lblEmailError.isHidden = false
            return false
        }
        else if(!Alert.isValidEmail(testStr: txtFEmail.text!)) {
            
            self.emailView.layer.borderColor = #colorLiteral(red: 0.9215686275, green: 0.3411764706, blue: 0.3411764706, alpha: 1)
            self.lblEmailError.text = "Please Enter Valid E-mail Address"
            self.lblEmailError.isHidden = false
            return false
        }
        else if txtFAddress.text!.isEmpty {
            
            self.addressView.layer.borderColor = #colorLiteral(red: 0.9215686275, green: 0.3411764706, blue: 0.3411764706, alpha: 1)
            self.lblAddressError.text = "Please Enter Address"
            self.lblAddressError.isHidden = false
            return false
        }
        else if txtFCountry.text!.isEmpty {
            
            self.countryView.layer.borderColor = #colorLiteral(red: 0.9215686275, green: 0.3411764706, blue: 0.3411764706, alpha: 1)
            self.lblCountryError.text = "Please Enter Country"
            self.lblCountryError.isHidden = false
            return false
        }
        else if txtFDate.text!.isEmpty {
            
            self.dateView.layer.borderColor = #colorLiteral(red: 0.9215686275, green: 0.3411764706, blue: 0.3411764706, alpha: 1)
            self.lblDateError.text = "Please Select Date"
            self.lblDateError.isHidden = false
            return false
        }
        else if txtFAgeFeel.text!.isEmpty {
            
            self.ageFeelView.layer.borderColor = #colorLiteral(red: 0.9215686275, green: 0.3411764706, blue: 0.3411764706, alpha: 1)
            self.lblAgeFeelError.text = "Please Select Age Feel"
            self.lblAgeFeelError.isHidden = false
            return false
        }
        /*
        else if txtFBiography.text!.isEmpty {
            
            self.biographyView.layer.borderColor = #colorLiteral(red: 0.9215686275, green: 0.3411764706, blue: 0.3411764706, alpha: 1)
            self.lblBiographyError.text = "Please Enter Biography"
            self.lblBiographyError.isHidden = false
            return false
        }
        */
        
        return true
    }
    
    //MARK: Web Service
    func callGetMyProfileWebService() {
        
        let userData = UserDefaults.getUserData()
        
        var params = [String : String]()
        params = ["user_id" : userData?.UserId ?? ""]
        
        //print("params = \(params)")
        self.showSpinner(onView: self.view)
        
        Alamofire.request(kGetMyProfileURL, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: nil).responseJSON { (responseData) in
            self.removeSpinner()
            //print(responseData)
            
            switch responseData.result {
            case .success:
                
                if let data = responseData.result.value {
                    
                    let json = JSON(data)
                    //print(json)
                    
                    let responsModal = RegisterBaseClass.init(json: json)
                    
                    if responsModal.status == "success" {
                        
                        if let profileData = responsModal.data {
                            self.txtFName.text = profileData.name
                            self.txtFContactNo.text = profileData.contactNo
                            self.txtFEmail.text = profileData.email
                            self.txtFAddress.text = profileData.address
                            self.txtFCountry.text = profileData.country
                            self.txtFDate.text = profileData.birthDate
                            self.txtFAgeFeel.text = profileData.ageFeel
                            self.txtFBiography.text = profileData.profileBio
                            
                            if let url = URL(string: profileData.profileImage ?? "") {
                                 self.profileImageView.af_setImage(withURL: url)
                            }
                            
                        }
                                                    
                    }else{
                        Alert.showAlert(strTitle: "", strMessage: responsModal.msg ?? "", Onview: self)
                    }
                    
                }
                
            case .failure(let error):
                
                if error.localizedDescription.contains("Internet connection appears to be offline"){
                    Alert.showAlert(strTitle: "Error!!", strMessage: "Internet connection appears to be offline", Onview: self)
                }else{
                    Alert.showAlert(strTitle: "Error!!", strMessage: "something went wrong", Onview: self)
                }
            }
            
        }
        
    }
    
    func callEditProfileWebService() {
        
        let userData = UserDefaults.getUserData()
        
        var params = [String : String]()
        params = ["user_id" : userData?.UserId ?? "",
                  "name" : self.txtFName.text!,
                  "contactNo" : self.txtFContactNo.text!,
                  "email" : self.txtFEmail.text!,
                  "address" : self.txtFAddress.text!,
                  "country" : self.txtFCountry.text!,
                  "ageFeel" : self.txtFAgeFeel.text!,
                  //"profileBio" : self.txtFBiography.text!,
                  "birthDate" : self.txtFDate.text!,
                  ]
        
        //print("params = \(params)")
        self.showSpinner(onView: self.view)
        
        Alamofire.request(kEditProfileURL, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: nil).responseJSON { (responseData) in
            
            self.removeSpinner()
            //print(responseData)
            
            switch responseData.result {
            case .success:
                
                if let data = responseData.result.value {
                    let json = JSON(data)
                    //print(json)
                    
                    let responsModal = RegisterBaseClass.init(json: json)
                    
                    DispatchQueue.main.async {
                        if responsModal.status == "success" {
                                                        
                            let vc = DesignManager.loadViewControllerFromSettingStoryBoard(identifier: "BottomViewVC") as! BottomViewVC
                            vc.img = #imageLiteral(resourceName: "successTick")
                            vc.lbl = responsModal.msg ?? "Success"
                            vc.btn = ""
                            vc.modalPresentationStyle = .overCurrentContext
                            //vc.modalTransitionStyle = .crossDissolve
                            self.present(vc, animated: true, completion: nil)
                            
                        }else{
                            
                            let vc = DesignManager.loadViewControllerFromSettingStoryBoard(identifier: "BottomViewVC") as! BottomViewVC
                            vc.img = #imageLiteral(resourceName: "errorClose")
                            vc.lbl = responsModal.msg ?? "Error"
                            vc.btn = ""
                            vc.modalPresentationStyle = .overCurrentContext
                            //vc.modalTransitionStyle = .crossDissolve
                            self.present(vc, animated: true, completion: nil)
                            
                        }
                    }
                    
                }
                
            case .failure(let error):
                
                if error.localizedDescription.contains("Internet connection appears to be offline"){
                    Alert.showAlert(strTitle: "Error!!", strMessage: "Internet connection appears to be offline", Onview: self)
                }else{
                    Alert.showAlert(strTitle: "Error!!", strMessage: "something went wrong", Onview: self)
                }
            }
            
        }
        
    }
    
    //MARK: Web Service
    func callChangeProfilePicWebService(imgdata : UIImage) {
        
        let userData = UserDefaults.getUserData()
        
        var params = [String : Any]()
        
        params = ["user_id"     : userData?.UserId ?? ""]
        
        //print("params = \(params)")
        
        /*
        Alamofire.request(kChangeProfilePictureURL, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: nil).responseJSON { (responseData) in
                        
            print(responseData)
            
            switch responseData.result {
            case .success:
                
                if let data = responseData.result.value {
                    let json = JSON(data)
                    print(json)
                    
                    let responsModal = RegisterBaseClass.init(json: json)
                        
                    DispatchQueue.main.async {
                            if responsModal.status == "success" {
                                
                                //self.profileImageView.image = self.selectedImage
                                
                                let vc = DesignManager.loadViewControllerFromSettingStoryBoard(identifier: "BottomViewVC") as! BottomViewVC
                                vc.img = #imageLiteral(resourceName: "successTick")
                                vc.lbl = responsModal.msg ?? "Success"
                                vc.btn = ""
                                vc.modalPresentationStyle = .overCurrentContext
                                //vc.modalTransitionStyle = .crossDissolve
                                self.present(vc, animated: true, completion: nil)
                                
                            }else{
                                
                                let vc = DesignManager.loadViewControllerFromSettingStoryBoard(identifier: "BottomViewVC") as! BottomViewVC
                                vc.img = #imageLiteral(resourceName: "errorClose")
                                vc.lbl = responsModal.msg ?? "Error"
                                vc.btn = ""
                                vc.modalPresentationStyle = .overCurrentContext
                                //vc.modalTransitionStyle = .crossDissolve
                                self.present(vc, animated: true, completion: nil)
                                
                            }
                        }
                    
                }
                
            case .failure(let error):
                
                if error.localizedDescription.contains("Internet connection appears to be offline"){
                    Alert.showAlert(strTitle: "Error!!", strMessage: "Internet connection appears to be offline", Onview: self)
                }else{
                    Alert.showAlert(strTitle: "Error!!", strMessage: "something went wrong", Onview: self)
                }
            }
            
        }*/
        
        
        
        
        //let jsonData = try! JSONSerialization.data(withJSONObject: params, options: [])
        let imageData = self.selectedImage?.jpegData(compressionQuality: 0.50) ?? Data()
        
        self.showSpinner(onView: self.view)
        
        //To Upload MultiPart Data using Alamofire
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                //multipartFormData.append(imageData as Data, withName: "json")
                
                if self.selectedImage != nil {
                    
                    multipartFormData.append(imageData, withName: "profile_pic", fileName: "file.jpg", mimeType: "image/jpg")
                    //multipartFormData.append(image.jpegData(compressionQuality: 1)!, withName: "file", fileName: "file.jpg", mimeType: "image/jpg")
                    for (key, value) in params {
                        multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
                    }
                    
                }
        },
            to: "\(kChangeProfilePictureURL)",
            method: HTTPMethod.post,
            headers: nil,
            encodingCompletion: { encodingResult in
                self.removeSpinner()
                
                switch encodingResult {
                    
                case .success(let upload,_,_ ):
                    upload.responseJSON { response in
                        
                        if let data = response.result.value {
                            let json = JSON(data)
                            //print(json)
                            
                            self.profileImageView.image = self.selectedImage
                        }
                    }
                    
                case .failure(let encodingError):
                    
                    if encodingError.localizedDescription.contains("Internet connection appears to be offline"){
                        Alert.showAlert(strTitle: "Error!!", strMessage: "Internet connection appears to be offline", Onview: self)
                    }else{
                        Alert.showAlert(strTitle: "Error!!", strMessage: "something went wrong", Onview: self)
                    }
                    
                }
        }
        )
        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}

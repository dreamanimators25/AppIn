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
    @IBOutlet weak var txtFSurName: UITextField!
    @IBOutlet weak var txtFEmail: UITextField!
    @IBOutlet weak var txtFDate: UITextField!
    @IBOutlet weak var txtFLabel: UITextField!
    @IBOutlet weak var txtFBiography: UITextField!
    
    @IBOutlet weak var lblNameError: UILabel!
    @IBOutlet weak var lblSurNameError: UILabel!
    @IBOutlet weak var lblEmailError: UILabel!
    @IBOutlet weak var lblDateError: UILabel!
    @IBOutlet weak var lblLabelError: UILabel!
    @IBOutlet weak var lblBiographyError: UILabel!
    
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var surNameView: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var labelView: UIView!
    @IBOutlet weak var biographyView: UIView!
    
    let labelDropDown = DropDown()
    
    var strImageSendToServer = ""
    var selectedImage:UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.callGetMyProfileWebService()

        self.txtFDate.addTarget(self, action: #selector(tapDateField), for: .allEditingEvents)
        self.txtFLabel.addTarget(self, action: #selector(tapLabelField), for: .allEditingEvents)
        self.txtFBiography.addTarget(self, action: #selector(tapBioField), for: .allEditingEvents)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(CreateAccountVC.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        // Initialization code
        labelDropDown.anchorView = self.txtFLabel
        labelDropDown.dataSource = ["Male","Female"]
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
            self.lblSurNameError.isHidden = true
            self.lblEmailError.isHidden = true
            self.lblDateError.isHidden = true
            self.lblLabelError.isHidden = true
            self.lblBiographyError.isHidden = true
            
            self.nameView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
            self.surNameView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
            self.emailView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
            self.dateView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
            self.labelView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
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
    
    @objc func tapLabelField() {
        
        self.view.endEditing(true)
        
        labelDropDown.selectionAction = { (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.txtFLabel.text = item
        }

        labelDropDown.width = self.txtFLabel.bounds.width
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
        let imageData:NSData = image.jpegData(compressionQuality: 0.50)! as NSData
        let strBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
        self.strImageSendToServer = strBase64
        
        self.selectedImage = image
        
        dismiss(animated: true) {
            self.callChangeProfilePicWebService(imgStr: self.strImageSendToServer)
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
        else if txtFSurName.text!.isEmpty {
            
            self.surNameView.layer.borderColor = #colorLiteral(red: 0.9215686275, green: 0.3411764706, blue: 0.3411764706, alpha: 1)
            self.lblSurNameError.text = "Please Enter Surname"
            self.lblSurNameError.isHidden = false
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
        else if txtFDate.text!.isEmpty {
            
            self.dateView.layer.borderColor = #colorLiteral(red: 0.9215686275, green: 0.3411764706, blue: 0.3411764706, alpha: 1)
            self.lblDateError.text = "Please Select Date"
            self.lblDateError.isHidden = false
            return false
        }
        else if txtFLabel.text!.isEmpty {
            
            self.labelView.layer.borderColor = #colorLiteral(red: 0.9215686275, green: 0.3411764706, blue: 0.3411764706, alpha: 1)
            self.lblLabelError.text = "Please Select Label"
            self.lblLabelError.isHidden = false
            return false
        }else if txtFBiography.text!.isEmpty {
                        
            self.biographyView.layer.borderColor = #colorLiteral(red: 0.9215686275, green: 0.3411764706, blue: 0.3411764706, alpha: 1)
            self.lblBiographyError.text = "Please Enter Biography"
            self.lblBiographyError.isHidden = false
            return false
        }
        
        return true
    }
    
    //MARK: Web Service
    func callGetMyProfileWebService() {
        
        //let userData = UserDefaults.getUserData()
        
        var params = [String : String]()
        //params = ["user_id" : userData?.UserId ?? ""]
        params = ["user_id" : "3302"]
        
        print("params = \(params)")
        
        Alamofire.request(kGetMyProfileURL, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: nil).responseJSON { (responseData) in
                        
            print(responseData)
            
            switch responseData.result {
            case .success:
                
                if let data = responseData.result.value {
                    
                    let json = JSON(data)
                    print(json)
                    
                    let responsModal = RegisterBaseClass.init(json: json)
                    
                    if responsModal.status == "success" {
                        
                        if let profileData = responsModal.data {
                            self.txtFName.text = profileData.userName
                            self.txtFSurName.text = profileData.name
                            self.txtFEmail.text = profileData.email
                            self.txtFDate.text = profileData.birthDate
                            self.txtFLabel.text = profileData.gender
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
                    Alert.showAlert(strTitle: "Error!!", strMessage: "Somthing went wrong", Onview: self)
                }
            }
            
        }
        
    }
    
    func callEditProfileWebService() {
        
        //let userData = UserDefaults.getUserData()
        
        var params = [String : String]()
        params = ["user_id" : "3302",
                  "name" : self.txtFName.text!,
                  "username" : self.txtFName.text!,
                  "contactNo" : "",
                  "email" : self.txtFEmail.text!,
                  "address" : "",
                  "country" : "",
                  "gender" : self.txtFLabel.text!,
                  "profileBio" : self.txtFBiography.text!,
                  "birthDate" : self.txtFDate.text!,
                  ]
        
        print("params = \(params)")
        
        Alamofire.request(kEditProfileURL, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: nil).responseJSON { (responseData) in
                        
            print(responseData)
            
            switch responseData.result {
            case .success:
                
                if let data = responseData.result.value {
                    let json = JSON(data)
                    print(json)
                    
                    let responsModal = RegisterBaseClass.init(json: json)
                    
                    if responsModal.status == "success" {
                        
                    }else{
                        Alert.showAlert(strTitle: "", strMessage: responsModal.msg ?? "", Onview: self)
                    }
                    
                }
                
            case .failure(let error):
                
                if error.localizedDescription.contains("Internet connection appears to be offline"){
                    Alert.showAlert(strTitle: "Error!!", strMessage: "Internet connection appears to be offline", Onview: self)
                }else{
                    Alert.showAlert(strTitle: "Error!!", strMessage: "Somthing went wrong", Onview: self)
                }
            }
            
        }
        
    }
    
    //MARK: Web Service
    func callChangeProfilePicWebService(imgStr : String) {
        
        //let userData = UserDefaults.getUserData()
        
        var params = [String : String]()
        //params = ["user_id" : userData?.UserId ?? ""]
        params = ["user_id"     : "3302",
                  "profile_pic" : imgStr]
        
        //print("params = \(params)")
        
        Alamofire.request(kChangeProfilePictureURL, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: nil).responseJSON { (responseData) in
                        
            print(responseData)
            
            switch responseData.result {
            case .success:
                
                if let data = responseData.result.value {
                    let json = JSON(data)
                    print(json)
                    
                    let responsModal = RegisterBaseClass.init(json: json)
                    
                    if responsModal.status == "success" {
                        self.profileImageView.image = self.selectedImage
                    }else{
                        Alert.showAlert(strTitle: "", strMessage: responsModal.msg ?? "", Onview: self)
                    }
                    
                }
                
            case .failure(let error):
                
                if error.localizedDescription.contains("Internet connection appears to be offline"){
                    Alert.showAlert(strTitle: "Error!!", strMessage: "Internet connection appears to be offline", Onview: self)
                }else{
                    Alert.showAlert(strTitle: "Error!!", strMessage: "Somthing went wrong", Onview: self)
                }
            }
            
        }
        
        
        
        /*
        let jsonData = try! JSONSerialization.data(withJSONObject: params, options: [])
        
        //To Upload MultiPart Data using Alamofire
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                multipartFormData.append(jsonData, withName: "json")
                
                if let image = self.selectedImage {
                    
                    multipartFormData.append(image.jpegData(compressionQuality: 1)!, withName: "file", fileName: "file.jpeg", mimeType: "image/jpeg")
                }
        },
            to: "\(kChangeProfilePictureURL)",
            method: HTTPMethod.post,
            headers: nil,
            encodingCompletion: { encodingResult in
                
                switch encodingResult {
                    
                case .success(let upload,_,_ ):
                    upload.responseJSON { response in
                        
                        if let data = response.result.value {
                            let json = JSON(data)
                            print(json)
                            
                        }
                    }
                    
                case .failure(let encodingError):
                    
                    if encodingError.localizedDescription.contains("Internet connection appears to be offline"){
                        Alert.showAlert(strTitle: "Error!!", strMessage: "Internet connection appears to be offline", Onview: self)
                    }else{
                        Alert.showAlert(strTitle: "Error!!", strMessage: "Somthing went wrong", Onview: self)
                    }
                    
                }
        }
        )*/
        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}

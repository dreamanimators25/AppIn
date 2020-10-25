//
//  EditProfileVC.swift
//  AppIn
//
//  Created by sameer khan on 22/06/20.
//  Copyright © 2020 Sameer khan. All rights reserved.
//

import UIKit

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

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(CreateAccountVC.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
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
    
    //MARK: IBAction
    @IBAction func backBtnClicked(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveBtnClicked(_ sender: UIButton) {
        
        guard self.Validation() else {
            return
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
        let image = (info[UIImagePickerController.InfoKey.originalImage] as? UIImage)!
        self.profileImageView.image = image
        
        dismiss(animated: true, completion: nil)
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

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}

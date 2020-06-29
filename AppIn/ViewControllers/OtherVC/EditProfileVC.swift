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
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblUserEmail: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.tabBarController?.tabBar.isHidden = false
    }
    
    //MARK: IBAction
    @IBAction func backBtnClicked(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func changeNameBtnClicked(_ sender: UIButton) {
        
        DispatchQueue.main.async {
            let vc = DesignManager.loadViewControllerFromWebStoryBoard(identifier: "ProfileChangePopVC") as! ProfileChangePopVC
            vc.modalPresentationStyle = .overCurrentContext
            vc.modalTransitionStyle = .crossDissolve
            vc.isComeFor = "Name"
            
            vc.setEnteredText = { val in
                self.lblUserName.text = val
            }
            
            self.present(vc, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func changeEmailBtnClicked(_ sender: UIButton) {
        
        DispatchQueue.main.async {
            let vc = DesignManager.loadViewControllerFromWebStoryBoard(identifier: "ProfileChangePopVC") as! ProfileChangePopVC
            vc.modalPresentationStyle = .overCurrentContext
            vc.modalTransitionStyle = .crossDissolve
            vc.isComeFor = "Email"
            
            vc.setEnteredText = { val in
                self.lblUserEmail.text = val
            }
            
            self.present(vc, animated: true, completion: nil)
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

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}

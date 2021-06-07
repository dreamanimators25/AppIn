//
//  DeleteAcFinalPopUpVC.swift
//  AppIn
//
//  Created by Sameer Khan on 30/05/21.
//  Copyright © 2021 Sameer khan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class DeleteAcFinalPopUpVC: UIViewController {
    
    @IBOutlet weak var titleLblFinal: UILabel!
    @IBOutlet weak var contentLblFinal: UILabel!
    @IBOutlet weak var okBtnFinal: UIButton!
    
    var strTitleFinal : String?
    var strContentFinal : String?
    var btnTitleFinal : String?

    override func viewDidLoad() {
        super.viewDidLoad()
                
        if let str1 = strTitleFinal {
            self.titleLblFinal.text = str1
        }
        
        if let str2 = strContentFinal {
            self.contentLblFinal.text = str2
        }
        
        if let str3 = btnTitleFinal {
            self.okBtnFinal.setTitle(str3, for: .normal)
        }

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
    @IBAction func dismissBtnClicked(_ sender: UIButton) {
        self.dismiss(animated: true) {
            
        }
    }
    
    @IBAction func deleteAcBtnClicked(_ sender: UIButton) {
        self.dismiss(animated: true) {
            self.callDeleteAccountWebService()
        }
    }
    
    //MARK: Web Service
    func callDeleteAccountWebService() {
        
        let userData = UserDefaults.getUserData()
        
        var params = [String : String]()
        params = ["user_id" : userData?.UserId ?? ""]
        
        print("params = \(params)")
        self.showSpinner(onView: self.view)
        
        Alamofire.request(kDeleteMyAccount, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: nil).responseJSON { (responseData) in
            
            self.removeSpinner()
            print(responseData)
            
            switch responseData.result {
            case .success:
                
                if let data = responseData.result.value {
                    
                    let json = JSON(data)
                    //print(json)
                    
                    let responsModal = RegisterBaseClass.init(json: json)
                    
                    if responsModal.status == "success" {
                        
                        //if responsModal.data != nil {
                            
                            self.goOutFromApp()
                            
                        //}
                                                    
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
    
    func goOutFromApp() {
        
        self.tabBarController?.tabBar.isHidden = true
        
        CustomUserDefault.removeUserId()
        CustomUserDefault.removeLoginData()
        CustomUserDefault.removeUserName()
        CustomUserDefault.removeUserPassword()
        CustomUserDefault.removeTokenTime()
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let loginVC = mainStoryboard.instantiateViewController(withIdentifier: "IntroSplashVC") as! IntroSplashVC
        self.navigationController?.pushViewController(loginVC, animated: true)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}
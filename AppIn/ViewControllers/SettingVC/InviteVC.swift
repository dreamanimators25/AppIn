//
//  InviteVC.swift
//  AppIn
//
//  Created by sameer khan on 22/10/20.
//  Copyright © 2020 Sameer khan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class InviteVC: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var qrCodeImageView: UIImageView!
    @IBOutlet weak var txtFAccessCode: UITextField!
    @IBOutlet weak var txtFAddEmail: UITextField!
    @IBOutlet weak var emailTableView: UITableView!
    @IBOutlet weak var sendInviteBtn: UIButton!
    @IBOutlet weak var tableVwHeight: NSLayoutConstraint!
    @IBOutlet weak var inviteBtnHeight: NSLayoutConstraint!
    
    var arrEmailInvited = [String]()
    var strAccessCode : String = ""
    var strQrCode : String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setStatusBarColor()
        
        self.txtFAccessCode.text = self.strAccessCode
        
        if let url = URL(string: self.strQrCode) {
            self.qrCodeImageView.af_setImage(withURL: url)
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
    @IBAction func backBtnClicked(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func copyBtnClicked(_ sender: UIButton) {
        let vc = DesignManager.loadViewControllerFromSettingStoryBoard(identifier: "BottomViewVC") as! BottomViewVC
        vc.img = #imageLiteral(resourceName: "successTick")
        vc.lbl = "Access code has been copied to clipboard"
        vc.btn = ""
        
        vc.modalPresentationStyle = .overCurrentContext
        //vc.modalTransitionStyle = .crossDissolve
        
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func addEmailBtnClicked(_ sender: UIButton) {
        
        self.view.endEditing(true)
        
        if txtFAddEmail.text!.isEmpty {
            Alert.showAlert(strTitle: "", strMessage: "Please Enter E-mail Address", Onview: self)
        }
        else if(!Alert.isValidEmail(testStr: txtFAddEmail.text!)) {
            Alert.showAlert(strTitle: "", strMessage: "Please Enter Valid E-mail Address", Onview: self)
        }
        else {
            self.arrEmailInvited.append(txtFAddEmail.text!)
            self.emailTableView.reloadData()
            
            self.txtFAddEmail.text = ""
        }
    
    }
    
    @IBAction func sendInvitationBtnClicked(_ sender: UIButton) {
        self.view.endEditing(true)
        
        self.callInviteUsersWebService()
    }
    
    @IBAction func removeEmailBtnClicked(_ sender: UIButton) {
        let buttonPosition = sender.convert(CGPoint.zero, to: self.emailTableView)
        let indexPath = self.emailTableView.indexPathForRow(at:buttonPosition)
        self.arrEmailInvited.remove(at: indexPath?.row ?? -1)
        
        self.emailTableView.reloadData()
    }
    
    //MARK: UITableView DataSource & Delegates
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.arrEmailInvited.count == 0 {
            self.tableVwHeight.constant = 0
            self.inviteBtnHeight.constant = 0
        }else {
            self.tableVwHeight.constant = CGFloat((self.arrEmailInvited.count * 50))
            self.inviteBtnHeight.constant = 40
        }
        
        return self.arrEmailInvited.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let emailCell = tableView.dequeueReusableCell(withIdentifier: "emailCell", for: indexPath)
        let emailLbl : UILabel = emailCell.viewWithTag(10) as! UILabel
        emailLbl.text = self.arrEmailInvited[indexPath.row]
        
        return emailCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    //MARK: Web Service
    func callInviteUsersWebService() {
        
        let userData = UserDefaults.getUserData()
        
        var params = [String : Any]()
        
        let formattedArray = (self.arrEmailInvited.map{String($0)}).joined(separator: ",")
        
        params = ["user_id" : userData?.UserId ?? "",
                  "shortCode" : self.txtFAccessCode.text ?? "",
                  "invite_email" : formattedArray]
        
        print("params = \(params)")
        
        Alamofire.request(kInviteUsersURL, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: nil).responseJSON { (responseData) in
            
            print(responseData)
                        
            switch responseData.result {
            case .success:
                
                if let data = responseData.result.value {
                    
                    let json = JSON(data)
                    print(json)
                    
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

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}

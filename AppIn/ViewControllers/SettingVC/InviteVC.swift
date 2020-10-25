//
//  InviteVC.swift
//  AppIn
//
//  Created by sameer khan on 22/10/20.
//  Copyright © 2020 Sameer khan. All rights reserved.
//

import UIKit

class InviteVC: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var txtFAccessCode: UITextField!
    @IBOutlet weak var txtFAddEmail: UITextField!
    @IBOutlet weak var emailTableView: UITableView!
    @IBOutlet weak var sendInviteBtn: UIButton!
    @IBOutlet weak var tableVwHeight: NSLayoutConstraint!
    @IBOutlet weak var inviteBtnHeight: NSLayoutConstraint!
    
    var arrEmailInvited = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    //MARK: IBAction
    @IBAction func backBtnClicked(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func copyBtnClicked(_ sender: UIButton) {
    
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
        
        self.arrEmailInvited = []
        self.emailTableView.reloadData()
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

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}

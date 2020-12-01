//
//  ChannelsVC.swift
//  AppIn
//
//  Created by sameer khan on 21/06/20.
//  Copyright © 2020 Sameer khan. All rights reserved.
//

import UIKit
import Crashlytics
import Alamofire
import SwiftyJSON

var enableTabBarItems : ((_ cod : String) -> (Void))?

class ChannelsVC: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var channelTableView: UITableView!
    @IBOutlet weak var ErrorView: UIView!
    
    var arrRows = ["SAS","Uber","Air bnb"]
    
    var arrSelectedSection = [Int]()
    
    fileprivate let user = UserManager.sharedInstance.user
    fileprivate var ambassadorships: [Ambassadorship] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.callMyChannelWebService()
        
        //self.getAmbassadorshipsForUser()
        
        enableTabBarItems = { code in
            if let items = self.tabBarController?.tabBar.items {
                items.forEach { $0.isEnabled = true }
                
                guard code != "" else {
                    return
                }
                
                self.addChannel(Code: code)
            }
        }
        
    }
    
    //MARK: IBAction
    @IBAction func searchBtnClicked(_ sender: UIButton) {
        let vc = DesignManager.loadViewControllerFromChannelStoryBoard(identifier: "SearchChannelVC") as! SearchChannelVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func addChannelBtnClicked(_ sender: UIButton) {
        
        DispatchQueue.main.async {
            let vc = DesignManager.loadViewControllerFromChannelStoryBoard(identifier: "AddChannelPopUpVC") as! AddChannelPopUpVC
            
            vc.modalPresentationStyle = .overCurrentContext
            //vc.modalTransitionStyle = .crossDissolve
            
            self.present(vc, animated: true) {
                if let items = self.tabBarController?.tabBar.items {
                    items.forEach { $0.isEnabled = false }
                }
            }
            
        }
        
    }
    
    //MARK: UITableView DataSource & Delegates
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.arrRows.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if arrSelectedSection.contains(section) {
            return 3
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let brandCell = tableView.dequeueReusableCell(withIdentifier: "brandCell", for: indexPath)
            
            //let brandImg : UIImageView = brandCell.viewWithTag(10) as! UIImageView
            let titleLbl : UILabel = brandCell.viewWithTag(20) as! UILabel
            let arrowImg : UIImageView = brandCell.viewWithTag(30) as! UIImageView
            let seperatorLbl : UILabel = brandCell.viewWithTag(40) as! UILabel
            let countlLbl : UILabel = brandCell.viewWithTag(50) as! UILabel
            
            titleLbl.text = self.arrRows[indexPath.section]
            
            if arrSelectedSection.contains(indexPath.section) {
                arrowImg.transform = arrowImg.transform.rotated(by: .pi)
                seperatorLbl.isHidden = true
                
                countlLbl.text = "3"
                countlLbl.isHidden = false
            }else {
                arrowImg.transform = arrowImg.transform.rotated(by: .pi)
                seperatorLbl.isHidden = false
                
                countlLbl.text = ""
                countlLbl.isHidden = true
            }
            
            return brandCell
        }else {
            
            let channelCell = tableView.dequeueReusableCell(withIdentifier: "channelCell", for: indexPath)
            
            //let channelImg : UIImageView = channelCell.viewWithTag(10) as! UIImageView
            let subTitleLbl : UILabel = channelCell.viewWithTag(20) as! UILabel
            //let titleLbl : UILabel = channelCell.viewWithTag(30) as! UILabel
            //let arrowImg : UIImageView = channelCell.viewWithTag(40) as! UIImageView
            let seperatorlLbl : UILabel = channelCell.viewWithTag(50) as! UILabel
            let countlLbl : UILabel = channelCell.viewWithTag(60) as! UILabel
            
            if indexPath.row == self.arrRows.count - 1 {
                seperatorlLbl.isHidden = false
                subTitleLbl.isHidden = false
                subTitleLbl.text = "Partner"
                
                countlLbl.text = "3"
                countlLbl.isHidden = false
            }else {
                seperatorlLbl.isHidden = true
                subTitleLbl.isHidden = true
                
                countlLbl.text = ""
                countlLbl.isHidden = true
            }
            
            return channelCell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            
            if self.arrSelectedSection.contains(indexPath.section) {
                
                if let index = self.arrSelectedSection.firstIndex(of: (indexPath.section)) {
                    self.arrSelectedSection.remove(at: index)
                }
                
            }else {
                self.arrSelectedSection.append(indexPath.section)
            }
            
            self.channelTableView.reloadData()
            
        }else {
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        //return 60.0
        return 0.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let baseView = UIView.init(frame: CGRect.init(x: 0.0, y: 0.0, width: self.view.bounds.width, height: 60.0))
        
        let headImgView = UIImageView.init(frame: CGRect.init(x: 15.0, y: 5.0, width: 50.0, height: 50.0))
        headImgView.image = #imageLiteral(resourceName: "headSas")
        
        let titleLbl = UILabel.init(frame: CGRect.init(x: 80.0, y: 21.0, width: baseView.bounds.width - 90.0, height: 17.5))
        titleLbl.text = self.arrRows[section]
        
        let arrowImgView = UIImageView.init(frame: CGRect.init(x: baseView.bounds.width - 30.0, y: 24.5, width: 15.0, height: 10.0))
        arrowImgView.contentMode = .center
        arrowImgView.image = #imageLiteral(resourceName: "downArrow")
        
        /*
        if arrSelectedSection.contains(section) {
            arrowImgView.transform = arrowImgView.transform.rotated(by: .pi)
        }else {
            arrowImgView.transform = arrowImgView.transform.rotated(by: .pi)
        }*/
        
        let sepratLbl = UILabel.init(frame: CGRect.init(x: 15.0, y: 60.0, width: baseView.bounds.width - 30.0, height: 1.0))
        sepratLbl.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2)
        
        baseView.addSubview(headImgView)
        baseView.addSubview(titleLbl)
        baseView.addSubview(arrowImgView)
        baseView.addSubview(sepratLbl)
        
        baseView.tag = section
        
        let headerTapGesture = UITapGestureRecognizer()
        headerTapGesture.addTarget(self, action: #selector(headerTapped(_:)))
        baseView.addGestureRecognizer(headerTapGesture)
        
        return baseView
    }
    
    @objc func headerTapped(_ sender: UITapGestureRecognizer) {
        
        if self.arrSelectedSection.contains(sender.view?.tag ?? -1) {
            
            if let index = self.arrSelectedSection.firstIndex(of: (sender.view?.tag ?? -1)) {
                self.arrSelectedSection.remove(at: index)
            }
            
        }else {
            self.arrSelectedSection.append(sender.view?.tag ?? -1)
        }
        
        self.channelTableView.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
    
    //MARK: Web Service
    func callMyChannelWebService() {
        
        let userData = UserDefaults.getUserData()
        
        var params = [String : String]()
        params = ["user_id" : userData?.UserId ?? ""]
        
        print("params = \(params)")
        
        Alamofire.request(kGetMyChannelsURL, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: nil).responseJSON { (responseData) in
                        
            switch responseData.result {
            case .success:
                if let data = responseData.result.value {
                    let json = JSON(data)
                    print(json)
                    
                    
                    
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
    
    private func addChannel(Code:String) {
        
        let userData = UserDefaults.getUserData()
        
        var params = [String : String]()
        params = ["userId" : userData?.UserId ?? "",
                  "shortCode" : Code]
        
        print("params = \(params)")
        
        Alamofire.request(kAddChannelWithCodeURL, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: nil).responseJSON { (responseData) in
            
            switch responseData.result {
            case .success:
                if let data = responseData.result.value {
                    let json = JSON(data)
                    print(json)
                    
                    let vc = DesignManager.loadViewControllerFromSettingStoryBoard(identifier: "BottomViewVC") as! BottomViewVC
                    vc.img = #imageLiteral(resourceName: "successTick")
                    vc.lbl = "Channel was added"
                    vc.btn = ""
                    vc.modalPresentationStyle = .overCurrentContext
                    //vc.modalTransitionStyle = .crossDissolve
                    self.present(vc, animated: true, completion: nil)
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

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}

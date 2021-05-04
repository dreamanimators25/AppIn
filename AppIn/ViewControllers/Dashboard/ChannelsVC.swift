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
import AlamofireImage
import SwiftyJSON

var enableTabBarItems : ((_ cod : String) -> (Void))?

class ChannelsVC: UIViewController,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate {
    
    @IBOutlet weak var channelTableView: UITableView!
    @IBOutlet weak var ErrorView: UIView!
    @IBOutlet weak var txtFSearch: UITextField!
    @IBOutlet weak var lblChannel: UILabel!
    
    //var arrBrand = ["SAS","Uber","Air bnb"]
    var searchActive : Bool = false
    var arrSearchData = [AllBrandData]()
    var arrBrand : [AllBrandData]? = nil
    var arrBrandSelectedSection = [Int]()
    
    var brandData : AllBrandData? = nil
    
    fileprivate let user = UserManager.sharedInstance.user
    fileprivate var ambassadorships: [Ambassadorship] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setStatusBarColor()
        
        self.txtFSearch.addTarget(self, action: #selector(ChannelsVC.textFieldDidChange(_:)),
                                  for: UIControl.Event.editingChanged)
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
    
    // MARK: UITextField Delegates
    @objc func textFieldDidChange(_ textField: UITextField) {
        // filter tableViewData with textField.text
        
        let searchText  = textField.text
        
        //self.arrSearchData = (searchText?.isEmpty ?? false) ? self.arrCityData : self.arrCityData.filter { $0.strStateName?.range(of: searchText ?? "", options: .caseInsensitive) != nil
        //}
        
        self.arrSearchData = ((searchText?.isEmpty ?? false) ? self.arrBrand : self.arrBrand?.filter {
            $0.name?.range(of: searchText ?? "", options: .caseInsensitive) != nil
        }) ?? []
        
//        for item in self.arrBrand ?? [] {
//            let data = item.channel
//
//            self.arrSearchData = ((searchText?.isEmpty ?? false) ? data : data.filter {
//                $0.name?.range(of: searchText ?? "", options: .caseInsensitive) != nil
//            }) ?? []
//        }
                
        if(arrSearchData.count == 0){
            searchActive = false
            
            //self.ErrorView.isHidden = false
            //self.channelTableView.isHidden = true
        } else {
            searchActive = true
            
            //self.ErrorView.isHidden = true
            //self.channelTableView.isHidden = false
        }
        
        self.channelTableView.reloadData()
    }
    
    //MARK: IBAction
    @IBAction func searchBtnClicked(_ sender: UIButton) {
        //let vc = DesignManager.loadViewControllerFromChannelStoryBoard(identifier: "SearchChannelVC") as! SearchChannelVC
        //self.navigationController?.pushViewController(vc, animated: true)
        
        if sender.isSelected {
            sender.isSelected = !sender.isSelected
            self.lblChannel.isHidden = false
            self.txtFSearch.isHidden = true
            
            self.view.endEditing(true)
        }else {
            sender.isSelected = !sender.isSelected
            self.lblChannel.isHidden = true
            self.txtFSearch.isHidden = false
            
        }
        
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
        //return self.arrBrand?.count ?? 0
        
        guard (self.arrBrand?.count ?? 0) > 0 else {
            self.ErrorView.isHidden = false
            return 0
        }
        
        self.ErrorView.isHidden = true
        
        if(searchActive){
            return arrSearchData.count
        } else {
            return self.arrBrand?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                
        if(searchActive){
            
            if arrBrandSelectedSection.contains(section) {
                return (self.arrSearchData[section].channel?.count ?? 0) + 1
            }
            return 1
        
        }else {
            
            if arrBrandSelectedSection.contains(section) {
                return (self.arrBrand?[section].channel?.count ?? 0) + 1
            }
            return 1
            
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let brandCell = tableView.dequeueReusableCell(withIdentifier: "brandCell", for: indexPath)
            
            let brandImg : UIImageView = brandCell.viewWithTag(10) as! UIImageView
            let titleLbl : UILabel = brandCell.viewWithTag(20) as! UILabel
            let arrowImg : UIImageView = brandCell.viewWithTag(30) as! UIImageView
            let seperatorLbl : UILabel = brandCell.viewWithTag(40) as! UILabel
            let countlLbl : UILabel = brandCell.viewWithTag(50) as! UILabel
                        
            if(searchActive){
                brandData = self.arrSearchData[indexPath.section]
            }else {
                brandData = self.arrBrand?[indexPath.section]
            }
            
            //let channel = brandData?.channel
            //let channelData = channel?[indexPath.row]
            
            titleLbl.text = brandData?.name
            if let url = URL.init(string: brandData?.logo ?? "") {
                brandImg.af_setImage(withURL: url)
            }
            
            if arrBrandSelectedSection.contains(indexPath.section) {
                arrowImg.transform = arrowImg.transform.rotated(by: .pi)
                seperatorLbl.isHidden = true
                
                //countlLbl.text = "3"
                countlLbl.isHidden = true
            }else {
                arrowImg.transform = arrowImg.transform.rotated(by: .pi)
                seperatorLbl.isHidden = false
                
                countlLbl.text = ""
                countlLbl.isHidden = true
            }
            
            return brandCell
        }else {
            
            let channelCell = tableView.dequeueReusableCell(withIdentifier: "channelCell", for: indexPath)
            
            let channelImg : UIImageView = channelCell.viewWithTag(10) as! UIImageView
            let subTitleLbl : UILabel = channelCell.viewWithTag(20) as! UILabel
            let titleLbl : UILabel = channelCell.viewWithTag(30) as! UILabel
            //let arrowImg : UIImageView = channelCell.viewWithTag(40) as! UIImageView
            let seperatorlLbl : UILabel = channelCell.viewWithTag(50) as! UILabel
            let countlLbl : UILabel = channelCell.viewWithTag(60) as! UILabel
            
            if(searchActive){
                brandData = self.arrSearchData[indexPath.section]
            }else {
                brandData = self.arrBrand?[indexPath.section]
            }
            
            //let brandData = self.arrBrand?[indexPath.section]
            let channel = brandData?.channel
            let channelData = channel?[indexPath.row - 1]
            
            titleLbl.text = channelData?.name
            if let url = URL.init(string: channelData?.logo ?? "") {
                channelImg.af_setImage(withURL: url)
            }
            
            if indexPath.row == (self.arrBrand?.count ?? 0) - 1 {
                seperatorlLbl.isHidden = false
                subTitleLbl.isHidden = true
                //subTitleLbl.text = "Partner"
                
                //countlLbl.text = "3"
                countlLbl.isHidden = true
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
            
            if self.arrBrandSelectedSection.contains(indexPath.section) {
                
                if let index = self.arrBrandSelectedSection.firstIndex(of: (indexPath.section)) {
                    self.arrBrandSelectedSection.remove(at: index)
                }
                
            }else {
                self.arrBrandSelectedSection.append(indexPath.section)
            }
            
            self.channelTableView.reloadData()
            
        }else {
            self.view.endEditing(true)
            
            if (searchActive) {
                brandData = self.arrSearchData[indexPath.section]
            }else {
                brandData = self.arrBrand?[indexPath.section]
            }
            
            //let brandData = self.arrBrand?[indexPath.section]
            let channel = brandData?.channel
            let channelData = channel?[indexPath.row - 1]
                        
            if let load = loadChannel {
                AppDelegate.sharedDelegate().selChannelID = Int("\(channelData?.internalIdentifier ?? "")") ?? 0
                
                if let tabBarController = self.navigationController?.tabBarController {
                    tabBarController.selectedIndex = 1
                }
                
                load()
            }else {
                AppDelegate.sharedDelegate().selChannelID = Int("\(channelData?.internalIdentifier ?? "")") ?? 0
                
                if let tabBarController = self.navigationController?.tabBarController {
                    tabBarController.selectedIndex = 1
                }
            }
        
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
        
        let data = self.arrBrand?[section]
        titleLbl.text = data?.name
        
        let arrowImgView = UIImageView.init(frame: CGRect.init(x: baseView.bounds.width - 30.0, y: 24.5, width: 15.0, height: 10.0))
        arrowImgView.contentMode = .center
        arrowImgView.image = #imageLiteral(resourceName: "downArrow")
        
        /*
        if arrSelectedSection.contains(section) {
            arrowImgView.transform = arrowImgView.transform.rotated(by: .pi)
        }else {
            arrowImgView.transform = arrowImgView.transform.rotated(by: .pi)
        }
        */
        
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
        
        if self.arrBrandSelectedSection.contains(sender.view?.tag ?? -1) {
            
            if let index = self.arrBrandSelectedSection.firstIndex(of: (sender.view?.tag ?? -1)) {
                self.arrBrandSelectedSection.remove(at: index)
            }
            
        }else {
            self.arrBrandSelectedSection.append(sender.view?.tag ?? -1)
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
        
        self.showSpinner(onView: self.view)
        
        Alamofire.request(kGetChannelsURL, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: nil).responseJSON { (responseData) in
            
            self.removeSpinner()
            print(responseData)
            
            switch responseData.result {
            case .success:
                
                if let data = responseData.result.value {
                    
                    let json = JSON(data)
                    //print(json)
                    
                    let responsModal = AllBrandBaseClass.init(json: json)
                    
                    if responsModal.status == "success" {
                        
                        self.arrBrand = responsModal.data
                        self.channelTableView.reloadData()
                        
                        //self.ErrorView.isHidden = true
                        //self.channelTableView.isHidden = false
                                                    
                    }else{
                        Alert.showAlert(strTitle: "", strMessage: json["msg"].stringValue, Onview: self)
                        //self.ErrorView.isHidden = false
                        //self.channelTableView.isHidden = true
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
    
    private func addChannel(Code:String) {
        
        let userData = UserDefaults.getUserData()
        
        var params = [String : String]()
        
        params = ["user_id" : userData?.UserId ?? "",
                  "shortCode" : Code]
                
        print("params = \(params)")
        self.showSpinner(onView: self.view)
        
        Alamofire.request(kAddChannelWithCodeURL, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: nil).responseJSON { (responseData) in
            
            self.removeSpinner()
            print(responseData)
            
            switch responseData.result {
            case .success:
                
                if let data = responseData.result.value {
                    
                    let json = JSON(data)
                    print(json)
                    
                    let responsModal = RegisterBaseClass.init(json: json)
                    
                    if responsModal.status == "success" {
                        
                        //self.callMyChannelWebService()
                        
                        let vc = DesignManager.loadViewControllerFromSettingStoryBoard(identifier: "BottomViewVC") as! BottomViewVC
                        vc.img = #imageLiteral(resourceName: "successTick")
                        vc.lbl = "Channel was added"
                        vc.btn = ""
                        vc.modalPresentationStyle = .overCurrentContext
                        //vc.modalTransitionStyle = .crossDissolve
                        //self.present(vc, animated: true, completion: nil)
                        
                        self.present(vc, animated: true) {
                            self.callMyChannelWebService()
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

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}

//
//  ChannelsVC.swift
//  AppIn
//
//  Created by sameer khan on 21/06/20.
//  Copyright © 2020 Sameer khan. All rights reserved.
//

import UIKit
import Crashlytics

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
    
    //MARK: Custom Methods
    private func getAmbassadorshipsForUser() {
        AmbassadorshipManager.sharedInstance.getAmbassadorshipsForUser(user!.id, page: 1, pageSize: 20) { [weak self] (ambassadorships, error) in
            
            guard let self = self else { return }
            
            if let ambassadorships = ambassadorships {
                
                self.ambassadorships = ambassadorships
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    
                }
                
                guard !ambassadorships.isEmpty else { return }
                
            } else if let error = error {
                Crashlytics.sharedInstance().recordError(error)
            }
        }
    }
    
    private func addChannel(Code:String) {
        
        AmbassadorshipManager.sharedInstance.requestAmbassadorhipWithCode(Code) { (ambassadorship, error, code) in
            
            guard error == nil else {
                self.showAlertWithTitle(NSLocalizedString("Something went wrong.", comment: ""), message: nil, completion: {
                    
                })
                return
            }
            
            if let ambassadorship = ambassadorship {
                
                self.ambassadorships.append(ambassadorship)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {

                }
                      
            } else {
                self.showAlertWithTitle(NSLocalizedString("CONNECTION_CODE_DOES_NOT_EXISTS", comment: ""), message: nil, completion: {
                    
                })
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
            vc.modalPresentationStyle = .fullScreen
            vc.modalTransitionStyle = .crossDissolve
            
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
            return 2
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let channelCell = tableView.dequeueReusableCell(withIdentifier: "channelCell", for: indexPath)
        //let seperatorLbl : UILabel = channelCell.viewWithTag(30) as! UILabel
        
        return channelCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let baseView = UIView.init(frame: CGRect.init(x: 0.0, y: 0.0, width: self.view.bounds.width, height: 60.0))
        
        let headImgView = UIImageView.init(frame: CGRect.init(x: 15.0, y: 5.0, width: 50.0, height: 50.0))
        headImgView.image = #imageLiteral(resourceName: "headSas")
        
        let titleLbl = UILabel.init(frame: CGRect.init(x: 80.0, y: 21.0, width: baseView.bounds.width - 90.0, height: 17.5))
        titleLbl.text = self.arrRows[section]
        
        let arrowImgView = UIImageView.init(frame: CGRect.init(x: baseView.bounds.width - 30.0, y: 24.5, width: 15.0, height: 10.0))
        arrowImgView.contentMode = .center
        arrowImgView.image = #imageLiteral(resourceName: "upArrow")
        
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

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}

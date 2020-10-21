//
//  SearchChannelVC.swift
//  AppIn
//
//  Created by sameer khan on 20/10/20.
//  Copyright © 2020 Sameer khan. All rights reserved.
//

import UIKit

class SearchChannelVC: UIViewController,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate {

    @IBOutlet weak var channelTableView: UITableView!
    @IBOutlet weak var txtFieldSearchChannel: UITextField!
    @IBOutlet weak var searchChannelView: UIView!
    
    var arrRows = ["SAS","Uber","Air bnb"]
    var tableFilterData = [String]()
    
    var arrSelectedSection = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.txtFieldSearchChannel.addTarget(self, action: #selector(SearchChannelVC.textFieldDidChange(_:)),for: UIControl.Event.editingChanged)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.txtFieldSearchChannel.delegate = self
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
    
    //MARK: UITableView DataSource & Delegates
    func numberOfSections(in tableView: UITableView) -> Int {
        if self.tableFilterData.count == 0 {
            self.searchChannelView.isHidden = false
            self.channelTableView.isHidden = true
        }else {
            self.searchChannelView.isHidden = true
            self.channelTableView.isHidden = false
        }
        
        return self.tableFilterData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if arrSelectedSection.contains(section) {
            return 2
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let searchChannelCell = tableView.dequeueReusableCell(withIdentifier: "searchChannelCell", for: indexPath)
        //let seperatorLbl : UILabel = searchChannelCell.viewWithTag(30) as! UILabel
        
        return searchChannelCell
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
    
    // MARK: - UITextField Delegate
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        // filter tableViewData with textField.text
        
        let searchText  = textField.text ?? ""
        
        
//        tableFilterData = arrRows.filter({ (text) -> Bool in
//            let tmp: String = text as String
//            let range = tmp.range(of: searchText, options: .caseInsensitive)
//            //return range.location != NSNotFound
//            return (range != nil)
//        })
        
        
        
//        tableFilterData = searchText.isEmpty ? arrRows : arrRows.filter({(dataString: String) -> Bool in
//            // If dataItem matches the searchText, return true to include it
//            return dataString.range(of: searchText, options: .caseInsensitive) != nil
//        })
        
        
        let searchString = textField.text ?? ""
        
        // Filter the data array and get only those countries that match the search text.
        tableFilterData = arrRows.filter({ (country) -> Bool in
            let countryText: NSString = country as NSString
            
            return (countryText.range(of: searchString, options: NSString.CompareOptions.caseInsensitive).location) != NSNotFound
        })
        
        // Reload the tableview.
        self.channelTableView.reloadData()
        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}

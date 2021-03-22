//
//  AboutTblVC.swift
//  AppIn
//
//  Created by Sameer Khan on 17/02/21.
//  Copyright © 2021 Sameer khan. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON

class AboutTblVC: UITableViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
   
    @IBOutlet weak var aboutCollectionView: UICollectionView!
    @IBOutlet weak var aboutPageControl: UIPageControl!
    
    @IBOutlet weak var lblChannelHead: UILabel!
    @IBOutlet weak var lblChannelDesc: UILabel!
    @IBOutlet weak var lblBrandHead: UILabel!
    @IBOutlet weak var lblBrandDesc: UILabel!
    @IBOutlet weak var lblStreet: UILabel!
    @IBOutlet weak var lblCityState: UILabel!
    @IBOutlet weak var lblCountryPincode: UILabel!
    
    @IBOutlet weak var lblWhatsAppNo: UILabel!
    @IBOutlet weak var lblPrimaryNo: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblWebsite: UILabel!
    @IBOutlet weak var lblFbLink: UILabel!
    
    var arrOtherImg = [String]()
    var aboutData : AboutData? = nil
    var isComeFrom : String = ""
    var isID : String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.setStatusBarColor()

        if let id = self.isID {
            self.callGetChannelInfoWebService(id: id)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.tabBarController?.tabBar.isHidden = false
        
        self.loadThisTable()
    }
    
    //MARK: IBAction
    @IBAction func backBtnClicked(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func backGoogleMapClicked(_ sender: UIButton) {
        
        //let urlStr = "comgooglemaps://?saddr=&daddr=\("26.8549"),\("75.8243")&directionsmode=driving"
        
        if (UIApplication.shared.canOpenURL(NSURL(string:"comgooglemaps://")! as URL)) {
            
            let urlStr = "comgooglemaps://?saddr=&daddr=\(self.aboutData?.latitude ?? ""),\(self.aboutData?.longitude ?? "")&directionsmode=driving"
            
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(URL(string: urlStr)!, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(URL(string: urlStr)!)
            }
            
        } else {
            NSLog("Can't use comgooglemaps://")
            
            let urlStr = "http://maps.apple.com/maps?saddr=\(self.aboutData?.latitude ?? ""),\(self.aboutData?.longitude ?? "")"
            //let urlStr = "http://maps.apple.com/maps?saddr=\(26.8549),\(75.8243)"
            
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(URL(string: urlStr)!, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(URL(string: urlStr)!)
            }
            
        }
    
        
    }
    
    //MARK: UICollectionView DataSource & Delegates
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return self.aboutData?.otherImages?.count ?? 0
        return self.arrOtherImg.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let aboutCVCell = collectionView.dequeueReusableCell(withReuseIdentifier: "aboutCVCell", for: indexPath)
        
        let img : UIImageView = aboutCVCell.viewWithTag(10) as! UIImageView
        let strUrl = self.arrOtherImg[indexPath.item]
        
        if let url = URL.init(string: strUrl) {
            img.af_setImage(withURL: url)
        }
        
        return aboutCVCell
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.aboutPageControl.currentPage = indexPath.item
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
       
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.aboutCollectionView.bounds.width, height: self.aboutCollectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    //MARK: Web Service
    
    func callGetChannelInfoWebService(id : String) {
        
        var params = [String : String]()
        params = ["id" : id]
        
        print("params = \(params)")
        
        var strUrl = ""
        if isComeFrom == "Channel" {
            strUrl = kGetChannelInfoURL
        }else {
            strUrl = kGetBrandInfoURL
        }
        
        Alamofire.request(strUrl, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: nil).responseJSON { (responseData) in
                        
            //print(responseData)
            
            switch responseData.result {
            case .success:
                
                if let data = responseData.result.value {
                    
                    let json = JSON(data)
                    print(json)
                    
                    let responsModal = AboutBaseData.init(json: json)

                    if responsModal.status == "success" {
                        
                        self.aboutData = responsModal.data
                        
                        let arrStrImg = self.aboutData?.otherImages?.components(separatedBy: ",")
                        self.arrOtherImg = arrStrImg ?? []
                        
                        self.loadThisTable()
                        self.tableView.reloadData()

                    }else{
                        Alert.showAlert(strTitle: "", strMessage: "Error", Onview: self)
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
    
    // MARK: Custom Methods
    func loadThisTable() {
        
        if (self.aboutData?.otherImages) != nil {
            self.aboutCollectionView.reloadData()
        }
        
        if let val = self.aboutData?.descriptionValue {
            self.lblChannelDesc.text = val.htmlToString
        }
        
        if let val = self.aboutData?.disclaimer {
            self.lblBrandDesc.text = val.htmlToString
        }
        
        if let val = self.aboutData?.street {
            self.lblStreet.text = val
        }else {
            self.lblStreet.isHidden = true
        }
        
        var city = ""
        if self.aboutData?.city != nil {
            city = self.aboutData?.city ?? ""
        }
        
        var state = ""
        if self.aboutData?.state != nil {
            state = aboutData?.state ?? ""
        }
        
        if city != "" && state != "" {
            self.lblCityState.text = city + " " + state
        }else if city != "" {
            self.lblCityState.text = city
        }else if state != "" {
            self.lblCityState.text = state
        }else {
            self.lblCityState.isHidden = true
        }
        
        var country = ""
        if self.aboutData?.country != nil {
            country = self.aboutData?.country ?? ""
        }
        
        var zip = ""
        if self.aboutData?.zip != nil {
            zip = self.aboutData?.zip ?? ""
        }
        
        if country != "" && zip != "" {
            self.lblCountryPincode.text = country + " " + zip
        }else if city != "" {
            self.lblCountryPincode.text = country
        }else if state != "" {
            self.lblCountryPincode.text = zip
        }else {
            self.lblCountryPincode.isHidden = true
        }
        
        
        if let pNum = self.aboutData?.primaryNumber {
            self.lblPrimaryNo.text = pNum
        }else if let secNum = self.aboutData?.secondaryNumber {
            self.lblPrimaryNo.text = secNum
        }else {
            self.lblPrimaryNo.isHidden = true
        }
        
        if let wNum = self.aboutData?.wASupportNumber {
            self.lblWhatsAppNo.text = wNum
        }else {
            self.lblWhatsAppNo.isHidden = true
        }
        
        if let email = self.aboutData?.email {
            self.lblEmail.text = email
        }else {
            self.lblEmail.isHidden = true
        }
        
        if let web = self.aboutData?.website {
            self.lblWebsite.text = web
        }else {
            self.lblWebsite.isHidden = true
        }
        
        if let fb = self.aboutData?.fbLink {
            self.lblFbLink.text = fb
        }else {
            self.lblFbLink.isHidden = true
        }
        
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 6
    }
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...
        
        switch indexPath.row {
        case 0:
            
            if (self.aboutData?.otherImages) != nil {
                self.aboutCollectionView.reloadData()
            }
            
        case 1:
            
            if let val = self.aboutData?.descriptionValue {
                self.lblChannelDesc.text = val
            }
            
        case 2:
            
            if let val = self.aboutData?.disclaimer {
                self.lblBrandDesc.text = val
            }
            
        case 3:
            
            if let val = self.aboutData?.street {
                self.lblStreet.text = val
            }else {
                self.lblStreet.isHidden = true
            }
            
            var city = ""
            if self.aboutData?.city != nil {
                city = self.aboutData?.city ?? ""
            }
            
            var state = ""
            if self.aboutData?.state != nil {
                state = aboutData?.state ?? ""
            }
            
            if city != "" && state != "" {
                self.lblCityState.text = city + " " + state
            }else if city != "" {
                self.lblCityState.text = city
            }else if state != "" {
                self.lblCityState.text = state
            }else {
                self.lblCityState.isHidden = true
            }
            
            var country = ""
            if self.aboutData?.country != nil {
                country = self.aboutData?.country ?? ""
            }
            
            var zip = ""
            if self.aboutData?.zip != nil {
                zip = self.aboutData?.zip ?? ""
            }
            
            if country != "" && zip != "" {
                self.lblCountryPincode.text = country + " " + zip
            }else if city != "" {
                self.lblCountryPincode.text = country
            }else if state != "" {
                self.lblCountryPincode.text = zip
            }else {
                self.lblCountryPincode.isHidden = true
            }
            
        case 4:
            
            break
                        
        default:
            
            if let pNum = self.aboutData?.primaryNumber {
                self.lblPrimaryNo.text = pNum
            }else if let secNum = self.aboutData?.secondaryNumber {
                self.lblPrimaryNo.text = secNum
            }else {
                self.lblPrimaryNo.isHidden = true
            }
            
            if let wNum = self.aboutData?.wASupportNumber {
                self.lblWhatsAppNo.text = wNum
            }else {
                self.lblWhatsAppNo.isHidden = true
            }
            
            if let email = self.aboutData?.email {
                self.lblEmail.text = email
            }else {
                self.lblEmail.isHidden = true
            }
            
            if let web = self.aboutData?.website {
                self.lblWebsite.text = web
            }else {
                self.lblWebsite.isHidden = true
            }
            
            if let fb = self.aboutData?.fbLink {
                self.lblFbLink.text = fb
            }else {
                self.lblFbLink.isHidden = true
            }
            
        }
        

        //return cell
        return UITableViewCell()
    }*/
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            
            if (self.aboutData?.otherImages) != nil {
                return UITableView.automaticDimension
            }else {
                return 0
            }
            
        case 1:
            
            if (self.aboutData?.descriptionValue) != nil {
                return UITableView.automaticDimension
            }else {
                return 0
            }
            
        case 2:
            
            if (self.aboutData?.disclaimer) != nil {
                return UITableView.automaticDimension
            }else {
                return 0
            }
            
        case 3:
            
            if (self.aboutData?.street) != nil || self.aboutData?.city != nil || self.aboutData?.state != nil || self.aboutData?.country != nil || self.aboutData?.zip != nil {
                return UITableView.automaticDimension
            }else {
                return 0
            }
            
        case 4:
            
            if (self.aboutData?.latitude) != nil && (self.aboutData?.longitude) != nil {
                return UITableView.automaticDimension
            }else {
                return 0
            }
                        
        default:
            
            if (self.aboutData?.primaryNumber) != nil || self.aboutData?.secondaryNumber != nil || self.aboutData?.wASupportNumber != nil || self.aboutData?.email != nil || self.aboutData?.website != nil || self.aboutData?.fbLink != nil {
                return UITableView.automaticDimension
            }else {
                return 0
            }
            
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

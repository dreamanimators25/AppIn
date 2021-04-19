
//
//  DatePopUpVC.swift
//  AppIn
//
//  Created by sameer khan on 26/10/20.
//  Copyright © 2020 Sameer khan. All rights reserved.
//

import UIKit

class DatePopUpVC: UIViewController {
    
    @IBOutlet weak var txtFDate: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var setDate : ((_ date : String) -> (Void))?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss z"
        dateFormatter.dateStyle = DateFormatter.Style.short
        
        let datePickedStr = dateFormatter.string(from: Date())
                
        txtFDate.text = self.convertDateFormater(datePickedStr)
        datePicker.maximumDate = Date()
        
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
    
    //MARK: IBAction
    @IBAction func selectBtnClicked(_ sender: UIButton) {
        self.dismiss(animated: true) {
            if let date = self.setDate {
                date(self.txtFDate.text ?? "")
            }
        }
    }
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        let dt = sender.date
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss z"
        let str = dateFormatter.string(from: dt)
        
        txtFDate.text = self.convertDateFormater(str)
        //txtFDate.text = dateFormatter.string(from: sender.date)
        view.endEditing(true)
    }
    
    func convertDateFormater(_ date: String) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss z"
        let date = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date ?? Date())
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}

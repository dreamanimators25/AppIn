
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
    let dateFormatter = DateFormatter()

    override func viewDidLoad() {
        super.viewDidLoad()

        dateFormatter.dateFormat = "yyyy-mm-dd"
        dateFormatter.dateStyle = DateFormatter.Style.short
        let strDate = dateFormatter.string(from: datePicker.date)
        txtFDate.text = strDate
        datePicker.maximumDate = Date()
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
        txtFDate.text = dateFormatter.string(from: sender.date)
        view.endEditing(true)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}

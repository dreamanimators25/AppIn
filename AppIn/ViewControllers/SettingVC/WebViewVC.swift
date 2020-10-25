//
//  WebViewVC.swift
//  AppIn
//
//  Created by sameer khan on 21/06/20.
//  Copyright © 2020 Sameer khan. All rights reserved.
//

import UIKit
import WebKit

class WebViewVC: UIViewController, WKUIDelegate, WKNavigationDelegate {
    
    @IBOutlet weak var viewForWeb: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var webViewProgress: UIProgressView!
    
    var webView: WKWebView!
    var isComeFrom: String?
    var loadableUrlStr: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let str = isComeFrom {
            self.titleLbl.text = str
        }

        self.LoadWebView()
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
    
    //MARK: Custom Methods
    func LoadWebView() {
        webView = self.addWKWebView(viewForWeb: viewForWeb)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        let myURL = URL(string: loadableUrlStr ?? "")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        
        //add observer to get estimated progress value
        self.webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
    }
    
    //MARK: WKWebView Delegate
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!){
        
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        
    }
    
    //MARK: Observe value
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            print(self.webView.estimatedProgress)
            self.webViewProgress.progress = Float(self.webView.estimatedProgress)
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}

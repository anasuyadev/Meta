//
//  PrivacyPolicyViewController.swift
//  Meta
//
//  Created by Anasuya Dev on 06/02/22.
//

import UIKit
import WebKit

class PrivacyPolicyViewController: UIViewController {
    
    @IBOutlet var spinnerPP: UIActivityIndicatorView!
    let webView = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spinnerPP.startAnimating()
        view.addSubview(webView)
        
        guard let url = URL(string: "https://www.wipro.com/privacy-statement/") else {
            return
        }
        
        webView.load(URLRequest(url: url))
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        webView.frame = view.bounds
    }
//    override func viewWillAppear(_ animated: Bool) {
//        spinnerPP.startAnimating()
//    }
}

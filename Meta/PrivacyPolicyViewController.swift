//
//  PrivacyPolicyViewController.swift
//  Meta
//
//  Created by Anasuya Dev on 06/02/22.
//

import UIKit
import WebKit

class PrivacyPolicyViewController: UIViewController {
    
let webView = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
}

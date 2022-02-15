//
//  TermsAndConditionsViewController.swift
//  Meta
//
//  Created by Anasuya Dev on 07/02/22.
//

import UIKit
import WebKit

class TermsAndConditionsViewController: UIViewController {

    let webView = WKWebView()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            view.addSubview(webView)

            guard let url = URL(string: "https://careers.wipro.com/terms-of-use") else {
                return
            }
            webView.load(URLRequest(url: url))
        }
        override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            webView.frame = view.bounds
        }
}

//
//  PrivacyPolicyViewController.swift
//  Meta
//
//  Created by Anasuya Dev on 09/02/22.
//

import UIKit
import WebKit

class PrivacyPolicyViewController: UIViewController, WKNavigationDelegate {
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    let webView = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webView)
        guard let url = URL(string: "https://www.wipro.com/privacy-statement/") else {
            return
        }
        webView.load(URLRequest(url: url))
        webView.addSubview(spinner)
        spinner.startAnimating()
        
        webView.navigationDelegate = self
        spinner.hidesWhenStopped = true
       
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        spinner.stopAnimating()
}
}

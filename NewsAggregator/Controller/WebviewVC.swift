//
//  WebviewVC.swift
//  NewsAggregator

//  Created by Bakhtovar Umarov on 25/06/21.
//

import UIKit
import WebKit

class WebviewVC: UIViewController, WKNavigationDelegate, WKUIDelegate {
    var url : String? = nil
    let webView = WKWebView()
    
    var activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        webView.navigationDelegate = self
        webView.uiDelegate = self

        navigationController?.navigationBar.prefersLargeTitles = false
        view.addSubview(webView)
        
        activityIndicator.color = .red
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.isHidden = true
        
        view.addSubview(activityIndicator)
        
        guard let request = URL(string: url ?? "https://www.google.com") else {
            return
        }
    
        webView.load(URLRequest(url: request))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            activityIndicator.stopAnimating()
            activityIndicator.isHidden = true
        }
   
}

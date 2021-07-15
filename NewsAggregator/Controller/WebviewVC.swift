//
//  WebviewVC.swift
//  NewsAggregator

//  Created by Bakhtovar Umarov on 25/06/21.
//

import UIKit
import WebKit

class WebviewVC: UIViewController, WKNavigationDelegate, WKUIDelegate {
    var url : String? = nil
    var activityIndicator = UIActivityIndicatorView()
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var bookmarkButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        webView.navigationDelegate = self
        webView.uiDelegate = self

        navigationController?.navigationBar.prefersLargeTitles = false

        view.addSubview(webView)
        
        let image = UIImage(named: "bookmark") as UIImage?
       //bookmarkButton.setBackgroundImage(image, for: .normal, barMetrics: .default)
        
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
    
    @IBAction func buttonClicked(_ sender: Any) {
        
        
        
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

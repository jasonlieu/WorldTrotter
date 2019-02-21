//
//  webViewController2.swift
//  tempConverter
//
//  Created by Jason Lieu on 2/13/19.
//  Copyright © 2019 JasonApplication. All rights reserved.
//

import UIKit
import WebKit

class WebViewController2: UIViewController, WKNavigationDelegate {
    
    var webView : WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
        let urlstring: String = "https://www.google.com"
        let url = URL(string: urlstring)!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
        // Do any additional setup after loading the view.
}

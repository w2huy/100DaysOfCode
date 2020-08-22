//
//  WebViewController.swift
//  100DaysOfCode
//
//  Created by William Huynh on 8/22/20.
//  Copyright © 2020 wi2. All rights reserved.
//

import UIKit
import Parse
import WebKit

class WebViewController: UIViewController {

    @IBOutlet var webView: WKWebView!
    
    var entry = PFObject(className: "Entrys")
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        print()
        // Do any additional setup after loading the view.
        let myURL = URL(string: entry["github_url"]! as! String)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }

}

extension WebViewController: WKUIDelegate {
    
}

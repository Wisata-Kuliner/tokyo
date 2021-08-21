//
//  BrowserViewController.swift
//  goridepay
//
//  Created by Bryanza on 22/08/21.
//  Copyright © 2021 Apple Developer Academy. All rights reserved.
//

import UIKit
import WebKit

class BrowserViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var merchantWebView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupAddress()
    }
    
    func setupAddress() {
        merchantWebView.navigationDelegate = self
        let url = URL(string: "https://csui-bot-1.herokuapp.com/hello")!
        merchantWebView.load(URLRequest(url: url))
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

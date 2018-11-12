//
//  JCWebViewController.swift
//
//  Created by 江城 on 2018/10/25.
//  Copyright © 2018年 Arvin.shi. All rights reserved.
//

import UIKit
import Alamofire
@objc open class JCWebViewController: JCBaseViewController , UIWebViewDelegate{
    var urlStr : String?
    @IBOutlet weak var webview: UIWebView!
    
    override open func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override open func creatUI() {
        super.creatUI()
        do {
            if let url = try urlStr?.asURL() {
                showHudInView(view)
                webview.loadRequest(URLRequest.init(url: url))
            }
        } catch let error {
            JCLog(message: error.localizedDescription)
        }
    }
    private func webViewDidFinishLoad(_ webView: UIWebView) {
        JCLog(message: "")
        hideHud()
    }
    private func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        JCLog(message: error.localizedDescription)
        hideHud()
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

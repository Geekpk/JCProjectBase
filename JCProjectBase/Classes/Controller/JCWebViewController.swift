//
//  JCWebViewController.swift
//
//  Created by 江城 on 2018/10/25.
//  Copyright © 2018年 Arvin.shi. All rights reserved.
//

import UIKit
import Alamofire
class JCWebViewController: JCBaseViewController , UIWebViewDelegate{
    var urlStr : String?
    @IBOutlet weak var webview: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func creatUI() {
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
    func webViewDidFinishLoad(_ webView: UIWebView) {
        JCLog(message: "")
        hideHud()
    }
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
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

//
//  WebViewController.swift
//  FilmsProject
//
//  Created by iphonovv on 21.10.2020.
//

import UIKit
import WebKit
import SnapKit

class WebViewController: UIViewController, WKNavigationDelegate, LoadIndicatorPresentable {
    
    var indicator: UIActivityIndicatorView?
    var rootView: WKWebView?
    
    let url: URL
    
    init(url: URL) {
        self.url = url
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let webView = WKWebView()
        webView.navigationDelegate = self
        
        self.view = webView
        self.rootView = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.addIndicator()
        self.addRefreshButton()
        self.start()
    }
    
    private func addRefreshButton() {
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: self.rootView, action: #selector(self.rootView?.reload))
        self.navigationItem.rightBarButtonItem = refresh
    }
    
    private func start() {
        self.startAnimating()
        self.rootView?.load(URLRequest(url: self.url))
    }
    
    // MARK: WKNavigationDelegate
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        self.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.stopAnimating()
    }
}

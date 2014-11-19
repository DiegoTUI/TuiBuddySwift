//
//  AttractionInfoViewController.swift
//  TuiBuddySwift
//
//  Created by Diego Lafuente on 12/11/14.
//  Copyright (c) 2014 Tui Travel A&D. All rights reserved.
//

import UIKit

class AttractionInfoViewController: UIViewController, UIWebViewDelegate, NotificationHandler {
    
    var navigationTitle: String? = nil
    var url: String? = nil
    var shouldShow = true
    
    @IBOutlet weak var _webView: UIWebView!
    @IBOutlet weak var _activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // remove the title in the back button
        self.navigationController?.navigationBar.topItem?.title = ""
        // hide activity indicator when stopped
        _activityIndicator.hidesWhenStopped = true
        // set webViewDelegate
        _webView.delegate = self
        // set title and webview
        reloadData()
        // add "debug" button
        if config.debug {
            let debugButton = UIBarButtonItem(title: "Debug", style: .Plain, target: self, action: Selector("debugButtonClicked"))
            self.navigationItem.rightBarButtonItem = debugButton
        }
    }
    
    func reloadData() {
        // set title in navigation bar
        navigationItem.title = navigationTitle
        // load url
        _activityIndicator.startAnimating()
        //let cachePolicy: NSURLRequestCachePolicy = ReachabilityManager.sharedInstance.isInternetReachable! == true ? .ReturnCacheDataElseLoad: .ReturnCacheDataElseLoad
        //let cachePolicy: NSURLRequestCachePolicy = .ReloadIgnoringLocalCacheData
        //let request = NSURLRequest(URL: NSURL(string: url!)!, cachePolicy: cachePolicy, timeoutInterval: 10.0)
        let request = NSURLRequest(URL:NSURL(string: url!)!)
        _webView.loadRequest(request)
    }
    
    // MARK: - Actions
    
    func debugButtonClicked () {
        performSegueWithIdentifier("showDebug", sender: nil)
    }
    
    // MARK: - Notification Handler
    
    func handleNotificationForAttraction(attraction: Attraction) {
        navigationTitle = attraction.name
        url = attraction.url
        reloadData()
    }
    
    // MARK: - Webview delegate
    
    func webViewDidFinishLoad(webView: UIWebView) {
        _activityIndicator.stopAnimating()
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError) {
        _activityIndicator.stopAnimating()
    }
}

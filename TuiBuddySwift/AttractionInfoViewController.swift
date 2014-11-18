//
//  AttractionInfoViewController.swift
//  TuiBuddySwift
//
//  Created by Diego Lafuente on 12/11/14.
//  Copyright (c) 2014 Tui Travel A&D. All rights reserved.
//

import UIKit

class AttractionInfoViewController: UIViewController, NotificationHandler {
    
    var navigationTitle: String? = nil
    var url: String? = nil
    var shouldShow = true
    
    @IBOutlet weak var _webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // remove the title in the back button
        self.navigationController?.navigationBar.topItem?.title = ""
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
        _webView.loadRequest(NSURLRequest(URL: NSURL(string: url!)!))
    }
    
    // MARK: - Actions
    
    func debugButtonClicked () {
        println("debug button clicked")
    }
    
    // MARK: - Notification Handler
    
    func handleNotificationForAttraction(attraction: Attraction) {
        navigationTitle = attraction.name
        url = attraction.url
        reloadData()
    }
}

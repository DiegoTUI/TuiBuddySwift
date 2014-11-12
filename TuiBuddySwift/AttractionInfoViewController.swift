//
//  AttractionInfoViewController.swift
//  TuiBuddySwift
//
//  Created by Diego Lafuente on 12/11/14.
//  Copyright (c) 2014 Tui Travel A&D. All rights reserved.
//

import UIKit

class AttractionInfoViewController: UIViewController {
    
    var navigationTitle: String? = nil
    var url: String? = nil
    
    @IBOutlet weak var _webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // remove the title in the back button
        self.navigationController?.navigationBar.topItem?.title = ""
        // set title in navigation bar
        navigationItem.title = navigationTitle
        // load url
        _webView.loadRequest(NSURLRequest(URL: NSURL(string: url!)!))
        //_webView.loadRequest(NSURLRequest(URL: NSURL(string: "http://en.m.wikipedia.org/wiki/Palma_Cathedral")!))
    }
    

}

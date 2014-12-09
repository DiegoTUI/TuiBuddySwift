//
//  FactViewController.swift
//  TuiBuddySwift
//
//  Created by Diego Lafuente on 05/12/14.
//  Copyright (c) 2014 Tui Travel A&D. All rights reserved.
//

import UIKit

class FactPageViewController: UIViewController {
    //  layout constants
    let kDefaultOffset: CGFloat = 10.0
    let kBottomImageOffset: CGFloat = 20.0
    let kImageWidth: CGFloat = 300.0
    let kImageHeight: CGFloat = 400.0
    let kCloseButtonWidth: CGFloat = 30.0
    let kCloseButtonHeight: CGFloat = 30.0
    let kTitleLabelHeight: CGFloat = 30.0
    
    // the fact
    var fact: Fact? = nil
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if (fact != nil) {
            setupView()
        }
    }
    
    // MARK: Setup view
    
    func setupView () {
        let width: CGFloat = view.frame.size.width
        let height: CGFloat = view.frame.size.height
        // background color
        view.backgroundColor = kTransparentBlueColor
        // close button
        /*let closeButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
        closeButton.frame = CGRect(x: width - kDefaultOffset - 2.0*kCloseButtonWidth, y: kDefaultOffset, width: kCloseButtonWidth, height: kCloseButtonHeight)
        closeButton.setTitle("X", forState: UIControlState.Normal)
        closeButton.addTarget(self, action: "closeButtonClicked", forControlEvents: UIControlEvents.TouchUpInside)
        view.addSubview(closeButton)*/
        // title Label
        let kTitleLabelWidth: CGFloat = width - 2.0*kDefaultOffset - kCloseButtonWidth
        let titleLabel = UILabel(frame: CGRect(x: kDefaultOffset, y: kDefaultOffset, width: kTitleLabelWidth, height: kTitleLabelHeight))
        titleLabel.font = UIFont(name: kBoldFont, size: CGFloat(kH1FontSize))!
        titleLabel.textColor = kWhiteColor
        titleLabel.text = fact!.name
        view.addSubview(titleLabel)
        
        
    }
    
    // MARK: Actions
    func closeButtonClicked() {
        println("close!!")
    }
    
    
}

//MARK: - Equatable protocol

func == (left: FactPageViewController, right: FactPageViewController) -> Bool {
    return left.fact == right.fact 
}

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
    let kYellowTitleLabelHeight: CGFloat = 20.0
    
    // the fact
    var fact: Fact? = nil
    // the frame
    var frame: CGRect? = nil
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if (frame != nil) {
            view.frame = frame!
        }
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
        // title Label
        let kTitleLabelWidth: CGFloat = width - 2.0*kDefaultOffset - kCloseButtonWidth
        let titleLabel = UILabel(frame: CGRect(x: kDefaultOffset, y: kDefaultOffset, width: kTitleLabelWidth, height: kTitleLabelHeight))
        titleLabel.font = UIFont(name: kBoldFont, size: CGFloat(kH1FontSize))!
        titleLabel.textColor = kWhiteColor
        titleLabel.text = fact!.name
        view.addSubview(titleLabel)
        // yellow box
        // title
        let kYellowBoxWidth: CGFloat = width - 2.0*kDefaultOffset
        //let kYellowBoxWidth: CGFloat = 200.0
        let kYellowBoxY: CGFloat = titleLabel.frame.origin.y + kTitleLabelHeight
        let yellowTitleLabel = UILabel(frame: CGRect(x: kDefaultOffset, y: kYellowBoxY, width: kYellowBoxWidth, height: kYellowTitleLabelHeight))
        yellowTitleLabel.font = UIFont(name: kBoldFont, size: CGFloat(kH2FontSize))!
        yellowTitleLabel.textColor = kDarkBlueColor
        yellowTitleLabel.text = "Interesting Fact!"
        // text
        let yellowTextLabel = UILabel(frame: CGRect(x: kDefaultOffset, y: kYellowBoxY + kYellowTitleLabelHeight, width: kYellowBoxWidth, height: kYellowTitleLabelHeight))
        yellowTextLabel.font = UIFont(name: kRegularFont, size: CGFloat(kH2FontSize))!
        yellowTextLabel.textColor = kDarkBlueColor
        yellowTextLabel.lineBreakMode = .ByWordWrapping
        yellowTextLabel.numberOfLines = 0
        yellowTextLabel.text = fact!.text
        yellowTextLabel.sizeToFit()
        
        view.addSubview(yellowTitleLabel)
        view.addSubview(yellowTextLabel)
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

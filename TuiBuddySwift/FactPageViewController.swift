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
    let kHalfDefaultOffset: CGFloat = 5.0
    let kBottomImageOffset: CGFloat = 50.0
    let kImageWidth: CGFloat = 225.0
    let kImageHeight: CGFloat = 300.0
    let kCloseButtonWidth: CGFloat = 30.0
    let kCloseButtonHeight: CGFloat = 30.0
    let kTitleLabelHeight: CGFloat = 30.0
    let kYellowTitleLabelHeight: CGFloat = 20.0
    let kSwipeLabelHeight: CGFloat = 20.0
    
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
        // lower the size of the font if the string is truncated
        while (fact!.name.sizeWithAttributes([NSFontAttributeName: titleLabel.font]).width > titleLabel.bounds.size.width) {
            titleLabel.font = UIFont(name: kBoldFont, size: titleLabel.font.pointSize - 0.5)!
        }
        titleLabel.textColor = kWhiteColor
        titleLabel.text = fact!.name
        addShadowToLabel(titleLabel)
        view.addSubview(titleLabel)
        // yellow box
        // title
        let kLabelsWidth: CGFloat = width - 2.0*kDefaultOffset
        let kYellowBoxY: CGFloat = titleLabel.frame.origin.y + kTitleLabelHeight + kHalfDefaultOffset
        let yellowTitleLabel = UILabel(frame: CGRect(x: kDefaultOffset, y: kYellowBoxY, width: kLabelsWidth, height: kYellowTitleLabelHeight))
        yellowTitleLabel.font = UIFont(name: kBoldFont, size: CGFloat(kH2FontSize))!
        yellowTitleLabel.textColor = kDarkBlueColor
        yellowTitleLabel.text = "Interesting Fact!"
        // text
        let yellowTextLabel = UILabel(frame: CGRect(x: kDefaultOffset, y: kYellowBoxY + kYellowTitleLabelHeight, width: kLabelsWidth, height: kYellowTitleLabelHeight))
        yellowTextLabel.font = UIFont(name: kRegularFont, size: CGFloat(kH2FontSize))!
        yellowTextLabel.textColor = kDarkBlueColor
        yellowTextLabel.lineBreakMode = .ByWordWrapping
        yellowTextLabel.numberOfLines = 0
        yellowTextLabel.text = fact!.text
        yellowTextLabel.sizeToFit()
        // the yellow box itself
        let kYellowBoxWidth: CGFloat = width - 2.0*kHalfDefaultOffset
        let kYellowBoxHeight: CGFloat = kYellowTitleLabelHeight + yellowTextLabel.frame.height
        let yellowBoxView = UIView(frame: CGRect(x: kHalfDefaultOffset, y: kYellowBoxY, width: kYellowBoxWidth, height: kYellowBoxHeight + kHalfDefaultOffset))
        yellowBoxView.backgroundColor = kSandColor
        // add the views
        view.addSubview(yellowBoxView)
        view.addSubview(yellowTitleLabel)
        view.addSubview(yellowTextLabel)
        // swipe text label
        let kSwipeLabelY: CGFloat = yellowBoxView.frame.origin.y + kYellowBoxHeight + kHalfDefaultOffset
        let kSwipeLabelWidth = width - 2.0*kHalfDefaultOffset
        let swipeLabel = UILabel(frame: CGRect(x: kHalfDefaultOffset, y: kSwipeLabelY, width: kSwipeLabelWidth, height: kSwipeLabelHeight))
        swipeLabel.font = UIFont(name: kBoldFont, size: CGFloat(kH2FontSize))!
        swipeLabel.textColor = kWhiteColor
        swipeLabel.textAlignment = .Right
        swipeLabel.text = "Swipe for more"
        view.addSubview(swipeLabel)
        // Image view
        let kImageViewX: CGFloat = (width - kImageWidth) / 2.0
        let kImageViewY: CGFloat = height - kBottomImageOffset - kImageHeight
        let mainImageView = UIImageView(frame: CGRect(x: kImageViewX, y: kImageViewY, width: kImageWidth, height: kImageHeight))
        mainImageView.contentMode = .ScaleAspectFit
        mainImageView.image = UIImage(named: fact!.imageName)
        view.addSubview(mainImageView)
    }
    
    func addShadowToLabel(label: UILabel) {
        label.layer.shadowColor = kBlackColor.CGColor;
        label.layer.shadowOffset = CGSizeMake(0.0, 0.0);
        label.layer.shadowRadius = 3.0;
        label.layer.shadowOpacity = 0.5;
        label.layer.masksToBounds = false;
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

//
//  AttractionFactViewController.swift
//  TuiBuddySwift
//
//  Created by Diego Lafuente on 24/11/14.
//  Copyright (c) 2014 Tui Travel A&D. All rights reserved.
//

import UIKit
import AVFoundation

class AttractionFactViewController: UIViewController {
    // layout constants
    let kResourceViewWidth = 133
    let kResourceViewHeight = 100
    let kVerticalOffsetWithDescriptionLabel = 20
    
    private struct StaticStruct { static var _factIterator: FactIterator? = nil }
    
    class var factIterator: FactIterator? {
        get {return StaticStruct._factIterator}
        set {StaticStruct._factIterator = newValue}
    }
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var actionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.addSwipeGestureRecognizers()
    }
    
    func setupView() {
        var currentFact = AttractionFactViewController.factIterator?.current()
        let title = currentFact?.id == nil ? "" : "\(currentFact!.id)"
        let description = currentFact?.text == nil ? "" : "\(currentFact!.text)"
        // set title in navigation bar
        navigationItem.title = "Fact #\(title)"
        // set description
        descriptionLabel.text = description
        // set the view for the given resource
        setupResourceForFact(currentFact)
        // show/hide shakeLabel
        actionLabel.hidden = AttractionFactViewController.factIterator == nil || !AttractionFactViewController.factIterator!.isNext()
    }
    
    func setupResourceForFact(fact: Fact?) {
        if let theFact = fact {
            switch theFact.type {
            case "video":
                println("video")
                /*var player:AVPlayer!
                var playerItem:AVPlayerItem!;
                var avPlayerLayer:AVPlayerLayer = AVPlayerLayer(player: player)
                avPlayerLayer.frame = CGRectMake(20, 300, kResourceViewWidth, kResourceViewHeight)
                self.view.layer .addSublayer(avPlayerLayer)
                var steamingURL:NSURL = NSURL(string:playerURL)
                player = AVPlayer(URL: steamingURL)
                player.play()*/
                
            case "image":
                println("image")
            default:
                break;
            }
        }
    }
    
    func addSwipeGestureRecognizers() {
        var rightSwipeRecognizer = UISwipeGestureRecognizer(target: self, action: "handleRightSwipe")
        rightSwipeRecognizer.direction = .Left
        var leftSwipeRecognizer = UISwipeGestureRecognizer(target: self, action: "handleLeftSwipe")
        leftSwipeRecognizer.direction = .Right
        
        self.view.addGestureRecognizer(rightSwipeRecognizer)
        self.view.addGestureRecognizer(leftSwipeRecognizer)
    }
    
    // MARK: - Swiping -
    
    func handleRightSwipe() {
        println("right swipe")
        // push a new view controller into the Navigation View Controller if there is a nextFact
        if let nextFact = AttractionFactViewController.factIterator?.next() {
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            var destinationViewController = storyBoard.instantiateViewControllerWithIdentifier("attractionFactViewController") as AttractionFactViewController
            self.navigationController?.pushViewController(destinationViewController, animated: true)
        }
    }
    
    func handleLeftSwipe() {
        println("left swipe")
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    // MARK: - Back button -
    
    override func willMoveToParentViewController(parent: UIViewController?) {
        if (parent == nil) {
            println("back button clicked")
            AttractionFactViewController.factIterator?.prev()
        }
    }

    // MARK: - Actions -
    
    @IBAction func closeButtonClicked(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}

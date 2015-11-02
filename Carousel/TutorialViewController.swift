//
//  TutorialViewController.swift
//  Carousel
//
//  Created by Jason Cashdollar on 11/1/15.
//  Copyright © 2015 Jason Cashdollar. All rights reserved.
//

import UIKit

class TutorialViewController: UIViewController, UIScrollViewDelegate{

    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var backupButton: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentSize = CGSize(width: 1280, height: 568)
        scrollView.delegate = self
        backupButton.alpha = 0
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        // Get the current page based on the scroll offset
        let page : Int = Int(round(scrollView.contentOffset.x / 320))
        
        // Set the current page, so the dots will update
        if page == 3 {
            pageControl.hidden = true
            
            UIView.animateWithDuration(1, animations: {
                self.backupButton.alpha = 1.0
            })
            
        } else{
            pageControl.currentPage = page
            pageControl.hidden = false
        }
    }

}
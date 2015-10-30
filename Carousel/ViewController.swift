//
//  ViewController.swift
//  Carousel
//
//  Created by Jason Cashdollar on 10/27/15.
//  Copyright © 2015 Jason Cashdollar. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {

    // scroll variables
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    // tile images
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    @IBOutlet weak var imageView4: UIImageView!
    @IBOutlet weak var imageView5: UIImageView!
    @IBOutlet weak var imageView6: UIImageView!
    // tile transformations
    var yOffsets : [CGFloat] =  [-285, -240, -400, -390, -500, -480]
    var xOffsets : [CGFloat] =  [-80, 30, 10, 80, -120, -100]
    var scales : [CGFloat] =    [1, 1.65, 1.7, 1.6, 1.65, 1.65]
    var rotations : [CGFloat] = [-10, -10, 10, 10, 10, -10]
    
    var tiles : [UIImageView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        scrollView.contentSize = imageView.image!.size
        scrollView.showsVerticalScrollIndicator = false
        // not sure what this does
        scrollView.delegate = self
        
        // fill the tile array
        tiles = [imageView1, imageView2, imageView3, imageView4, imageView5, imageView6]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func scrollViewDidScroll(scrollView: UIScrollView){
        let offset = scrollView.contentOffset.y
        
        for index in 0...5 {
            
            let tx = convertValue(offset, r1Min: 0, r1Max: 568, r2Min: xOffsets[index], r2Max: 0)
            let ty = convertValue(offset, r1Min: 0, r1Max: 568, r2Min: yOffsets[index], r2Max: 0)
            let scale = convertValue(offset, r1Min: 0, r1Max: 568, r2Min: scales[index], r2Max: 1)
            let rotation = convertValue(offset, r1Min: 0, r1Max: 568, r2Min: rotations[index], r2Max: 0)
            
            tileTransform(tiles[index], tx: tx, ty: ty, scale: scale, rotation: rotation)
        }
    }
    
    func tileTransform (tile: UIImageView!, tx: CGFloat!, ty: CGFloat!, scale: CGFloat!, rotation: CGFloat!) {
        
        tile.transform = CGAffineTransformMakeTranslation(tx, ty)
        tile.transform = CGAffineTransformScale(tile.transform, scale, scale)
        tile.transform = CGAffineTransformRotate(tile.transform, rotation * CGFloat(M_PI / 180))
    }
}
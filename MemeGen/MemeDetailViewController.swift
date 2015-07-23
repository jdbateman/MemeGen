//
//  MemeDetailViewController.swift
//  MemeGen
//
//  Created by john bateman on 6/9/15.
//  Copyright (c) 2015 John Bateman. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {

    var meme: Meme?
    @IBOutlet var memedUIImageView: UIImageView!
    @IBOutlet var topLabel: UILabel!
    @IBOutlet var bottomLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "rotated", name: UIDeviceOrientationDidChangeNotification, object: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        updateLabels()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func rotated()
    {
        if(UIDeviceOrientationIsLandscape(UIDevice.currentDevice().orientation))
        {
            println("landscape")

        }

        if(UIDeviceOrientationIsPortrait(UIDevice.currentDevice().orientation))
        {
            println("Portrait")

        }
        
        updateLabels()
        
//        self.collectionView.setNeedsDisplay()
//        self.view.setNeedsDisplay()
//        self.collectionView.reloadData()
//
//        dispatch_async(dispatch_get_main_queue(), {
//            self.collectionView.setNeedsDisplay()
//            self.view.setNeedsDisplay()
//            self.collectionView.reloadData()
//        })


//        dispatch_async(dispatch_get_main_queue(), {
//            (self.collectionView.reloadData())
//        })
    }
    
    func updateLabels() {
        if let theMeme = meme {
            var anImage:UIImage?
            anImage = theMeme.memedImage
            if let img = anImage {
                if (memedUIImageView != nil) {
                    memedUIImageView.image = img
                }
            }
            
            //            let attrifont:UIFont = UIFont(name: "HelveticaNeue-CondensedBlack", size: 40.0)!
            //            let attriString = NSMutableAttributedString(string:theMeme.topText, attributes:
            //                [
            //                    NSForegroundColorAttributeName: UIColor.whiteColor(),
            //                    NSStrokeColorAttributeName: UIColor.blackColor(),
            //                    NSStrokeWidthAttributeName: 1,
            //                    NSFontAttributeName: attrifont
            //                ])
            
            // apply the meme text to the labels
//            self.topLabel.font = UIFont(name: "HelveticaNeue-CondensedBlack", size: 40.0)
//            self.topLabel.text = theMeme.topText
//            self.bottomLabel.font = UIFont(name: "HelveticaNeue-CondensedBlack", size: 40.0)
//            self.bottomLabel.text = theMeme.bottomText
            
            //TODO - this code is incorrect. The imageHeight is not scaled to the UIImageView yet (it is > 1900!). There must be an easier way! Am I supposed to display the memed image here?
            
            // position the labels based on top and bottom of the image view
//            if let imageHeight = self.memedUIImageView.image?.size.height {
//                let topOffset = (self.memedUIImageView.frame.height - imageHeight)/2
//                self.topLabel.frame.origin.y = self.memedUIImageView.frame.origin.y + topOffset + 10
//                self.bottomLabel.frame.origin.y = self.memedUIImageView.frame.origin.y + self.memedUIImageView.frame.height - topOffset - 10
//            }
        }
    }
}

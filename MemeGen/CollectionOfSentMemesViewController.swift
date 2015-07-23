//
//  CollectionOfSentMemesViewController.swift
//  MemeGen
//
//  Created by john bateman on 6/9/15.
//  Copyright (c) 2015 John Bateman. All rights reserved.
//

import UIKit

private let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)

class CollectionOfSentMemesViewController: UICollectionViewController {

    var memes: [Meme]!

    @IBOutlet var theCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //memes = (UIApplication.sharedApplication().delegate as AppDelegate).memes
        
        theCollectionView.dataSource = self
        theCollectionView.delegate = self
        
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: "rotated", name: UIDeviceOrientationDidChangeNotification, object: nil)
    }

//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
    
    override func viewWillAppear(animated: Bool) {
        // get a reference to the memes collection
        memes = (UIApplication.sharedApplication().delegate as! AppDelegate).memes
        
        // TODO - QUESTION - I don't understand why I have to add this line to get the collection view data source protocol methods to be called when subesequent memes are added to the memes collection. I don't have to do this in my table view controller.
        self.theCollectionView.reloadData()
        
        //TODO - remove... self.view.setNeedsDisplay();
        
    }
    
    // MARK: UICollectionViewDataSource protocol

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MemeCollectionCellID", forIndexPath: indexPath) as! MemesCell
        
        let meme = self.memes[indexPath.row]
        
        //cell.memeLabel.text = meme.topText
        cell.memedImageView.image = meme.originalImage
        
//        var topString = meme.topText
//        var strokeString = NSMutableAttributedString(string: topString, attributes: [NSFontAttributeName:UIFont(name: "HelveticaNeue-CondensedBlack", size: 40.0)!])
//        strokeString.addAttribute(NSStrokeColorAttributeName, value: UIColor.blackColor())
//        strokeString.addAttribute(NSStrokeWidthAttributeName, value: 1)
//        strokeString.addAttribute(NSForegroundColorAttributeName, value: UIColor.whiteColor())
//        cell.topLabel.attributedText = strokeString
        
        // TODO - I don't appear to be using this code anymore
        let attrifont:UIFont = UIFont(name: "HelveticaNeue-CondensedBlack", size: 40.0)!
        let attriString = NSMutableAttributedString(string:meme.topText, attributes:
            [
                NSForegroundColorAttributeName: UIColor.whiteColor(),
                NSStrokeColorAttributeName: UIColor.blackColor(),
                NSStrokeWidthAttributeName: 1,
                NSFontAttributeName: attrifont
            ])
        //let secondAttributes = [NSForegroundColorAttributeName: UIColor.redColor(), NSBackgroundColorAttributeName: UIColor.blueColor(), NSStrikethroughStyleAttributeName: 1]
        //attriString.addAttributes(secondAttributes, range: string.rangeOfString(meme.topText)) // add some attributes to the entire range of the string
//        cell.topLabel.attributedText = attriString
//        cell.bottomLabel.attributedText = attriString
        
        // apply the meme text to the labels
        cell.topLabel.text = meme.topText
        cell.bottomLabel.text = meme.bottomText
        
        // TODO: remove this line
        cell.backgroundColor = UIColor.redColor()
        
        // This code is for using the default custom cell in storyboard
        // Set the name and image
        //cell.textLabel.text = villain.name
        //        var img: UIImage = UIImage(named: villain.imageName)!
        //        var imgView = UIImageView(image: img) as UIImageView
        //        cell.addSubview(imgView)
        
        // This code is for using the customized custom cell in storyboard
//        var img: UIImage = UIImage(named: villain.imageName)!
//        cell.villainImage.image = img
//        cell.villainLabel.text = villain.name
        
        // If the cell has a detail label, we will put the evil scheme in.
        //        if let detailTextLabel = cell.detailTextLabel {
        //            detailTextLabel.text = "Scheme: \(villain.evilScheme)"
        //        }
        
        
//        cell.setNeedsDisplay()
        
        return cell
    }
    
    
    // MARK: UICollectionViewDelegate protocol
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        // display detail view controller for the selected meme
        let controller = self.storyboard!.instantiateViewControllerWithIdentifier("MemeDetailViewControllerID")! as! MemeDetailViewController
        //        println("indePath.row = \(indexPath.row)")
        //        println("controller.meme = \(self.memes[indexPath.row])")
        controller.meme = self.memes[indexPath.row]
        self.navigationController!.pushViewController(controller, animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func onAddButton(sender: UIBarButtonItem) {
        self.displayMemeEditor()
    }
    
    func displayMemeEditor() {
        var storyboard = UIStoryboard (name: "Main", bundle: nil)
        //var memeEditorVC = storyboard.instantiateViewControllerWithIdentifier("MemeEditorViewControllerID") as ViewController
        var NavController = storyboard.instantiateViewControllerWithIdentifier("NavigationControllerForMemeEditorViewControllerID") as! UINavigationController
        //self.navigationController?.pushViewController(memeEditorVC, animated: true) // remove with opViewControllerAnimated:
        self.presentViewController(NavController, animated: true, completion: nil); // remove with dismissViewControllerAnimated(true, completion: nil)
    }

//    func rotated()
//    {
//        if(UIDeviceOrientationIsLandscape(UIDevice.currentDevice().orientation))
//        {
//            println("landscape")
//            
//        }
//        
//        if(UIDeviceOrientationIsPortrait(UIDevice.currentDevice().orientation))
//        {
//            println("Portrait")
//            
//        }
//        self.collectionView.setNeedsDisplay()
//        self.view.setNeedsDisplay()
//        self.collectionView.reloadData()
//        
//        dispatch_async(dispatch_get_main_queue(), {
//            self.collectionView.setNeedsDisplay()
//            self.view.setNeedsDisplay()
//            self.collectionView.reloadData()
//        })
//        
//        
////        dispatch_async(dispatch_get_main_queue(), {
////            (self.collectionView.reloadData())
////        })
//    }
    
}



//extension CollectionOfSentMemesViewController : UICollectionViewDelegateFlowLayout {
//    
//    func collectionView(collectionView: UICollectionView,
//        layout collectionViewLayout: UICollectionViewLayout,
//        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
//            
//            let meme = self.memes[indexPath.row]
//            
//            var size = meme.memedImage.size
//
////                size.width += 10
////                size.height += 10
//            return CGSize(width: 180, height:140)
//
//            //return CGSize(width: 100, height: 100)
//    }
//    
//    
//    func collectionView(collectionView: UICollectionView,
//        layout collectionViewLayout: UICollectionViewLayout,
//        insetForSectionAtIndex section: Int) -> UIEdgeInsets {
//            return sectionInsets
//    }
//}

// insert an item into the Collection
//let insertIndexPath = NSIndexPath(forItem: oldValue.count - 1, inSection: 0)
//uiCollectionView.insertItemsAtIndexPaths([insertIndexPath])

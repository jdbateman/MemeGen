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
        
        // Add Delete and Edit right bar button items
        let button1 = UIBarButtonItem(barButtonSystemItem: .Edit, target: self, action: "onEditButtonTap")
        let button2 = UIBarButtonItem(barButtonSystemItem: .Trash, target: self, action: "onDeleteButtonTap")
        
        //let button2 = UIBarButtonItem(image: UIImage(named: "pin"), style: .Plain, target: self, action: "onDeleteButtonTap")
        navigationItem.leftItemsSupplementBackButton = true
        navigationItem.setRightBarButtonItems([button1, button2], animated: true)
    }
    
    override func viewWillAppear(animated: Bool) {
        drawMeme()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: button handlers
    
    /* The Edit button was selected. Present the Meme Edit view initialized to the current meme. */
    func onEditButtonTap() {
        // Present the meme edit view
        var storyboard = UIStoryboard (name: "Main", bundle: nil)
        var controller = storyboard.instantiateViewControllerWithIdentifier("NavigationControllerForMemeEditorViewControllerID") as! UINavigationController
        (controller.viewControllers.first as! ViewController).meme = self.meme
        presentViewController(controller, animated: true, completion: nil)
        
        // navigate back to the parent VC
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    /* The Delete button was selected. Remove the meme from the memes collection. */
    func onDeleteButtonTap() {
        // get a copy of the primary memes collection (which is a struct)
        var memeArray : [Meme] = (UIApplication.sharedApplication().delegate as! AppDelegate).memes
        
        // remove the current meme from the copy of the memes collection
        memeArray = memeArray.filter{
            if $0 == self.meme {
                return false // skip it
            } else {
                return true // keep it
            }
        }
        
        // copy the reduced array back to the primary memes collection
        (UIApplication.sharedApplication().delegate as! AppDelegate).memes = memeArray
        
        // navigate back to the parent VC
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    // MARK: helper functions
    
    /* handler for UIDeviceOrientationDidChangeNotification. Redraw the meme. */
    func rotated()
    {        
        drawMeme()
    }
    
    /* Redraw the Meme's image and labels. */
    func drawMeme() {
        if let theMeme = meme {
            var anImage:UIImage?
            anImage = theMeme.memedImage
            if let img = anImage {
                if (memedUIImageView != nil) {
                    memedUIImageView.image = img
                }
            }            
        }
    }
}

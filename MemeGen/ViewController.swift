//
//  ViewController.swift
//  MemeGen
//
//  Created by john bateman on 6/4/15.
//  Copyright (c) 2015 John Bateman. All rights reserved.
//
//  This file implements the Meme Editor view controller.

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate  {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var albumButton: UIBarButtonItem!
    @IBOutlet var cameraButton: UIBarButtonItem!
    @IBOutlet var topTextField: UITextField!
    @IBOutlet var bottomTextField: UITextField!
    @IBOutlet var toolbar: UIToolbar!
    @IBOutlet var shareButton: UIBarButtonItem!
    @IBOutlet var cancelButton: UIBarButtonItem!
    
    var meme: Meme?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // set the UITextTfieldDelegate to self
        self.topTextField.delegate = self
        self.bottomTextField.delegate = self

        // init the text field text
        self.topTextField.text = "TOP"
        self.bottomTextField.text = "BOTTOM"

        
        // set the text field attributes to be all caps, white with a black outline.
        let memeTextAttributes = [
            NSStrokeColorAttributeName : UIColor.blackColor(),
            NSForegroundColorAttributeName : UIColor.whiteColor(),
            NSBackgroundColorAttributeName : UIColor.clearColor(),
            NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSStrokeWidthAttributeName : -3.0
        ]
        topTextField.defaultTextAttributes = memeTextAttributes
        bottomTextField.defaultTextAttributes = memeTextAttributes
        
        // center align the text
        self.topTextField.textAlignment = NSTextAlignment.Center
        self.bottomTextField.textAlignment = NSTextAlignment.Center
        
        // make label background transparent
        topTextField.backgroundColor = UIColor.clearColor();
        bottomTextField.backgroundColor = UIColor.clearColor()
        
        // hide label border
        //topTextField.layer.borderWidth = 0;
        //topTextField.layer.borderColor = UIColor.clearColor().CGColor
        //bottomTextField.layer.borderWidth = 0;
        //bottomTextField.layer.borderColor = UIColor.clearColor().CGColor
        
        topTextField.borderStyle = UITextBorderStyle.None
        bottomTextField.borderStyle = UITextBorderStyle.None
        
        // set capitalization for all characters
        topTextField.autocapitalizationType = UITextAutocapitalizationType.AllCharacters
    }
    
//    override func viewDidLayoutSubviews() {
//        let border = CALayer()
//        let width = CGFloat(0.0)
//        border.borderColor = UIColor.clearColor().CGColor
//        border.frame = CGRect(x: 0, y: bottomTextField.frame.size.height - width, width:  bottomTextField.frame.size.width, height: bottomTextField.frame.size.height)
//        
//        border.borderWidth = width
//        bottomTextField.layer.addSublayer(border)
//        bottomTextField.layer.masksToBounds = true
//    }

    override func viewWillAppear(animated: Bool) {
        
        // subscribe to keyboard notifications
        self.subscribeToKeyboardNotifications()
        
        // enable image picker buttons based on available image sources on this device
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
            albumButton.enabled = true
        } else {
            albumButton.enabled = false
        }
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            cameraButton.enabled = true
        } else {
            cameraButton.enabled = false
        }
        
        // set imageView to width and height of screen
        //self.imageView.frame = CGRectMake(0,0,self.view.frame.width,imageView.frame.height)
        
        // set state of share button
        self.toggleShareButton()
        
        // ensure labels are drawn on top of image if a new image has been loaded
//        self.view.bringSubviewToFront( self.topTextField)
//        self.view.bringSubviewToFront( self.bottomTextField)
        
//        self.view.setNeedsDisplay();
    }
    
    // enable or disable share button based on presence of valid memed image
    func toggleShareButton() {
        let memedImage = self.imageView.image as UIImage?
        if let image = memedImage {
            self.shareButton.enabled = true
        }
        else {
            self.shareButton.enabled = false
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.unsubscribeFromKeyboardNotifications()
    }
    
    // pick an image from the photo album
    @IBAction func onAlbumButton(sender: UIBarButtonItem) {
        self.presentImagePicker(UIImagePickerControllerSourceType.PhotoLibrary)
    }
    
    // pick an image from the camera
    @IBAction func onCameraButton(sender: UIBarButtonItem) {
        self.presentImagePicker(UIImagePickerControllerSourceType.Camera)
    }
    
    @IBAction func onShare(sender: AnyObject) {

        // create the memed image
        let memedImage: UIImage? = generateMemedImage()
        
        // pass memedImage to a UIAcitivityViewController
        if let memedImg = memedImage {
            let controller = UIActivityViewController(activityItems: [memedImg], applicationActivities: nil)
            controller.completionWithItemsHandler = {
                (s: String!, ok: Bool, items: [AnyObject]!, err:NSError!) -> Void in
                // save the Meme
                self.saveMeme() //println("completed \(s) \(ok) \(items) \(err)")
                
                // dismiss the meme editor view controller (the activity view controller has already been dismissed)
                self.dismissViewControllerAnimated(true, completion: nil)
//                if let navController = self.navigationController {
//                    navController.popViewControllerAnimated(true)
//                }
            }
//            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
//                presentViewController(controller, animated: true, completion: nil)
//            }
            
            if controller.respondsToSelector(Selector("popoverPresentationController")) {
                // iOS 8 iPad
                if let wPPC = controller.popoverPresentationController {
                    wPPC.sourceView = self.view
                    presentViewController( controller, animated: true, completion: nil )
                } else {  // iOS 8 iPhone
                    presentViewController(controller, animated: true, completion: nil)
                //controller.popoverPresentationController?.sourceView = self.toolbar! // self.toolbar
                }
            }
            else {
                // iOS 7 phone or iPad
                presentViewController(controller, animated: true, completion: nil)
            }
//            [activityViewController respondsToSelector:@selector(popoverPresentationController)] ) { // iOS8 activityViewController.popoverPresentationController.sourceView = _shareItem; }
            
        }
    }
    
    @IBAction func onCancel(sender: UIBarButtonItem) {
        // dismiss the meme editor view controller
        self.dismissViewControllerAnimated(true, completion: nil)
//        if let navController = self.navigationController {
//            navController.popViewControllerAnimated(true)
//        }
        
        // present the SentMemes view controller
        //TODO - need this line back? ... displaySentMemesView()
    }
    
    func presentImagePicker(var sourceType: UIImagePickerControllerSourceType) {
        var imagePicker: UIImagePickerController = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = sourceType
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: UIImagePickerControllerDelegate
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.imageView.image = image
            toggleShareButton()
        }
        // dismiss the image picker view controller
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        // dismiss the image picker view controller
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    // MARK: Notifications
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name:
            UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name:
            UIKeyboardWillHideNotification, object: nil)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if bottomTextField.isFirstResponder() {
            // Move the view up to accomodate the keyboard deployment
            self.view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if bottomTextField.isFirstResponder() {
            // Move the view down to accomodate the keyboard hide
            self.view.frame.origin.y += getKeyboardHeight(notification)
        }
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.CGRectValue().height
    }
    
    // MARK: Text Field Delegate
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        
        // Clear the default text when user taps on the text field
        if textField === topTextField && textField.text == "TOP" {
            textField.text = ""
        }
        else if textField === bottomTextField && textField.text == "BOTTOM" {
            textField.text = ""
        }
        
        return true // enable editing
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        // hide keyboard when Return is selected while editing a text field
        textField.resignFirstResponder()
        
        return true;
    }
    
    // gauranteed to return an image
    func generateMemedImage() -> UIImage {
        
        // TODO: Hide toolbar and navbar
        self.toolbar.hidden = true
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        self.view.drawViewHierarchyInRect(self.view.frame, afterScreenUpdates: true)
        let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // TODO:  Show toolbar and navbar
        self.toolbar.hidden = false
        
        return memedImage
    }
    
    func saveMeme() {
        // create the memed image
        let memedImage: UIImage = generateMemedImage()
        
        //Create the Meme instance
        if let origImg = imageView.image {
            var meme = Meme( topText: topTextField.text, bottomText: bottomTextField.text, originalImage:origImg, memedImage: memedImage)
            
            // save the meme to the memes array
            (UIApplication.sharedApplication().delegate as! AppDelegate).memes.append(meme)
            
            // for testing set the view's background image to memedImage
            //self.view.backgroundColor = UIColor(patternImage: memedImage)
            
            //TODO - displaySentMemesView()
        }
    }
    
    //TODO - need modify? Is it causing both tab bar items to invoke the same list/collection VC?
    // Push the Sent Memes View
    func displaySentMemesView() {
        //            let controller = self.storyboard!.instantiateViewControllerWithIdentifier("ListOfSentMemesViewControllerID")! as ListOfSentMemesViewController
        
        let controller = self.storyboard!.instantiateViewControllerWithIdentifier("CollectionOfSentMemesViewControllerID")! as! CollectionOfSentMemesViewController
        
        self.navigationController!.pushViewController(controller, animated: true)
    }
}


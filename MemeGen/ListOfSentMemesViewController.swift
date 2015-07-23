//
//  ListOfSentMemesViewController.swift
//  MemeGen
//
//  Created by john bateman on 6/9/15.
//  Copyright (c) 2015 John Bateman. All rights reserved.
//

import UIKit

//TODO - not getting the delegate and datasource protocol messages! set delegates explicitly in code! Ask question on forum.

class ListOfSentMemesViewController:  UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!

    var memes: [Meme]!
    // TODO: create IBOutlets for the table view and set it's delegate to self
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        println("ListOfSentMemesViewController.viewDidLoad")
        
        // hide the navigation bar's back button
        //self.navigationItem.hidesBackButton = true
        // TODO: remove this if not needed: fake the bar button item to get it to hide.
        //        let backButton = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: navigationController, action: nil)
        //        navigationItem.leftBarButtonItem = backButton
    }
    
    override func viewWillAppear(animated: Bool) {
        println("ListOfSentMemesViewController.viewWillAppear")
        
        // get a reference to the memes collection
        memes = (UIApplication.sharedApplication().delegate as! AppDelegate).memes
        
        println("memes: \(memes)")
        
        // display the meme editor view controller if there aren't any sent memes yet
        if memes.count == 0 {
            //TODO - uncomment this line... displayMemeEditor()
            displayMemeEditor()
        }
        
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Table View Data Source
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        println("memes.count = \(memes.count)")
        return memes.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("MemeListCellID") as! MemesTableViewCell
        let meme = memes[indexPath.row]

        // set the image
//        cell.memeLabel.text = meme.topText
        cell.memeImage.image = meme.originalImage
        
        // apply the meme text to the image labels
        cell.topImageLabel.text = meme.topText
        cell.bottomImageLabel.text = meme.bottomText

        // Set the meme's text and image
//        cell.textLabel.text = meme.topText
//        cell.imageView.image = meme.memedImage

        return cell
    }
    
    // MARK: Table View Delegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

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
        //self.navigationController?.pushViewController(memeEditorVC, animated: true) // remove with popViewControllerAnimated:
        self.presentViewController(NavController, animated: true, completion: nil); // remove with dismissViewControllerAnimated(true, completion: nil)
    }

}

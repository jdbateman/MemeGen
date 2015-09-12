//
//  ListOfSentMemesViewController.swift
//  MemeGen
//
//  Created by john bateman on 6/9/15.
//  Copyright (c) 2015 John Bateman. All rights reserved.
//

import UIKit

class ListOfSentMemesViewController:  UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!

    var memes: [Meme]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(animated: Bool) {
        // get a reference to the memes collection
        memes = (UIApplication.sharedApplication().delegate as! AppDelegate).memes
        
        // display the meme editor view controller if there aren't any sent memes yet
        if memes.count == 0 {
            displayMemeEditor()
        }
        
        // Provoke the table view data source protocol methods to be called when subesequent memes are added to the memes collection.
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Table View Data Source
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("MemeListCellID") as! MemesTableViewCell
        let meme = memes[indexPath.row]

        // set the image
        cell.memeImage.image = meme.originalImage
        
        // apply the meme text to the image labels
        cell.topImageLabel.text = meme.topText
        cell.bottomImageLabel.text = meme.bottomText

        return cell
    }
    
    // MARK: Table View Delegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        // display detail view controller for the selected meme
        let controller = self.storyboard!.instantiateViewControllerWithIdentifier("MemeDetailViewControllerID")! as! MemeDetailViewController
        controller.meme = self.memes[indexPath.row]
        self.navigationController!.pushViewController(controller, animated: true)
    }

    @IBAction func onAddButton(sender: UIBarButtonItem) {
        self.displayMemeEditor()
    }
    
    func displayMemeEditor() {
        var storyboard = UIStoryboard (name: "Main", bundle: nil)
        var NavController = storyboard.instantiateViewControllerWithIdentifier("NavigationControllerForMemeEditorViewControllerID") as! UINavigationController
        self.presentViewController(NavController, animated: true, completion: nil);
    }
}

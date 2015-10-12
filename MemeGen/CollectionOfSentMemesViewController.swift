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
        
        theCollectionView.dataSource = self
        theCollectionView.delegate = self
    }

    override func viewWillAppear(animated: Bool) {
        // get a reference to the memes collection
        memes = (UIApplication.sharedApplication().delegate as! AppDelegate).memes
        
        // Provoke the collection view data source protocol methods to be called when subesequent memes are added to the memes collection. 
        self.theCollectionView.reloadData()
    }
    
    // MARK: UICollectionViewDataSource protocol

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MemeCollectionCellID", forIndexPath: indexPath) as! MemesCell
        
        let meme = self.memes[indexPath.row]
        
        cell.memedImageView.image = meme.originalImage
        
        // apply the meme text to the labels
        cell.topLabel.text = meme.topText
        cell.bottomLabel.text = meme.bottomText

        return cell
    }
    
    
    // MARK: UICollectionViewDelegate protocol
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
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
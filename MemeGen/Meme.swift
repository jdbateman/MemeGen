//
//  Meme.swift
//  MemeGen
//
//  Created by john bateman on 6/5/15.
//  Copyright (c) 2015 John Bateman. All rights reserved.
//
// This class implements the Meme class which is the main model object.

import Foundation
import UIKit
import CoreData

@objc(Meme)

class Meme : NSManagedObject {
    
    struct keys {
        static let topText: String = "topText"
        static let bottomText: String = "bottomText"
        static let originalImageData: String = "originalImageData"
        static let memedImageData: String = "memedImageData"
    }
    
    @NSManaged var topText: String              // text displayed at top of meme
    @NSManaged var bottomText: String           // text displayed at bottom of meme
    @NSManaged var originalImageData: NSData?   // JPEG image data for the meme picture
    @NSManaged var memedImageData: NSData?      // snapshot of meme picture and text elements
    var originalImage: UIImage? {               // UIImage computed from originalImageData property
        get {
            if let theData = originalImageData {
                return UIImage(data: theData)
            } else {
                return nil
            }
        }
    }
    var memedImage: UIImage? {                  // UIImage computed from memedImageData property
        get {
            if let theData = memedImageData {
                return UIImage(data: theData)
            } else {
                return nil
            }
        }
    }

    /* Core Data init method */
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }
    
    /* Init instance with a dictionary of values, and a core data context. */
    init(dictionary: [String: AnyObject], context: NSManagedObjectContext) {
        
        let entity = NSEntityDescription.entityForName("Meme", inManagedObjectContext: context)!
        super.init(entity: entity, insertIntoManagedObjectContext: context)
        
        topText = dictionary[keys.topText] as! String
        bottomText = dictionary[keys.bottomText] as! String
        memedImageData = dictionary[keys.memedImageData] as? NSData
        originalImageData = dictionary[keys.originalImageData] as? NSData
    }

}

/* Allows Meme instances to be compared.*/
extension Meme: Equatable {}
func ==(lhs: Meme, rhs: Meme) -> Bool {
    return ( (lhs.topText == rhs.topText) && (lhs.bottomText == rhs.bottomText) && (lhs.originalImageData == rhs.originalImageData) && (lhs.memedImageData == rhs.memedImageData) )
}
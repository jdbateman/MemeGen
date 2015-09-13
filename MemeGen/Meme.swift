//
//  Meme.swift
//  MemeGen
//
//  Created by john bateman on 6/5/15.
//  Copyright (c) 2015 John Bateman. All rights reserved.
//

import Foundation
import UIKit

struct Meme {
    var topText: String = ""
    var bottomText: String = ""
    var originalImage: UIImage
    var memedImage: UIImage

}

extension Meme: Equatable {}
func ==(lhs: Meme, rhs: Meme) -> Bool {
    return ( (lhs.topText == rhs.topText) && (lhs.bottomText == rhs.bottomText) && (lhs.originalImage == rhs.originalImage) && (lhs.memedImage == rhs.memedImage) )
}
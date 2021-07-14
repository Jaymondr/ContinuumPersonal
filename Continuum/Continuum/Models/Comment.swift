//
//  Comment.swift
//  Continuum
//
//  Created by Jaymond Richardson on 5/11/21.
//

import Foundation
import UIKit

class Comment: Codable {
    
    weak var post: Post?
    var text: String
    var timestamp: Date

    init(text: String, timestamp: Date = Date(), post: Post?){
        self.text = text
        self.timestamp = timestamp
        self.post = post
        
        
        
    }
}//End of class

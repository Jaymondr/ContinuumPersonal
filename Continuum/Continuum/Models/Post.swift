//
//  Post.swift
//  Continuum
//
//  Created by Jaymond Richardson on 5/11/21.
//

import Foundation
import UIKit

class Post {
    var photoData: Data?
    var timestamp: Date
    var caption: String
    var comment: [Comment]
    var photo: UIImage? {
        get {
            guard let photoData = photoData else {return nil}
            return UIImage(data: photoData)
            
        } set(newImage) {
            photoData = newImage?.jpegData(compressionQuality: 0.5)
        }
    }
    
    init(photo: UIImage?, caption: String, timestamp: Date = Date(), comment: [Comment] = []) {
        self.caption = caption
        self.timestamp = timestamp
        self.comment = comment
        self.photo = photo //err'self' used in property access 'photo' before all stored properties are initialized. SO -> moved to last line
    }
}//End of class

//MARK: - Extensions

//MARK: - PostTablListSearchBar Post Matching Extension
extension Post: SearchableRecord {
    func matches(searchTerm: String) -> Bool {
        if self.caption.lowercased() .contains(searchTerm.lowercased()) {
            return true
        } else {
            return false
        }
    }
}






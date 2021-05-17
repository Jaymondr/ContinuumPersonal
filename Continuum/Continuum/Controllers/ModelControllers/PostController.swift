//
//  PostController.swift
//  Continuum
//
//  Created by Jaymond Richardson on 5/11/21.
//  Copyright © 2021 trevorAdcock. All rights reserved.
//

import Foundation
import UIKit


class PostController {
    
    
    //MARK: - Properties
    static let shared = PostController() //Singleton Property
    
    var posts: [Post] = [] //SOT initialized as an empty array.
    var comments: [Comment] = []
//    var comments: 
    
    //MARK: - Functions
    
    func addComment(text: String, post: Post, completion: @escaping (Result<Comment, PostError>) -> Void) {
                let newComment = Comment(text: text, post: post)
        post.comment.append(newComment)
    }
    
    func createPostWith(image: UIImage, caption: String, completion: @escaping (Result<Post?, PostError>) -> Void ) {
        
        let post = Post(photo: image, caption: caption)
        self.posts.append(post)
        
    }
    
    
    
    
    
    
    
    
}


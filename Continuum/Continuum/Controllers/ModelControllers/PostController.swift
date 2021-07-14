//
//  PostController.swift
//  Continuum
//
//  Created by Jaymond Richardson on 5/11/21.
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
        saveToPersistentStore()
    }
    
    func createPostWith(image: UIImage, caption: String, completion: @escaping (Result<Post?, PostError>) -> Void ) {
        
        let post = Post(photo: image, caption: caption)
        self.posts.append(post)
        saveToPersistentStore()
        
    }
    
    func createPersistenceStore() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = paths[0]
        let filename = "Contimuum.json"
        let fileURL = documentDirectory.appendingPathComponent(filename)
        return fileURL
        
    }
    
    func saveToPersistentStore() {
        
        do {
            let data = try JSONEncoder().encode(posts)
            print(data)
            print(String(data: data, encoding: .utf8)!)
            try data.write(to: createPersistenceStore())
            
        } catch let error {
            print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
        }
        
    }
    
    func loadFromPersistentStore() {
        do {
            let data = try Data(contentsOf: createPersistenceStore())
            posts = try JSONDecoder().decode([Post].self, from: data)
            
        } catch {
            print("Error loading data drom disk \(error)")
            
        }
    }
    
    
    
    
    
    
}


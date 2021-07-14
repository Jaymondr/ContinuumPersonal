//
//  PostTableViewCell.swift
//  Continuum
//
//  Created by Jaymond Richardson on 5/11/21.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    //MARK: - Outlets
    
    @IBOutlet weak var postImageView: UIImageView!
    
    @IBOutlet weak var postCaptionLabel: UILabel!
    
    @IBOutlet weak var postCommentCountLabel: UILabel!
    
    //MARK: - Properties
    var post: Post? { //post variable
        didSet {
            updateViews()
        }
    }
    
    
    
    //MARK: - Methods
    func updateViews() {
        guard let post = post else {return}
        postImageView.image = post.photo
        postCaptionLabel.text = post.caption
        postCommentCountLabel.text = "\(post.comment.count) comments" 
    }
    
    
}

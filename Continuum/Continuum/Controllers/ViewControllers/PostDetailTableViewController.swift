//
//  PostDetailTableViewController.swift
//  Continuum
//
//  Created by Jaymond Richardson on 5/11/21.
//

import UIKit

class PostDetailTableViewController: UITableViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var followButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var commentButton: UIButton!
    
    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()



    }
    
    //MARK: - Actions
    @IBAction func shareButton(_ sender: Any) {
        
        guard let post = post,
              let image = post.photo else {return}
        
        let activityVC = UIActivityViewController(activityItems: [post.caption, image], applicationActivities: [])
        
        present(activityVC, animated: true, completion: nil)
        
    }
    @IBAction func followPostButton(_ sender: Any) {
        
    }
    
    @IBAction func commentButtonTapped(_ sender: Any) {
        let alertController = UIAlertController(title: "Leave a comment", message: "Let people know what you think about this post", preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "Type comment here..."

        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        let commentAction = UIAlertAction(title: "OK", style: .default) { (_) in
            
            guard let commentText = alertController.textFields?.first?.text, !commentText.isEmpty,
                  let post = self.post else {return}
            
            PostController.shared.addComment(text: commentText, post: post) { (comment) in
            
            }
            DispatchQueue.main.async {
                    self.tableView.reloadData()
            }
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(commentAction)
        present(alertController, animated: true) //dont forget
        PostController.shared.loadFromPersistentStore()
    }
    

    //MARK: - Property
    var post: Post? {
        didSet {
            loadViewIfNeeded()
            updateViews()
        }
    }
    
    //MARK: - Functions
    
    func updateViews() {
        guard let post = post else {return}
        photoImageView.image = post.photo
        tableView.reloadData()
        PostController.shared.loadFromPersistentStore()
    }
    
    
    
    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let post = post else {return 0}
        return post.comment.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell", for: indexPath)
        guard let post = post else {return UITableViewCell()}
        
        let comment = post.comment[indexPath.row]
        
        cell.textLabel?.text = comment.text
        cell.detailTextLabel?.text = comment.timestamp.formatToString()
        


        return cell
    }
}//End of class

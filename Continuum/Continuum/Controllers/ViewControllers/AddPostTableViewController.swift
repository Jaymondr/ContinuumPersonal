//
//  AddPostTableViewController.swift
//  Continuum
//
//  Created by Jaymond Richardson on 5/11/21.
//

import UIKit


class AddPostTableViewController: UITableViewController {
    //MARK: - Outlets
    @IBOutlet weak var addCaptionTextField: UITextField!

    //MARK: - Properties
    var selectedImage: UIImage?
    
    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        addCaptionTextField.text = ""
    }
    
    //MARK: - Actions
    @IBAction func addPostButtonTapped(_ sender: Any) {
        //change photo to selected image with delegate
        guard let photo = selectedImage,
              let caption = addCaptionTextField.text, !caption.isEmpty else {return}
        
        PostController.shared.createPostWith(image: photo, caption: caption) { (post) in }
        
        self.tabBarController?.selectedIndex = 0 // pops back to tab bar controller after add button is tapped
    }//end of func
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.tabBarController?.selectedIndex = 0 //popping view back to tab bar controller
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPhotoSelector" {
            let photoSelector = segue.destination as? PhotoSelectorViewController
            photoSelector?.delegate = self
        }
    }
    
}//End of class

    //MARK: - Extensions
extension AddPostTableViewController: PhotoSelectorViewControllerDelegate {
    func photoSelectorViewController(image: UIImage) {
        selectedImage = image
    }
}


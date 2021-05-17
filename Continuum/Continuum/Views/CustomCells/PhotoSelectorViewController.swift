//
//  PhotoSelectorViewController.swift
//  Continuum
//
//  Created by Jaymond Richardson on 5/12/21.
//  Copyright © 2021 trevorAdcock. All rights reserved.
//

import UIKit

protocol PhotoSelectorViewControllerDelegate: AnyObject {
    func photoSelectorViewController(image: UIImage) //tells parent view what image was selected
}

class PhotoSelectorViewController: UIViewController {
    //MARK: - Outlets
    @IBOutlet weak var placeholderImage: UIImageView!
    @IBOutlet weak var selectImageButton: UIButton!
    
    //MARK: - Properties
    weak var delegate: PhotoSelectorViewControllerDelegate?
    
    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        selectImageButton.setTitle("test", for: .normal)
        placeholderImage.image = nil
        
    }
    
    //MARK: - Actions
    @IBAction func selectImageButtonTapped(_ sender: Any) {
        selectImageButton.setTitle("", for: .normal)
        placeholderImage.image = UIImage(named: "test")
        presentImagePickerActionSheet()
    }
    
}//End of class

    //MARK: - Extensions

extension PhotoSelectorViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage { //sets the image as the original data sent?
            placeholderImage.contentMode = .scaleToFill
            placeholderImage.image = image
            selectImageButton.setTitle("", for: .normal)// replacing button text with empty string
            delegate?.photoSelectorViewController(image: image) // added after creating the parent
            
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func presentImagePickerActionSheet() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        let alertController = UIAlertController(title: "Choose a photo", message: "Select image source", preferredStyle: .actionSheet)
        
        // For Completion Set source, check editing allowance ->BOOL, then present controller
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { _ in
            imagePickerController.sourceType = .camera
            imagePickerController.allowsEditing = true
            self.present(imagePickerController, animated: true, completion: nil)
            
        }
        let galleryAction = UIAlertAction(title: "Photo Library", style: .default) { _ in
            imagePickerController.sourceType = .photoLibrary
            imagePickerController.allowsEditing = true
            self.present(imagePickerController, animated: true, completion: nil)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        //making sure source is available
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            alertController.addAction(galleryAction)
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            alertController.addAction(cameraAction)
        }
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
        
    }
}//End of Extension



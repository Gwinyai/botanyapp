//
//  UpdatePlantViewController.swift
//  BotanyApp
//
//  Created by Gwinyai Nyatsoka on 16/9/2022.
//

import UIKit

class UpdatePlantViewController: UIViewController {

    @IBOutlet weak var tapToAddImageLabel: UILabel!
    @IBOutlet weak var plantImageView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet weak var plantView: UIView!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var titleCharacterCOunt: UILabel!
    weak var editDelegate: PlantDetailDelegate?
    var selectedImage: UIImage?
    var plantToEdit: PlantModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        let imageViewTap = UITapGestureRecognizer(target: self, action: #selector(plantViewTapped))
        plantView.addGestureRecognizer(imageViewTap)
        plantView.isUserInteractionEnabled = true
        titleTextField.addTarget(self, action: #selector(titleCountUpdate), for: .editingChanged)
        if let plantToEdit = plantToEdit {
            plantImageView.image =  plantToEdit.image
            titleTextField.text = plantToEdit.title
            notesTextView.text = plantToEdit.notes
            selectedImage = plantToEdit.image
            tapToAddImageLabel.isHidden = true
            plantImageView.contentMode = .scaleAspectFill
            titleCountUpdate()
        }
    }
    
    func setupView() {
        titleTextField.layer.borderColor = UIColor.lightGray.cgColor
        titleTextField.layer.borderWidth = CGFloat(0.5)
        titleTextField.layer.cornerRadius = CGFloat(4)
        notesTextView.layer.borderColor = UIColor.lightGray.cgColor
        notesTextView.layer.borderWidth = CGFloat(0.5)
        notesTextView.layer.cornerRadius = CGFloat(4)
        submitButton.layer.cornerRadius = submitButton.frame.height / 2
        plantView.clipsToBounds = true
        plantView.layer.cornerRadius = plantView.frame.height / 2
        plantImageView.layer.cornerRadius = plantImageView.frame.height / 2
    }
    
    @objc func titleCountUpdate() {
        let count = titleTextField.text?.count ?? 0
        titleCharacterCOunt.text = "\(count)"
        if count > 3 {
            titleTextField.layer.borderColor = UIColor.green.cgColor
            titleCharacterCOunt.textColor = UIColor.green
        } else {
            titleTextField.layer.borderColor = UIColor.red.cgColor
            titleCharacterCOunt.textColor = UIColor.red
        }
    }
    
    @objc func plantViewTapped() {
        
        let alert = UIAlertController(title: "Choose Image Option", message: nil, preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { _ in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                let camera = UIImagePickerController()
                camera.delegate = self
                camera.sourceType = .camera
                camera.allowsEditing = true
                self.present(camera, animated: true)
                alert.dismiss(animated: true)
            } else {
                alert.dismiss(animated: true)
                self.presentErrorAlert(title: "Camera Not Available", message: "Camera is not available")
            }
        }
        let galleryAction = UIAlertAction(title: "Photos", style: .default) { _ in
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                let library = UIImagePickerController()
                library.delegate = self
                library.sourceType = .photoLibrary
                library.allowsEditing = true
                self.present(library, animated: true)
                alert.dismiss(animated: true)
            } else {
                alert.dismiss(animated: true)
                self.presentErrorAlert(title: "Library Not Available", message: "Library is not available")
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            alert.dismiss(animated: true)
        }
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { _ in
            if let _ = self.selectedImage {
                self.selectedImage = nil
                self.plantImageView.contentMode = .scaleAspectFit
                self.plantImageView.image = UIImage(systemName: "camera.fill")
                self.tapToAddImageLabel.isHidden = false
            }
        }
        
        alert.addAction(cancelAction)
        alert.addAction(cameraAction)
        alert.addAction(galleryAction)
        alert.addAction(deleteAction)
        present(alert, animated: true)
    }
    
    
    @IBAction func submitButtonTapped(_ sender: Any) {
        guard let selectedImage = selectedImage else {
            presentErrorAlert(title: "No Image", message: "Please take an image to submit")
            return
        }
        guard let titleText = titleTextField.text,
              titleText.count > 3 else {
            presentErrorAlert(title: "Title Error", message: "Title must have more than 3 characters")
            return
        }
        guard let notesText = notesTextView.text,
        notesText.count > 5 else {
            presentErrorAlert(title: "Notes Error", message: "Notes must have more than 5 characters")
            return
        }
        //let plant = PlantModel(image: selectedImage, title: titleText, notes: notesText)
        if let plantToEdit = plantToEdit {
            plantToEdit.image = selectedImage
            plantToEdit.title = titleText
            plantToEdit.notes = notesText
            editDelegate?.update(plant: plantToEdit)
        }
        dismiss(animated: true)
    }
    
    @IBAction func removeImageButtonTapped(_ sender: Any) {
        if let _ = selectedImage {
            self.selectedImage = nil
            plantImageView.image = UIImage(systemName: "camera.fill")
            tapToAddImageLabel.isHidden = false
        }
    }

}

extension UpdatePlantViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.editedImage] as! UIImage
        plantImageView.image = image
        selectedImage = image
        tapToAddImageLabel.isHidden = true
        plantImageView.contentMode = .scaleAspectFill
        picker.dismiss(animated: true)
    }
    
}

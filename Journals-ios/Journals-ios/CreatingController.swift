//
//  CreatingController.swift
//  Journals-ios
//
//  Created by Aries Yang on 2017/12/8.
//  Copyright © 2017年 Aries Yang. All rights reserved.
//

import UIKit
import Firebase

class CreatingController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var showPickedImageView: UIImageView!
    
    @IBOutlet weak var cancelButton: UIButton!

    @IBOutlet weak var imagePickerButton: UIButton!

    @IBOutlet weak var titleTextField: UITextField!

    @IBOutlet weak var contentTextField: UITextField!

    @IBOutlet weak var saveButton: UIButton!

    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        view.backgroundColor = UIColor.white
        cancelButton.addTarget(self, action: #selector(handleCancel), for: .touchUpInside)
        imagePickerButton.addTarget(self, action: #selector(handlePickImage), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(handleSave), for: .touchUpInside)
    }

    @objc func handleSave() {
//        uploadJournal()
        if
            let title = self.titleTextField.text,
            let content = self.contentTextField.text {

            let values = ["title": title, "content": content]
            let ref = Database.database().reference(fromURL: "https://journals-ios.firebaseio.com/")
            let journalRef = ref.child("journals").childByAutoId()
            print(values)
            journalRef.setValue(values)
        }
        dismissThisPage()
    }

    func uploadJournal() {
        let storageRef = Storage.storage().reference().child("image")
        if let uploadData = UIImagePNGRepresentation(self.showPickedImageView.image!) {
            storageRef.putData(uploadData, metadata: nil, completion: { (metadata, error) in
                if error != nil {
                    print("error")
                    return
                }
                if
                    let imageUrl = metadata?.downloadURL()?.absoluteString,
                    let title = self.titleTextField.text,
                    let content = self.contentTextField.text {

                    let values = ["title": title, "content": content]//, "imageUrl": imageUrl]
                    self.sendDataToDatabase(values: values)
                }
            })
        }
    }

    func sendDataToDatabase(values: [String: String]) {
        let ref = Database.database().reference(fromURL: "https://journals-ios.firebaseio.com/")
        let journalRef = ref.child("journals").childByAutoId()
        print(values)
        journalRef.setValue(values)
    }

    @objc func handleCancel() {
        dismissThisPage()
    }

    @objc func handlePickImage() {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String :Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            showPickedImageView.contentMode = .scaleAspectFill
            showPickedImageView.image = pickedImage

            // Todo: clear the button placeholder image
        }
        dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

    func dismissThisPage() {
        self.dismiss(animated: true, completion: nil)
    }
}

//
//  EditingController.swift
//  Journals-ios
//
//  Created by Aries Yang on 2017/12/8.
//  Copyright © 2017年 Aries Yang. All rights reserved.
//

import UIKit
import Firebase

class EditingController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var showPickedImageView: UIImageView!

    @IBOutlet weak var imagePickerButton: UIButton!

    @IBOutlet weak var cancelButton: UIButton!

    @IBOutlet weak var titleTextField: UITextField!

    @IBOutlet weak var contentTextField: UITextField!

    @IBOutlet weak var updateButton: UIButton!

    let imagePicker = UIImagePickerController()

    var journalId: String?
    var originTitle: String?
    var originContent: String?
    var originImageUrl: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker.delegate = self

        view.backgroundColor = UIColor.white

        setupTitleTextField()
        setupContentTextField()
        setupUpdateButton()

        cancelButton.addTarget(self, action: #selector(handleCancel), for: .touchUpInside)

        imagePickerButton.addTarget(self, action: #selector(handlePickImage), for: .touchUpInside)

        updateButton.addTarget(self, action: #selector(handleUpdate), for: .touchUpInside)
    }

    func setupTitleTextField() {
        titleTextField.font = UIFont(name: "SFUIText", size: 30)
        titleTextField.textColor = UIColor(red: 67.0/255, green: 87.0/255, blue: 97.0/255, alpha: 1.0)
        titleTextField.text = originTitle
    }

    func setupContentTextField() {
        contentTextField.font = UIFont(name: "SFUIText", size: 18)
        contentTextField.textColor = UIColor(red: 131.0/255, green: 156.0/255, blue: 152.0/255, alpha: 1.0)
        contentTextField.text = originContent
    }

    func setupUpdateButton() {
        updateButton.layer.cornerRadius = 22.0
        updateButton.titleLabel?.font = UIFont(name: "SFUIText", size: 20)
    }

    @objc func handleUpdate() {
        uploadJournal()
//        if
//            let title = self.titleTextField.text,
//            let content = self.contentTextField.text,
//            let id = self.journalId {
//
//            let values = ["title": title, "content": content]
//            let ref = Database.database().reference(fromURL: "https://journals-ios.firebaseio.com/")
//            let journalRef = ref.child("journals").child(id)
//            print(values)
//            journalRef.updateChildValues(values)
//        }
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

                    let values = ["title": title, "content": content, "imageUrl": imageUrl]
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

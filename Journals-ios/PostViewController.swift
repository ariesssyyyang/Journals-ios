//
//  PostViewController.swift
//  Journals-ios
//
//  Created by Aries Yang on 2018/11/30.
//  Copyright © 2018 Aries Yang. All rights reserved.
//

import Foundation
import UIKit

enum PostMode {
    case new
    case edit
}

class PostViewController: UIViewController {

    let mode: PostMode

    required init?(coder aDecoder: NSCoder) {
        self.mode = .new
        super.init(coder: aDecoder)
    }

    init(mode: PostMode) {
        self.mode = mode
        super.init(nibName: nil, bundle: nil)
    }
    
    let submitButton: UIButton = {
        let button = UIButton()
        
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .orange
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let dismissButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "icon_close"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let pickPhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "icon_photo")
        imageView.contentMode = .center
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let subjectTextField: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "title"
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()

    let contentTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()

    let viewModel = JournalViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
        setupButtonText()
        setupImageViewEvent()
        setupButtonsAction()
    }

    func setupLayout() {
        view.addSubview(pickPhotoImageView)
        pickPhotoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        pickPhotoImageView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        pickPhotoImageView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        pickPhotoImageView.heightAnchor.constraint(equalTo: pickPhotoImageView.widthAnchor).isActive = true

        pickPhotoImageView.addSubview(dismissButton)
        dismissButton.topAnchor.constraint(equalTo: pickPhotoImageView.topAnchor, constant: 5).isActive = true
        dismissButton.leftAnchor.constraint(equalTo: pickPhotoImageView.leftAnchor, constant: 5).isActive = true
        dismissButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        dismissButton.heightAnchor.constraint(equalTo: dismissButton.widthAnchor).isActive = true

        view.addSubview(subjectTextField)
        subjectTextField.topAnchor.constraint(equalTo: pickPhotoImageView.bottomAnchor).isActive = true
        subjectTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        subjectTextField.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        subjectTextField.heightAnchor.constraint(equalToConstant: 80).isActive = true

        view.addSubview(submitButton)
        submitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        submitButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
        submitButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/3).isActive = true
        submitButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        submitButton.layer.cornerRadius = 25

        view.addSubview(contentTextView)
        contentTextView.topAnchor.constraint(equalTo: subjectTextField.bottomAnchor).isActive = true
        contentTextView.leftAnchor.constraint(equalTo: subjectTextField.leftAnchor).isActive = true
        contentTextView.rightAnchor.constraint(equalTo: subjectTextField.rightAnchor).isActive = true
        contentTextView.bottomAnchor.constraint(equalTo: submitButton.topAnchor, constant: -5).isActive = true
    }

    func setupButtonText() {
        switch mode {
        case .edit:
            submitButton.setTitle("Update", for: .normal)
        case .new:
            submitButton.setTitle("Send", for: .normal)
        }
    }

    func setupButtonsAction() {
        dismissButton.addTarget(self, action: #selector(dismissButtonTapped), for: .touchUpInside)
        submitButton.addTarget(self, action: #selector(savePost(_:)), for: .touchUpInside)
    }

    @objc func dismissButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }

    @objc func savePost(_ sender: UIButton) {
        guard
            let title = subjectTextField.text,
            let content = contentTextView.text,
            let image = pickPhotoImageView.image
        else { return }

        let journal = JournalModel(title: title, content: content, image: image)

        switch mode {
        case .new:
            viewModel.createJournalObject(journal: journal)
        case .edit:
            viewModel.updataJournalObject(journal: journal)
        }

        self.dismiss(animated: true, completion: { [weak self] in
            self?.viewModel.listJournalObjects()
        })
    }

    func setupImageViewEvent() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(_:)))
        pickPhotoImageView.addGestureRecognizer(tapGestureRecognizer)
    }

    @objc func imageTapped(_ tapGestureRecognizer: UITapGestureRecognizer) {
        let imagePicker = UIImagePickerController()
        prepareForImagePicker(imagePicker: imagePicker)
        self.present(imagePicker, animated: true, completion: nil)
    }
}

extension PostViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func prepareForImagePicker(imagePicker: UIImagePickerController) {
        imagePicker.delegate = self
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let selectedImage = info[.originalImage] as? UIImage else { return }
        pickPhotoImageView.image = selectedImage
        pickPhotoImageView.contentMode = .scaleAspectFill
        pickPhotoImageView.clipsToBounds = true
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
	return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

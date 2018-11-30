//
//  JournalListController.swift
//  Journals-ios
//
//  Created by Aries Yang on 2018/11/28.
//  Copyright © 2018 Aries Yang. All rights reserved.
//

import Foundation
import UIKit

class JournalListController: UIViewController {

    let fakeNavBar: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let newPostButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "icon_plus"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let topViewLabel: UILabel = {
        let label = UILabel()
        label.text = "My Journals"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        self.view.backgroundColor = .orange

        setupLayoutConstraint()
    }

    func setupLayoutConstraint() {
        view.addSubview(fakeNavBar)
        fakeNavBar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        fakeNavBar.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        fakeNavBar.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        fakeNavBar.heightAnchor.constraint(equalTo: self.view.heightAnchor, constant: 1/5)

        fakeNavBar.addSubview(newPostButton)
        newPostButton.rightAnchor.constraint(equalTo: fakeNavBar.rightAnchor, constant: -10).isActive = true
        newPostButton.topAnchor.constraint(equalTo: fakeNavBar.topAnchor, constant: 5).isActive = true
        newPostButton.bottomAnchor.constraint(equalTo: fakeNavBar.bottomAnchor, constant: -5).isActive = true
        newPostButton.widthAnchor.constraint(equalTo: newPostButton.heightAnchor).isActive = true

        fakeNavBar.addSubview(topViewLabel)
        topViewLabel.leftAnchor.constraint(equalTo: fakeNavBar.leftAnchor, constant: 20).isActive = true
        topViewLabel.topAnchor.constraint(equalTo: fakeNavBar.topAnchor, constant: 5).isActive = true
        topViewLabel.bottomAnchor.constraint(equalTo: fakeNavBar.bottomAnchor, constant: -5).isActive = true
        topViewLabel.rightAnchor.constraint(equalTo: newPostButton.leftAnchor).isActive = true
    }
}

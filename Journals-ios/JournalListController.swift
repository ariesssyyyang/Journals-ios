//
//  JournalListController.swift
//  Journals-ios
//
//  Created by Aries Yang on 2018/11/28.
//  Copyright © 2018 Aries Yang. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class JournalListController: UIViewController {

    let fakeNavBar: UIView = {
        let view = UIView()
        view.backgroundColor = .white
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

    let postTableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), style: .plain)
        tableView.register(JournalCell.self, forCellReuseIdentifier: "journalCell")
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    } ()

    let journalVM = JournalViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        setupLayoutConstraint()
        prepareForTableView()
    }

    func setupLayoutConstraint() {
        view.addSubview(fakeNavBar)
        fakeNavBar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        fakeNavBar.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        fakeNavBar.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        fakeNavBar.heightAnchor.constraint(equalToConstant: 100).isActive = true

        view.addSubview(postTableView)
        postTableView.topAnchor.constraint(equalTo: fakeNavBar.bottomAnchor).isActive = true
        postTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        postTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        postTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

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

extension JournalListController: UITableViewDelegate, UITableViewDataSource {

    func prepareForTableView() {
        postTableView.delegate = self
        postTableView.dataSource = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return journalVM.numberOfCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "journalCell") as? JournalCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.setupViews()
        let journal = journalVM.getCellModel(at: indexPath)
        cell.postTitleLabel.text = journal.title
        cell.postImageView.image = journal.image
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}

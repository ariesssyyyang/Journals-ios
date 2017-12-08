//
//  ViewController.swift
//  Journals-ios
//
//  Created by Aries Yang on 2017/12/8.
//  Copyright © 2017年 Aries Yang. All rights reserved.
//

import UIKit
import Firebase

class JournalsListController: UITableViewController {

    let titleView: TitleView = {
        if let view = UIView.load(nibName: "TitleView") as? TitleView {
            return view
        } else {
            return TitleView()
        }
    }()
    
//    @IBOutlet weak var journalTableView: UITableView!

    let cellId = "journalsCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setupTitleView()
        self.tableView.register(JournalsCell.self, forCellReuseIdentifier: cellId)
    }

    func setupTitleView() {
        titleView.addButton.addTarget(self, action: #selector(handleAdd), for: .touchUpInside)
    }

    @objc func handleAdd() {
//        let creatingController = CreatingController()
        let storyboard = UIStoryboard(name: "Creating", bundle: nil)
        let creatingController = storyboard.instantiateViewController(withIdentifier: "newJournal")
        present(creatingController, animated: true, completion: nil)
    }

    func setupTitleViewConstraints() {
        titleView.bottomAnchor.constraint(equalTo: view.topAnchor).isActive = true
        titleView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        titleView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return titleView
    }
 
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if let cell =  tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? JournalsCell {
            
            return cell
        } else {
            return UITableViewCell()
        }
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 212
    }
}

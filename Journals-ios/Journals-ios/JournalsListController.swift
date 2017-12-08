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

    let titleView: UIView = {
        if let view = UIView.load(nibName: "TitleView") as? TitleView {
            return view
        } else {
            return UIView()
        }
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
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
        let cell =  UITableViewCell()
        cell.backgroundColor = UIColor.blue
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 212
    }
}

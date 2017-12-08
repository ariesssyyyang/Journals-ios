//
//  JournalsCell.swift
//  Journals-ios
//
//  Created by Aries Yang on 2017/12/8.
//  Copyright © 2017年 Aries Yang. All rights reserved.
//

import UIKit

class JournalsCell: UITableViewCell {

    @IBOutlet weak var journalImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var circleView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.text = "hi"
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont(name: "SFUIText", size: 12)
        setupSeparator()

    }

    func setupSeparator() {
        let separatorColor = UIColor(red: 171.0/255.0, green: 179.0/255.0, blue: 176.0/255.0, alpha: 1.0)
        separatorView.backgroundColor = separatorColor
        circleView.layer.cornerRadius = circleView.frame.width / 2
        circleView.layer.borderColor = separatorColor.cgColor
    }

}

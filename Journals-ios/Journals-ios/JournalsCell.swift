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

        setupTitleLabel()
        setupSeparator()

    }

    func setupSeparator() {
        let separatorColor = UIColor(red: 171.0/255.0, green: 179.0/255.0, blue: 176.0/255.0, alpha: 1.0)
        separatorView.backgroundColor = separatorColor
        circleView.layer.cornerRadius = circleView.frame.width / 2
        circleView.layer.borderWidth = 0.5
        circleView.layer.borderColor = separatorColor.cgColor
    }

    func setupTitleLabel() {
        titleLabel.textColor = UIColor(red: 67.0/255, green: 87.0/255, blue: 97.0/255, alpha: 1.0)
        titleLabel.font = UIFont(name: "SFUIText", size: 14)
    }

    func setupImageView() {
        journalImageView.contentMode = .scaleToFill
        journalImageView.layer.cornerRadius = 8.0
        journalImageView.layer.shadowColor = UIColor(red: 171.0/255, green: 179.0/255, blue: 176.0/255, alpha: 1.0).cgColor
        journalImageView.layer.shadowRadius = 10.0
        journalImageView.layer.masksToBounds = true
    }
}

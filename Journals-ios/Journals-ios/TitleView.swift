//
//  TitleView.swift
//  Journals-ios
//
//  Created by Aries Yang on 2017/12/8.
//  Copyright © 2017年 Aries Yang. All rights reserved.
//

import UIKit

class TitleView: UIView {

    @IBOutlet weak var addButton: UIButton!

    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        setupTitleLabel()

        setupAddButton()
    }

    func setupTitleLabel() {
        titleLabel.font = UIFont(name: "SFUIText", size: 20)
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        titleLabel.textColor = UIColor(red: 67.0/255.0, green: 87.0/255.0, blue: 97.0/255.0, alpha: 1.0)
    }

    func setupAddButton() {
        let image = #imageLiteral(resourceName: "icon_plus").withRenderingMode(.alwaysTemplate)
        addButton.setImage(image, for: .normal)
        addButton.tintColor = UIColor(red: 237.0/255.0, green: 96.0/255.0, blue: 81.0/255.0, alpha: 1.0)
    }
    
}

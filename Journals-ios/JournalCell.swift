//
//  JournalCell.swift
//  Journals-ios
//
//  Created by Aries Yang on 2018/11/30.
//  Copyright © 2018 Aries Yang. All rights reserved.
//

import UIKit

class JournalCell: UITableViewCell {
    let postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.shadowOffset = .zero
        imageView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor
        imageView.layer.shadowRadius = 8.0
        imageView.layer.cornerRadius = 5.0
        imageView.layer.shadowOpacity = 1.0
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let postTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "title"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let separatorBackView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let separatorLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let separatorCircleView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 1.0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    func setupViews() {
        prepareForImageView()
        prepareForTitleLabel()
        prepareForSeparatorView()
    }

    func prepareForImageView() {
        contentView.addSubview(postImageView)
        postImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        postImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20).isActive = true
        postImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20).isActive = true
        postImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 1/2).isActive = true
    }

    func prepareForTitleLabel() {
        contentView.addSubview(postTitleLabel)
        postTitleLabel.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 5).isActive = true
        postTitleLabel.leftAnchor.constraint(equalTo: postImageView.leftAnchor).isActive = true
        postTitleLabel.rightAnchor.constraint(equalTo: postImageView.rightAnchor).isActive = true
        postTitleLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 1/4).isActive = true
    }

    func prepareForSeparatorView() {
        contentView.addSubview(separatorBackView)
        separatorBackView.topAnchor.constraint(equalTo: postTitleLabel.bottomAnchor).isActive = true
        separatorBackView.rightAnchor.constraint(equalTo: postTitleLabel.rightAnchor).isActive = true
        separatorBackView.leftAnchor.constraint(equalTo: postTitleLabel.leftAnchor).isActive = true
        separatorBackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true

        separatorBackView.addSubview(separatorLineView)
        separatorLineView.leftAnchor.constraint(equalTo: separatorBackView.leftAnchor).isActive = true
        separatorLineView.rightAnchor.constraint(equalTo: separatorBackView.rightAnchor).isActive = true
        separatorLineView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        separatorLineView.centerYAnchor.constraint(equalTo: separatorBackView.centerYAnchor).isActive = true

        separatorLineView.addSubview(separatorCircleView)
        separatorCircleView.centerXAnchor.constraint(equalTo: separatorLineView.centerXAnchor).isActive = true
        separatorCircleView.centerYAnchor.constraint(equalTo: separatorLineView.centerYAnchor).isActive = true
        separatorCircleView.heightAnchor.constraint(equalToConstant: 10).isActive = true
        separatorCircleView.widthAnchor.constraint(equalTo: separatorCircleView.heightAnchor).isActive = true
        separatorCircleView.layer.cornerRadius = 5
    }
}

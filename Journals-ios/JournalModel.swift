//
//  JournalModel.swift
//  Journals-ios
//
//  Created by Aries Yang on 2018/12/1.
//  Copyright © 2018 Aries Yang. All rights reserved.
//

import RealmSwift

final class Journal: Object {
    @objc dynamic var title = ""
    @objc dynamic var content = ""
    @objc dynamic var imageData = Data()
}

struct JournalModel {
    let title: String
    let content: String
    let image: UIImage?

    init(journalObject: Journal) {
        self.title = journalObject.title
        self.content = journalObject.content
        self.image = UIImage(data: journalObject.imageData)
    }
}

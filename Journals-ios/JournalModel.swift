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
    var image: UIImage?

    init(from realmObject: Journal) {
        self.title = realmObject.title
        self.content = realmObject.content
        self.image = UIImage(data: realmObject.imageData)
    }

    init(title: String, content: String, image: UIImage) {
        self.title = title
        self.content = content
        self.image = image
    }
}

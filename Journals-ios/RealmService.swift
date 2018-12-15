//
//  RealmService.swift
//  Journals-ios
//
//  Created by Aries Yang on 2018/12/1.
//  Copyright © 2018 Aries Yang. All rights reserved.
//

import Foundation
import RealmSwift

class RealmService {
    weak var delegate: RealmServiceDelegate?

    func create(title: String, content: String, image: UIImage?) {
        do {
            let realm = try Realm()
            try realm.write {
                guard let img = image, let data = img.jpegData(compressionQuality: 0.6) else { return }
                realm.add(Journal(value: ["title": title, "content": content, "imageData": data]))
            }
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }

    func update(title: String, content: String, image: UIImage?) {
        do {
            let realm = try Realm()
            try realm.write {
                guard let img = image, let data = img.jpegData(compressionQuality: 0.8) else { return }
                realm.add(Journal(value: ["title": title, "content": content, "image": data]), update: true)
            }
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }

    func retrieveList() {
        do {
            let realm = try Realm()
            var journalList: [JournalModel] = [JournalModel]()
            for result in realm.objects(Journal.self) {
                journalList.append(JournalModel(from: result))
            }
            delegate?.didFetchJournal(journals: journalList)
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }
}

protocol RealmServiceDelegate: class {
    func didFetchJournal(journals: [JournalModel])
}

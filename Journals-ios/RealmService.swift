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

    func create(title: String, content: String, image: UIImage) {
        do {
            let realm = try Realm()
            try realm.write {
                guard let data = image.jpegData(compressionQuality: 0.8) else { return }
                realm.add(Journal(value: ["title": title, "content": content, "image": data]))
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
                journalList.append(JournalModel(journalObject: result))
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

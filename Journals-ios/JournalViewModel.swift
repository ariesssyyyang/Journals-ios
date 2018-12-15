//
//  JournalViewModel.swift
//  Journals-ios
//
//  Created by Aries Yang on 2018/12/1.
//  Copyright © 2018 Aries Yang. All rights reserved.
//

import Foundation
import RealmSwift

class JournalViewModel {
    private var cellModels: [JournalModel] = [JournalModel]() {
        didSet {
            self.reloadTableViewClosure?()
        }
    }

    let realmService = RealmService()

    var reloadTableViewClosure: (()-> ())?

    var numberOfCells: Int {
        return cellModels.count
    }

    func getCellModel(at indexPath: IndexPath) -> JournalModel {
        return cellModels[indexPath.row]
    }

    func createJournalObject(journal: JournalModel) {
        realmService.create(title: journal.title, content: journal.content, image: journal.image)
    }

    func updataJournalObject(journal: JournalModel) {
        realmService.update(title: journal.title, content: journal.content, image: journal.image)
    }

    func listJournalObjects() {
        realmService.delegate = self
        realmService.retrieveList()
    }
    
}

extension JournalViewModel: RealmServiceDelegate {
    func didFetchJournal(journals: [JournalModel]) {
        self.cellModels = journals
    }
}

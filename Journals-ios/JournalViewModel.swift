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
    private var cellModels: [JournalModel] = [JournalModel]()

    var numberOfCells: Int {
        return cellModels.count
    }

    func getCellModel(at indexPath: IndexPath) -> JournalModel {
        return cellModels[indexPath.row]
    }

    let realmService = RealmService()
}

extension JournalViewModel: RealmServiceDelegate {
    func didFetchJournal(journals: [JournalModel]) {
        self.cellModels = journals
    }
}

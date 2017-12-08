//
//  ViewController.swift
//  Journals-ios
//
//  Created by Aries Yang on 2017/12/8.
//  Copyright © 2017年 Aries Yang. All rights reserved.
//

import UIKit
import Firebase

class JournalsListController: UITableViewController {

    var jounals: [Journal] = []
    let titleView: TitleView = {
        if let view = UIView.load(nibName: "TitleView") as? TitleView {
            return view
        } else {
            return TitleView()
        }
    }()

    let cellId = "journalsCell"

    override func viewDidLoad() {
        super.viewDidLoad()

        observeJournals()

        view.backgroundColor = UIColor.white
        setupTitleView()
        let nib = UINib(nibName: "JournalsCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellId)

    }

    func observeJournals() {
        let journalRef = Database.database().reference().child("journals")
        journalRef.observe(.childAdded, with: { (snapshot) in
            let id = snapshot.key
            print(id)
            guard let dictionary = snapshot.value as? [String: AnyObject],
            let title = dictionary["title"] as? String,
            let content = dictionary["content"] as? String,
            let url = dictionary["imageUrl"] as? String else { return }
            let journal = Journal(id: id, title: title, content: content, imageUrl: url)
            self.jounals.insert(journal, at: 0)

            DispatchQueue.main.async {
                self.tableView.reloadData()
            }

        }, withCancel: nil)
    }

    func setupTitleView() {
        titleView.addButton.addTarget(self, action: #selector(handleAdd), for: .touchUpInside)
    }

    @objc func handleAdd() {
        let storyboard = UIStoryboard(name: "Creating", bundle: nil)
        let creatingController = storyboard.instantiateViewController(withIdentifier: "newJournal")
        present(creatingController, animated: true, completion: nil)
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return titleView
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jounals.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if let cell =  tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? JournalsCell {
            let journal = jounals[indexPath.row]

            let url = "https://firebasestorage.googleapis.com/v0/b/journals-ios.appspot.com/o/image?alt=media&token=151a54f8-f517-4556-ad34-7ed4a3a99680"
            if let imageURL = URL(string: url) {
                DispatchQueue.global().async {
                    do {
                        let downloadImage = UIImage(data: try Data(contentsOf: imageURL))
                        DispatchQueue.main.async {
                            cell.journalImageView.image = downloadImage
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }

            cell.titleLabel.text = journal.title

            return cell
        } else {
            return UITableViewCell()
        }
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {

            let ref = Database.database().reference(fromURL: "https://journals-ios.firebaseio.com/")
            let journalRef = ref.child("journals").child(self.jounals[indexPath.row].id)
            journalRef.removeValue()

            self.jounals.remove(at: indexPath.row)

            tableView.deleteRows(at: [indexPath], with: .fade)

        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Editing", bundle: nil)
        guard let editingController = storyboard.instantiateViewController(withIdentifier: "editingJournal") as? EditingController else { return }
        let journal = jounals[indexPath.row]
        editingController.originTitle = journal.title
        editingController.originContent = journal.content
        editingController.originImageUrl = journal.imageUrl
        editingController.journalId = journal.id
        present(editingController, animated: true, completion: nil)
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 212
    }
}

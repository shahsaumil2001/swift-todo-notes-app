//
//  NoteListController+TableView+Delegates.swift
//
//

import UIKit

extension NoteListController: UITableViewDataSource {
    ///
    /// The func is `numberOfRowsInSection` returns number of row in section
    ///  A NoteListController's `numberOfRowsInSection` method
    ///
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notesVM.numberOfRows
    }
    
    ///
    /// The func is `cellForRowAt` returns cell for Row
    ///  A NoteListController's `cellForRowAt` method
    ///
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NotePreviewCell.staticIdentifier, for: indexPath) as? NotePreviewCell else {
            return NotePreviewCell()
        }
        cell.setupData(note: self.notesVM.getNote(indexPath))
        cell.deleteButton.tag = indexPath.row
        cell.editButton.tag = indexPath.row
        cell.deleteButton.addTarget(self, action: #selector(deleteClicked(_:)), for: .touchUpInside)
        cell.editButton.addTarget(self, action: #selector(editClicked(_:)), for: .touchUpInside)
        return cell
    }
}
extension NoteListController: UITableViewDelegate {
    ///
    /// The func is `scrollViewDidScroll` is managing actions when table view will scroll
    ///  A NoteListController's `scrollViewDidScroll` method
    ///
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // if tableview's scroll position is not 0 then change navigation appearance
        if (scrollView.contentOffset.y > 0) {
            self.navigationController?.navigationBar.backgroundColor = UIColor.appPrimary
            self.navigationController?.navigationBar.barTintColor = UIColor.appPrimary
            let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.appWhite]
            self.navigationController?.navigationBar.titleTextAttributes = textAttributes
        } else {
            self.navigationController?.navigationBar.backgroundColor = UIColor.clear
            self.navigationController?.navigationBar.barTintColor = UIColor.clear
        }
    }
}

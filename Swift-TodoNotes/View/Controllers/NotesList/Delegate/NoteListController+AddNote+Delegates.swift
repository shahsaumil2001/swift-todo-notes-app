//
//  NoteListController+AddNote+Delegates.swift
//
//

import UIKit

extension NoteListController: NoteListDelegate {
    ///
    /// The func is `noteEdited` refresh data once Note edited
    ///  A NoteListController's `noteEdited` method
    ///
    func noteEdited() {
        self.notesVM.fetchAllNotes()
    }
}

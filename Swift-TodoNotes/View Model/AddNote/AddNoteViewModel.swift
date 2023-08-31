//
//  AddNoteViewModel.swift
//  Swift-TodoNotes
//
//  Created by Saumil Shah on 25/08/23.
//

import CoreData

typealias AddNoteCompletion = (_ note: Note) -> Void
class AddNoteViewModel {

    // MARK: - Properties

    // MARK: - Function
    ///
    /// The func is `addNote` is adding Note in CoreData
    ///  A AddNoteViewModel's `addNote` method
    ///
    func addNote(noteText: String, completion: @escaping AddNoteCompletion) {
        guard let note = CoreDataManager.shared.insertNote(description: noteText, time: Date()) else { return }
        completion(note)
    }
    ///
    /// The func is `updateNote` is updating Note in CoreData
    ///  A AddNoteViewModel's `updateNote` method
    ///
    func updateNote(noteText: String, note: Note) {
        CoreDataManager.shared.update(description: noteText, date: Date(), note: note)
    }
}

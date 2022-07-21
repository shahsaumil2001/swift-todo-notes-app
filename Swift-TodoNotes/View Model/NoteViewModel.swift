//
//  NoteViewModel.swift
//
//

import CoreData

class NoteListViewModel {
    var notes: [NSManagedObject] = []

    var numberOfRows: Int {
        return self.notes.count
    }

    func getNote(_ indexPath: IndexPath) -> Note {
        return self.notes[indexPath.row] as! Note
    }

    func fetchAllPersons() -> [Note]? {
        /*Before you can do anything with Core Data, you need a managed object context. */
        let managedContext = CoreDataManager.shared.persistentContainer.viewContext

        /*As the name suggests, NSFetchRequest is the class responsible for fetching from Core Data.
         Initializing a fetch request with init(entityName:), fetches all objects of a particular entity. This is what you do here to fetch all Person entities.
         */
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: KeyConstants.note)

        /*You hand the fetch request over to the managed object context to do the heavy lifting. fetch(_:) returns an array of managed objects meeting the criteria specified by the fetch request.*/
        do {
            let notes = try managedContext.fetch(fetchRequest)
            return notes as? [Note]
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return nil
        }
    }
}

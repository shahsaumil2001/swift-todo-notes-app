import Foundation
import CoreData
import UIKit

class CoreDataManager {

    static let shared = CoreDataManager()
    private init() {} // Prevent clients from creating another instance.

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: KeyConstants.notes)
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    ///
    /// The func is `saveContext` save note
    ///  A CoreDataManager's `saveContext` method
    ///
    func saveContext () {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    ///
    /// The func is `insertNote` insert note
    ///  A CoreDataManager's `insertNote` method
    ///
    func insertNote(description: String, time: Date) -> Note? {

        let managedContext = CoreDataManager.shared.persistentContainer.viewContext

        let entity = NSEntityDescription.entity(forEntityName: KeyConstants.note, in: managedContext)!

        /*
         Initializes a managed object and inserts it into the specified managed object context.

         init(entity: NSEntityDescription,
         insertInto context: NSManagedObjectContext?)
         */
        let note = NSManagedObject(entity: entity, insertInto: managedContext)
        note.setValue(description, forKeyPath: KeyConstants.noteDescription)
        note.setValue(time, forKeyPath: KeyConstants.noteTime)

        do {
            try managedContext.save()
            return note as? Note
        } catch let error as NSError {
            debugPrint("Could not save. \(error), \(error.userInfo)")
            return nil
        }
    }

    ///
    /// The func is `update` update note's content
    ///  A CoreDataManager's `update` method
    ///
    func update(description: String, date: Date, note: Note) {

        let context = CoreDataManager.shared.persistentContainer.viewContext
        note.setValue(description, forKey: KeyConstants.noteDescription)
        note.setValue(date, forKey: KeyConstants.noteTime)

        /*
         You commit your changes to Note and save to disk by calling save on the managed object context. Note save can throw an error, which is why you call it using the try keyword within a do-catch block. Finally, insert the new managed object into the note array so it shows up when the table view reloads.
         */
        do {
            try context.save()
            debugPrint("saved!")
        } catch let error as NSError {
            debugPrint("Could not save \(error), \(error.userInfo)")
        } catch {
        }
    }

    ///
    /// The func is `delete` delete Note
    ///  A CoreDataManager's `delete` method
    ///
    func delete(note: Note) {
        let managedContext = CoreDataManager.shared.persistentContainer.viewContext
        managedContext.delete(note)

        do {
            try managedContext.save()
        } catch {
            // Do something in response to error condition
        }
    }

    ///
    /// The func is `fetchAllNotes` fetch notes from Core Date
    ///  A CoreDataManager's `fetchAllNotes` method
    ///
    func fetchAllNotes() -> [Note]? {
        /*Before you can do anything with Core Data, you need a managed object context. */
        let managedContext = CoreDataManager.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: KeyConstants.note)

        /*You hand the fetch request over to the managed object context to do the heavy lifting. fetch(_:) returns an array of managed objects meeting the criteria specified by the fetch request.*/
        do {
            let note = try managedContext.fetch(fetchRequest)
            return note as? [Note]
        } catch let error as NSError {
            debugPrint("Could not fetch. \(error), \(error.userInfo)")
            return nil
        }
    }

    ///
    /// The func is `delete` delet Note description
    ///  A CoreDataManager's `delete` method
    ///
    func delete(description: String) -> [Note]? {
        /*get reference of managed object context*/
        let managedContext = CoreDataManager.shared.persistentContainer.viewContext

        /*init fetch request*/
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: KeyConstants.note)

        /*pass your condition with NSPredicate. We only want to delete those records which match our condition*/
        fetchRequest.predicate = NSPredicate(format: "note_description == %@", description)
        do {
            /*managedContext.fetch(fetchRequest) will return array of Note objects [NoteObjects]*/
            let item = try managedContext.fetch(fetchRequest)
            var arrRemoevedNotes = [Note]()
            for itemObject in item {

                /*call delete method(aManagedObjectInstance)*/
                /*here i is managed object instance*/
                managedContext.delete(itemObject)

                /*finally save the contexts*/
                try managedContext.save()

                /*update your array also*/
                arrRemoevedNotes.append(itemObject as? Note ?? Note())
            }
            return arrRemoevedNotes
        } catch let error as NSError {
            debugPrint("Could not fetch. \(error), \(error.userInfo)")
            return nil
        }
    }
}

//
//  NotesCoordinator.swift
//  Swift-TodoNotes
//
//  Created by Saumil Shah on 23/08/23.
//

import UIKit

final class NotesCoordinator: Coordinator {
    var onShowHome: Action?

    var rootNavigationController: UINavigationController

    init(rootNavigationController: UINavigationController) {
        self.rootNavigationController = rootNavigationController
        // Navigation Configuration
        self.rootNavigationController.navigationBar.prefersLargeTitles = true
        self.rootNavigationController.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.appWhite, NSAttributedString.Key.font: Font.bold.size(size: FontSize.large1.rawValue)]
        self.rootNavigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.appWhite,
            NSAttributedString.Key.font: Font.bold.size(size: FontSize.body.rawValue)]
    }

    func start() {
        pushViewController(showNoteListController())
    }

    private func showNoteListController() -> UIViewController {
        let controller = Storyboard.main.instantiate(viewController: NoteListController.self)
        controller?.title = StringConstants.myNotes
        controller?.onAddNote = { [weak self] in
            self?.showAddNoteViewController(actionType: .add)
        }
        controller?.onEditNote = { [weak self] note in
            self?.showAddNoteViewController(actionType: .edit, note: note)
        }
        return controller ?? NoteListController()
    }

    private func showAddNoteViewController(actionType: ActionType, note: Note = Note()) {
        let controller = Storyboard.main.instantiate(viewController: AddNoteViewController.self)
        switch actionType {
        case .add:
            controller?.noteAction = .add
            controller?.delegate = UIApplication.topViewController() as? any NoteListDelegate
        case .edit:
            controller?.noteAction = .edit
            controller?.note = note
            controller?.delegate = UIApplication.topViewController() as? any NoteListDelegate
        case .delete:
            debugPrint("")
        }
        controller?.onNoteEdited = { [weak self] in
            controller?.delegate?.noteEdited()
            self?.dismissViewController()
        }
        controller?.modalPresentationStyle = .overCurrentContext
        presentViewController(controller)
    }
}

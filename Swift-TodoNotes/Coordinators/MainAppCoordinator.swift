//
//  MainAppCoordinator.swift
//  Swift-TodoNotes
//
//  Created by Saumil Shah on 23/08/23.
//

import UIKit

final class MainAppCoordinator: Coordinator {
    var rootNavigationController = UINavigationController()

    static let shared = MainAppCoordinator()

    private var activeCoordinator: Coordinator?

    // MARK: - Init
    init() {

    }

    func start() {
        startFlow()
    }

    private func startFlow() {
        self.setFirstViewController()
    }

    private func setFirstViewController() {
        self.showNotes()
    }

    private func showNotes() {
        let notesCoordinator = NotesCoordinator(rootNavigationController: rootNavigationController)
        notesCoordinator.start()
        activeCoordinator = notesCoordinator
    }
}

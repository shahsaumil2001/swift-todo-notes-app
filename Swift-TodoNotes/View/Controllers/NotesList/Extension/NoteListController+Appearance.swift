//
//  NoteListController+Appearance.swift
//  Swift-TodoNotes
//
//

import UIKit
extension NoteListController {
    ///
    /// The func is `initFont`is set Font for component
    ///  A NoteListController's `initFont` method
    ///
    func initFont() {
        self.noDataLabel.font =  Font.medium.size(size: FontSize.header2.rawValue)
    }
    ///
    /// The func is `initColor`is set Color for component
    ///  A NoteListController's `initColor` method
    ///
    func initColor() {
        self.view.backgroundColor = .appPrimary
        self.noDataLabel.textColor = .white
        self.addButton.addShadow(shadowColor: UIColor.appWhite.withAlphaComponent(0.5).cgColor)
    }
    ///
    /// The func is `setupNavigation`is set navigation 
    ///  A NoteListController's `setupNavigation` method
    ///
    func setupNavigation() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes =
        [NSAttributedString.Key.foregroundColor: UIColor.appWhite,
         NSAttributedString.Key.font: Font.bold.size(size: FontSize.large1.rawValue)]
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.appPrimary,
                                                                   NSAttributedString.Key.font: Font.bold.size(size: FontSize.body.rawValue)]
    }
}

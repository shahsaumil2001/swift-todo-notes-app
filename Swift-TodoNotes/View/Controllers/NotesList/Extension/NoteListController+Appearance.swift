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
        self.noDataLabel.font =  Font.medium.size(size: FontSize.header3.rawValue)
    }
    ///
    /// The func is `initColor`is set Color for component
    ///  A NoteListController's `initColor` method
    ///
    func initColor() {
        self.view.backgroundColor = .appPrimary
        self.noDataLabel.textColor = .appGray.withAlphaComponent(0.5)
        self.addButton.addShadow(shadowColor: UIColor.appWhite.withAlphaComponent(0.5).cgColor)
    }
}

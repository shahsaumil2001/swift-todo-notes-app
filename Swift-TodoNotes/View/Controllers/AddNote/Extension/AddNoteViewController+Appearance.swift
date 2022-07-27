//
//  AddNoteViewController+Appearance.swift
//  Swift-TodoNotes
//
//

import UIKit

extension AddNoteViewController {
    ///
    /// The func is `initColor`is managing color of UI
    ///  A AddNoteViewController's `initColor` method
    ///
    func initColor() {
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        self.containerView.backgroundColor = .appSecondary
        self.headerLabel.textColor = .white
        self.textView.textColor = .white
        self.placeholderLabel.textColor = .appGray
        self.doneButton.setTitleColor(.appBlue, for: .normal)
        self.textView.tintColor = .appBlue
    }
}

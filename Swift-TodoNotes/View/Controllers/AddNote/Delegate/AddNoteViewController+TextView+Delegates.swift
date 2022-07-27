//
//  AddNoteViewController+TextView+Delegates.swift
//
//

import UIKit

extension AddNoteViewController: UITextViewDelegate {
    ///
    /// The func is `textViewShouldBeginEditing` called when user start editing
    ///  A UITextViewDelegate's `textViewShouldBeginEditing` method
    ///
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        setPlaceholder()
        setDoneButton()
        return true
    }
    
    ///
    /// The func is `textViewDidChange` called when user Text updates
    ///  A UITextViewDelegate's `textViewDidChange` method
    ///
    func textViewDidChange(_ textView: UITextView) {
        setPlaceholder()
        setDoneButton()
    }
    
    ///
    /// The func is `textViewDidEndEditing` called when text updated
    ///  A UITextViewDelegate's `textViewDidEndEditing` method
    ///
    func textViewDidEndEditing(_ textView: UITextView) {
        setPlaceholder()
        setDoneButton()
    }
}

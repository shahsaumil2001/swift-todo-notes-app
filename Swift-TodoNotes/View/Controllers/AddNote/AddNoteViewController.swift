//
//  AddNoteViewController.swift
//
//

import UIKit

class AddNoteViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var placeholderLabel: UILabel!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var headerLabel: UILabel!
    
    // MARK: - Properties
    weak var delegate: NoteListDelegate?
    var noteAction: NoteAction = .add
    var note: Note?
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    
    // MARK: - Function
    fileprivate func setup() {
        // initColor
        self.initColor()
        // initText
        self.initText()
        self.setPlaceholder()
        self.setDoneButton()
        view.bringSubviewToFront(self.containerView)
        self.containerView.cornerRadius(radius: 20)
        self.shadowView.isHidden = true
        self.textView.delegate = self
    }
    fileprivate func initText() {
        self.headerLabel.text = noteAction == .add ? StringConstants.addNote : StringConstants.editNote
        if let note = note {
            self.textView.text = note.note_description
        }
    }
    ///
    /// The func is `setPlaceholder`is managing textview placeholder
    ///  A AddNoteViewController's `setPlaceholder` method
    ///
    func setPlaceholder() {
        if let text = textView.text, text.count == 0 {
            self.placeholderLabel.isHidden = false
        } else if let text = textView.text, text.count > 0 {
            self.placeholderLabel.isHidden = true
        } else {
        }
    }
    ///
    /// The func is `setDoneButton`is managing Done button userInteraction & visibility
    ///  A AddNoteViewController's `setDoneButton` method
    ///
    func setDoneButton() {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || textView.text == StringConstants.enterYourTextHere {
            self.doneButton.alpha = 0.5
            self.doneButton.isUserInteractionEnabled = false
        } else {
            self.doneButton.alpha = 1.0
            self.doneButton.isUserInteractionEnabled = true
        }
    }
    ///
    /// The func is `save`is used to save new / edited note
    ///  A AddNoteViewController's `save` method
    ///
    func save() {
        switch noteAction {
        case .add:
            let note = CoreDataManager.shared.insertNote(description: self.textView.text ?? "", time: Date())
            if note != nil {
                self.dismiss(animated: true) {
                    self.delegate?.noteEdited()
                }
            }
        case .edit:
            if let note = note {
                CoreDataManager.shared.update(description: self.textView.text ?? "", date: Date(), note: note)
                self.dismiss(animated: true) {
                    self.delegate?.noteEdited()
                }
            }
        }
    }
    
    // MARK: - Actions
    @IBAction fileprivate func closeClicked(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction fileprivate func doneClicked(_ sender: UIButton) {
        self.save()
    }
}

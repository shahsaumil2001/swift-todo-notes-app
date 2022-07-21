//
//  AddNoteViewController.swift
//
//

import UIKit

enum NoteAction: String {
    case add
    case edit
}

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

    fileprivate func setup() {
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)

        view.bringSubviewToFront(self.containerView)
        self.containerView.cornerRadius(radius: 20)
        // self.shadowView.addShadow(shadowColor: UIColor.appGray.cgColor, cornerRadius: 20)
        self.shadowView.isHidden = true
        self.containerView.backgroundColor = .appSecondary
        self.headerLabel.textColor = .white
        self.textView.textColor = .white
        self.placeholderLabel.textColor = .appGray
        self.doneButton.setTitleColor(.appBlue, for: .normal)
        self.textView.tintColor = .appBlue
        
        self.textView.delegate = self

        self.headerLabel.text = noteAction == .add ? "Add Note" : "Edit Note"

        if let note = note {
            self.textView.text = note.note_description
        }

        self.setPlaceholder()
        self.setDoneButton()
    }

    fileprivate func initText() {

    }

    fileprivate func initFont() {

    }

    fileprivate func initColor() {
        
    }

    // MARK: - Actions

    @IBAction fileprivate func closeClicked(_ sender: UIButton) {
        self.dismiss(animated: true)
    }

    @IBAction fileprivate func doneClicked(_ sender: UIButton) {
        self.save()
    }

    // MARK: - Functions

    func setPlaceholder() {
        if let text = textView.text, text.count == 0 {
            self.placeholderLabel.isHidden = false
        } else if let text = textView.text, text.count > 0 {
            self.placeholderLabel.isHidden = true
        } else {
        }
    }

    func setDoneButton() {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || textView.text == "Enter your text here" {
            self.doneButton.alpha = 0.5
            self.doneButton.isUserInteractionEnabled = false
        } else {
            self.doneButton.alpha = 1.0
            self.doneButton.isUserInteractionEnabled = true
        }
    }

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
}

extension AddNoteViewController: UITextViewDelegate {
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        setPlaceholder()
        setDoneButton()
        return true
    }

    func textViewDidChange(_ textView: UITextView) {
        setPlaceholder()
        setDoneButton()
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        setPlaceholder()
        setDoneButton()
    }
}

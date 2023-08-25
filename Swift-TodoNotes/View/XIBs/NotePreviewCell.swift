//
//  NotePreviewCell.swift
//
//

import UIKit

class NotePreviewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        // initFont
        self.initFont()
        // initColor
        self.initColor()
        self.mainView.cornerRadius(radius: 10.0)
    }

    // MARK: - Function
    ///
    /// The func is `initFont`is set Font for component
    ///  A NotePreviewCell's `initFont` method
    ///
    fileprivate func initFont() {
        self.descriptionLabel.font = Font.medium.size(size: FontSize.body.rawValue)
        self.timeLabel.font = Font.regular.size(size: FontSize.small.rawValue)
    }
    ///
    /// The func is `initColor`is set Color for component
    ///  A NotePreviewCell's `initColor` method
    ///
    fileprivate func initColor() {
        self.mainView.backgroundColor = .appSecondary
        self.descriptionLabel.textColor = .appWhite
        self.timeLabel.textColor = .appGray
        self.editButton.imageView?.image?.withRenderingMode(.alwaysTemplate).withTintColor(.appBlue)
        self.deleteButton.imageView?.image?.withRenderingMode(.alwaysTemplate).withTintColor(.appRed)
    }
    ///
    /// The func is `setupData`which is setting Data of Note
    ///  A NotePreviewCell's `setupData` method
    ///
    func setupData(note: Note) {
        self.descriptionLabel.text = note.noteDescription
        self.timeLabel.text = note.noteTime?.toLocalDate()
    }
}

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
    fileprivate func initFont() {
        self.descriptionLabel.font = Font.medium.size(size: FontSize.body.rawValue)
        self.timeLabel.font = Font.regular.size(size: FontSize.small.rawValue)
    }
    fileprivate func initColor() {
        self.mainView.backgroundColor = .appSecondary
        self.descriptionLabel.textColor = .appWhite
        self.timeLabel.textColor = .appGray
        self.editButton.imageView?.image?.withRenderingMode(.alwaysTemplate).withTintColor(.appBlue)
        self.deleteButton.imageView?.image?.withRenderingMode(.alwaysTemplate).withTintColor(.appBlue)
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

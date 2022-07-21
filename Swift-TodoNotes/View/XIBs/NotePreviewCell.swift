//
//  NotePreviewCell.swift
//
//

import UIKit

class NotePreviewCell: UITableViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()

        self.selectionStyle = .none
        self.initFont()
        self.initColor()
        self.mainView.cornerRadius(radius: 10.0)
    }

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

    func setupData(note: Note) {
        self.descriptionLabel.text = note.note_description
        self.timeLabel.text = note.note_time?.toLocalDate()
    }
}
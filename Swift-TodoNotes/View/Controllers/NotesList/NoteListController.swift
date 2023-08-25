//
//  NoteListController.swift
//
//

import UIKit

protocol NoteListDelegate: AnyObject {
    func noteEdited()
}

class NoteListController: UIViewController {
    
    var onAddNote: Action?
    var onEditNote: NoteTypeAction?
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var noDataLabel: UILabel!
    
    // MARK: - Properties
    let notesVM = NoteListViewModel()
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.notesVM.fetchAllNotes()
    }
    
    // MARK: - Function
    fileprivate func setup() {
        // initFont
        self.initFont()
        // initColor
        self.initColor()
        // initText
        self.initText()
        // Setup TebleView
        self.setupTableView()
        // Setup Navigation
        self.setupNavigation()
        // Init ViewModel
        self.initViewModel()
        self.noDataLabel.isHidden = true
    }
    ///
    /// The func is `initText`is managing text of UI
    ///  A NoteListController's `initText` method
    ///
    fileprivate func initText() {
        self.title = StringConstants.myNotes
        self.noDataLabel.text = StringConstants.noNotesAreAvailable
    }
    ///
    /// The func is `setupTableView`is managing tableview configuration
    ///  A NoteListController's `setupTableView` method
    ///
    fileprivate func setupTableView() {
        let nib = UINib(nibName: NotePreviewCell.staticIdentifier, bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: NotePreviewCell.staticIdentifier)
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    ///
    /// The func is `initViewModel`is managing API Callbacks
    ///  A NoteListController's `initViewModel` method
    ///
    fileprivate func initViewModel() {
        self.notesVM.handleSuccess = {
            DispatchQueue.main.async {
                self.noDataLabel.isHidden = self.notesVM.notes.count > 0 ? true : false
                self.tableView.reloadData()
            }
        }
    }
    ///
    /// The func is `handleCRUD`is managing operation as per Action Type (add, edit, delete)
    ///  A NoteListController's `handleCRUD` method
    ///
    fileprivate func handleCRUD(actionType: ActionType, row: Int) {
        switch actionType {
        case .add:
            self.onAddNote?()
        case .edit:
            let indexPath = IndexPath(row: row, section: 0)
            let notToEdit = self.notesVM.getNote(indexPath)
            self.onEditNote?(notToEdit)
        case .delete:
            let indexPath = IndexPath(row: row, section: 0)
            self.tableView.beginUpdates()
            self.tableView.deleteRows(at: [indexPath], with: .left)
            CoreDataManager.shared.delete(note: self.notesVM.notes[indexPath.row] as? Note ?? Note())
            self.notesVM.notes.remove(at: indexPath.row)
            self.tableView.endUpdates()
            self.noDataLabel.isHidden = self.notesVM.notes.count > 0 ? true : false
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.tableView.reloadData()
            }
        }
    }
    ///
    /// The func is `confirmationPopup`will show Alert for delete confirmation
    ///  A NoteListController's `confirmationPopup` method
    ///
    fileprivate func confirmationPopup(row: Int) {
        let alert = UIAlertController(title: StringConstants.myNotes, message: StringConstants.areYouSureYouWantToDeleteNote, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: StringConstants.cancel, style: UIAlertAction.Style.destructive, handler: nil))
        alert.addAction(UIAlertAction(title: StringConstants.continueText, style: UIAlertAction.Style.default, handler: {_ in
            // Delete Note
            self.handleCRUD(actionType: .delete, row: row)
        }))
        // Accessing alert view backgroundColor :
        alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = .appLightGray
        // Set title color
        alert.setValue(NSAttributedString(string: alert.title!, attributes: [NSAttributedString.Key.foregroundColor : UIColor.appWhite]), forKey: KeyConstants.attributedTitle)
        // Set message color
        alert.setValue(NSAttributedString(string: alert.message ?? "", attributes: [NSAttributedString.Key.foregroundColor : UIColor.appWhite]), forKey: KeyConstants.attributedMessage)

        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Actions
    @IBAction func addClicked(_ sender: UIButton) {
        self.handleCRUD(actionType: .add, row: sender.tag)
    }
    @IBAction func editClicked(_ sender: UIButton) {
        self.handleCRUD(actionType: .edit, row: sender.tag)
    }
    @IBAction func deleteClicked(_ sender: UIButton) {
        // Confirmation Popup to delete note
        self.confirmationPopup(row: sender.tag)
    }
}

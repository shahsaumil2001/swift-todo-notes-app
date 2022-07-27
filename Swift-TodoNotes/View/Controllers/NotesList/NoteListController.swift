//
//  NoteListController.swift
//
//

import UIKit

protocol NoteListDelegate: AnyObject {
    func noteEdited()
}

class NoteListController: UIViewController {
    
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
    fileprivate func initText() {
        self.noDataLabel.text = StringConstants.noNotesAreAvailable
    }
    fileprivate func setupTableView() {
        let nib = UINib(nibName: NotePreviewCell.staticIdentifier, bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: NotePreviewCell.staticIdentifier)
        self.tableView.dataSource = self
    }
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
            if let addNoteVC = Storyboard.main.instantiate(viewController: AddNoteViewController.self) {
                addNoteVC.modalPresentationStyle = .overCurrentContext
                addNoteVC.delegate = self
                addNoteVC.noteAction = .add
                self.present(addNoteVC, animated: true)
            }
        case .edit:
            if let addNoteVC = Storyboard.main.instantiate(viewController: AddNoteViewController.self) {
                addNoteVC.modalPresentationStyle = .overCurrentContext
                addNoteVC.delegate = self
                addNoteVC.noteAction = .edit
                let indexPath = IndexPath(row: row, section: 0)
                addNoteVC.note = self.notesVM.getNote(indexPath)
                self.present(addNoteVC, animated: true)
            }
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
    
    // MARK: - Actions
    @IBAction func addClicked(_ sender: UIButton) {
        self.handleCRUD(actionType: .add, row: sender.tag)
    }
    @IBAction func editClicked(_ sender: UIButton) {
        self.handleCRUD(actionType: .edit, row: sender.tag)
    }
    @IBAction func deleteClicked(_ sender: UIButton) {
        self.handleCRUD(actionType: .delete, row: sender.tag)
    }
}

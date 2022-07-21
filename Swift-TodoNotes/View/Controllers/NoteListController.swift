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
        fetchAllNotes()
    }

    fileprivate func setup() {
        self.view.backgroundColor = .appPrimary
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes =
        [NSAttributedString.Key.foregroundColor: UIColor.appWhite,
         NSAttributedString.Key.font: UIFont(name: "Montserrat-Bold", size: 30) ??
                                         UIFont.systemFont(ofSize: 30)]
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.appPrimary,
                                                                   NSAttributedString.Key.font: UIFont(name: "Montserrat-Bold", size: 16) ??
                                                                                                   UIFont.systemFont(ofSize: 16)]

        self.noDataLabel.text = "No notes are available!"
        self.noDataLabel.font = UIFont(name: "Montserrat-Medium", size: 20)
        self.noDataLabel.textColor = .white
        self.noDataLabel.isHidden = true
        self.addButton.addShadow(shadowColor: UIColor.appWhite.withAlphaComponent(0.5).cgColor)
        self.setupTableView()
    }

    fileprivate func setupTableView() {
        let nib = UINib(nibName: NotePreviewCell.staticIdentifier, bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: NotePreviewCell.staticIdentifier)

        self.tableView.dataSource = self
    }

    func fetchAllNotes() {
        if CoreDataManager.shared.fetchAllNotes() != nil {
            let notes = CoreDataManager.shared.fetchAllNotes()!
            self.notesVM.notes = notes.sorted { object1, object2 in
                return ((object1 as? Note)?.note_time)! > ((object2 as? Note)?.note_time)!
            }
            self.noDataLabel.isHidden = self.notesVM.notes.count > 0 ? true : false
            self.tableView.reloadData()
        }
    }

    // MARK: - Actions

    @IBAction fileprivate func addClicked(_ sender: UIButton) {
        if let addNoteVC = Storyboard.main.instantiate(viewController: AddNoteViewController.self) {
            addNoteVC.modalPresentationStyle = .overCurrentContext
            addNoteVC.delegate = self
            addNoteVC.noteAction = .add
            self.present(addNoteVC, animated: true)
        }
    }

    @IBAction fileprivate func editClicked(_ sender: UIButton) {
        if let addNoteVC = Storyboard.main.instantiate(viewController: AddNoteViewController.self) {
            addNoteVC.modalPresentationStyle = .overCurrentContext
            addNoteVC.delegate = self
            addNoteVC.noteAction = .edit
            let indexPath = IndexPath(row: sender.tag, section: 0)
            addNoteVC.note = self.notesVM.getNote(indexPath)
            self.present(addNoteVC, animated: true)
        }
    }

    @IBAction fileprivate func deleteClicked(_ sender: UIButton) {
        let indexPath = IndexPath(row: sender.tag, section: 0)
        self.tableView.beginUpdates()
        self.tableView.deleteRows(at: [indexPath], with: .left)
        CoreDataManager.shared.delete(note: self.notesVM.notes[indexPath.row] as! Note)
        self.notesVM.notes.remove(at: indexPath.row)
        self.tableView.endUpdates()
        self.noDataLabel.isHidden = self.notesVM.notes.count > 0 ? true : false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.tableView.reloadData()
        }
    }
}

extension NoteListController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notesVM.numberOfRows
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NotePreviewCell.staticIdentifier, for: indexPath) as? NotePreviewCell else {
            return NotePreviewCell()
        }
        cell.setupData(note: self.notesVM.getNote(indexPath))
        cell.deleteButton.tag = indexPath.row
        cell.editButton.tag = indexPath.row
        cell.deleteButton.addTarget(self, action: #selector(deleteClicked(_:)), for: .touchUpInside)
        cell.editButton.addTarget(self, action: #selector(editClicked(_:)), for: .touchUpInside)
        return cell
    }
}

extension NoteListController: NoteListDelegate {
    func noteEdited() {
        self.fetchAllNotes()
    }
}

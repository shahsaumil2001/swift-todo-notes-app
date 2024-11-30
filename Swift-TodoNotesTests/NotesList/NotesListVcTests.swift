//
//  NotesListVcTests.swift
//  Swift-TodoNotes
//
//  Created by Saumil Shah on 29/11/24.
//

import XCTest
@testable import Swift_TodoNotes

class NotesListVcTests: XCTestCase {

    var notesVC: NoteListController!
    var notesVM: NoteListViewModel!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        notesVC = UIStoryboard(name: Storyboard.main.rawValue, bundle: nil).instantiateInitialViewController() as? NoteListController
        notesVC.loadViewIfNeeded()
        notesVM = NoteListViewModel()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        notesVC = nil
        notesVM = nil
    }

    func testNotes_WhenCreated_HasOutletsAreConnected() throws {
        // Arrange
        _ = try XCTUnwrap(notesVC.noDataLabel, "noDataLabel does not have a referencing outlet")
        let tableView = try XCTUnwrap(notesVC.tableView, "tableView does not have a referencing outlet")

        // Assert
        XCTAssertEqual(tableView.numberOfSections, 1, "tableView has 1 section when the view controller initially loaded")
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), notesVM.numberOfRows, "tableView'numberOfRow are equal to notesVM.numberOfRows for 0 section when the view controller initially loaded")
    }
    
    func testNotes_WhenCreated_HasAddButtonAndAction() throws {
        // Arrange
        let addButton = try XCTUnwrap(notesVC.addButton, "addButton does not have a referencing outlet")

        // Act
        let addButtonActions = try XCTUnwrap(addButton.actions(forTarget: notesVC, forControlEvent: .touchUpInside), "Add button does not have any actions assigned to it")

        // Assert
        XCTAssertEqual(addButtonActions.count, 1)
        XCTAssertEqual(addButtonActions.first, "addClicked:", "There is no action with a name addClicked assigned to Done button")
    }
    
    func testNotes_WhenCreated_HasTableViewCellOutlets() throws {
        // Arrange
        let tableView = try XCTUnwrap(notesVC.tableView, "tableView does not have a referencing outlet")
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = tableView.dequeueReusableCell(withIdentifier: NotePreviewCell.staticIdentifier, for: indexPath) as? NotePreviewCell
        _ = try XCTUnwrap(cell?.mainView, "mainView does not have a referencing outlet")
        _ = try XCTUnwrap(cell?.descriptionLabel, "descriptionLabel does not have a referencing outlet")
        _ = try XCTUnwrap(cell?.timeLabel, "timeLabel does not have a referencing outlet")
        _ = try XCTUnwrap(cell?.editButton, "editButton does not have a referencing outlet")
        _ = try XCTUnwrap(cell?.deleteButton, "deleteButton does not have a referencing outlet")
    }
    
}

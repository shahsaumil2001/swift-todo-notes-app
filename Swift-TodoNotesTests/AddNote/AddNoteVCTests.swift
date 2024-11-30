//
//  AddNoteVCTests.swift
//  Swift-TodoNotesTests
//
//  Created by Saumil Shah on 29/11/24.
//

import XCTest
@testable import Swift_TodoNotes

class AddNoteVCTests: XCTestCase {

    var addNoteVC: AddNoteViewController!
    var addNoteVM: AddNoteViewModel!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        addNoteVC = UIStoryboard(name: Storyboard.main.rawValue, bundle: nil)
            .instantiateViewController(withIdentifier: "AddNoteViewController") as? AddNoteViewController 
        addNoteVC.loadViewIfNeeded()
        addNoteVM = AddNoteViewModel()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        addNoteVC = nil
        addNoteVM = nil
    }

    func testAddNote_WhenCreated_HasOutletsAreConnected() throws {
        // Act
        _ = try XCTUnwrap(addNoteVC.headerLabel, "headerLabel does not have a referencing outlet")
        _ = try XCTUnwrap(addNoteVC.textView, "textView does not have a referencing outlet")
        _ = try XCTUnwrap(addNoteVC.placeholderLabel, "placeholderLabel does not have a referencing outlet")
        _ = try XCTUnwrap(addNoteVC.containerView, "containerView does not have a referencing outlet")
        _ = try XCTUnwrap(addNoteVC.shadowView, "shadowView does not have a referencing outlet")
    }
    
    func testAddNote_WhenCreated_HasDoneButtonAndAction() throws {
        // Arrange
        let doneButton = try XCTUnwrap(addNoteVC.doneButton, "doneButton does not have a referencing outlet")

        // Act
        let doneButtonActions = try XCTUnwrap(doneButton.actions(forTarget: addNoteVC, forControlEvent: .touchUpInside), "Done button does not have any actions assigned to it")

        // Assert
        XCTAssertEqual(doneButtonActions.count, 1)
        XCTAssertEqual(doneButtonActions.first, "doneClicked:", "There is no action with a name doneClicked assigned to Done button")
    }
    
    func testAddNote_SaveNewNote() throws {
        addNoteVM.addNote(noteText: "test") { note in
            XCTAssertNotNil(note, "note should be not nil but it is nil")
        }
    }
}

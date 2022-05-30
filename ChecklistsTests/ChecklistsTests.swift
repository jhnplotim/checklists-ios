//
//  ChecklistsTests.swift
//  ChecklistsTests
//
//  Created by Otim John Paul on 25.05.22.
//

import XCTest
@testable import Checklists

class ChecklistsTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testListItemEmptyState() throws {
        let checklist = ListItem(title: "Shopping")
        XCTAssertTrue(checklist.checkListItems.isEmpty, "Check list should be empty")
        XCTAssertEqual(checklist.state, ListItem.State.noItems)
        XCTAssertEqual(checklist.state.message, L.Feature.Checklist.State.Noitems.label)
    }
    
    func testListItemAllDoneState() throws {
        let checklist = ListItem(title: "Shopping")
        checklist.checkListItems.append(ChecklistItem(title: "Shoes", isChecked: true))
        XCTAssertFalse(checklist.checkListItems.isEmpty, "Check list should NOT be empty")
        XCTAssertEqual(checklist.state, ListItem.State.allItemsDone)
        XCTAssertEqual(checklist.state.message, L.Feature.Checklist.State.Allitemsdone.label)
    }
    
    func testListItemItemsRemainingState() throws {
        let checklist = ListItem(title: "Shopping")
        checklist.checkListItems.append(ChecklistItem(title: "Shoes", isChecked: false))
        XCTAssertFalse(checklist.checkListItems.isEmpty, "Check list should NOT be empty")
        XCTAssertEqual(checklist.state, ListItem.State.itemsRemaining(1))
        XCTAssertEqual(checklist.state.message, L.Feature.Checklist.State.Itemsremaining.label(1))
    }
    
    func testDataModelSorting() throws {
        let l1 = ListItem(title: "Shopping")
        let l2 = ListItem(title: "Bar hopping")
        let l3 = ListItem(title: "Alpha")
        let dataModel = DataModel(items: [l1, l2])
        
        XCTAssertTrue(dataModel.count == 2)
        XCTAssertFalse(dataModel.isEmpty)
        XCTAssertEqual(dataModel.getItems()[0], l2)
        XCTAssertEqual(dataModel.getItems()[1], l1)
        
        dataModel.append(l3)
        XCTAssertTrue(dataModel.count == 3)
        XCTAssertEqual(dataModel.getItem(at: 0), l3)
        XCTAssertEqual(dataModel.getItem(at: 1), l2)
        
        dataModel.remove(at: 0)
        XCTAssertTrue(dataModel.count == 2)
        XCTAssertEqual(dataModel.getItem(at: 0), l2)
        
        dataModel.remove(at: 0)
        XCTAssertTrue(dataModel.count == 1)
        XCTAssertEqual(dataModel.getItem(at: 0), l1)
        
        dataModel.append(contentsOf: [l3, l2])
        XCTAssertTrue(dataModel.count == 3)
        XCTAssertEqual(dataModel.getItem(at: 0), l3)
        XCTAssertEqual(dataModel.getItem(at: 1), l2)
        XCTAssertEqual(dataModel.getItem(at: 2), l1)
    }

}

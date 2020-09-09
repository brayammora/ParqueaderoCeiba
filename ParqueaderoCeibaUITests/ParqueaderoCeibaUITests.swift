//
//  ParqueaderoCeibaUITests.swift
//  ParqueaderoCeibaUITests
//
//  Created by Brayam Alberto Mora Arias - Ceiba Software on 5/08/20.
//  Copyright © 2020 Brayam Alberto Mora Arias - Ceiba Software. All rights reserved.
//

import XCTest

class ParqueaderoCeibaUITests: XCTestCase {

    var app: XCUIApplication!
    
    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testLoadVehicleListWith1RecordOnMainView() {
        let countRecords = MainParkScreen.vehicleTableView.element.cells.count
        XCTAssertEqual(countRecords, 1, "Expected 1 cell")
    }
    
    func testGoToAddVehicleView() {
        MainParkScreen.addButton.element.tap()
        XCTAssert(AddVehicleScreen.navigationBar.element.exists)
    }
    
    func testAddMotorbikeInfoAndConfirmParkingMessage() {
        MainParkScreen.addButton.element.tap()
        fillForm(vehicleType: "Motorbike", numberPlate: "QWE123", cc: "800")
        AddVehicleScreen.doneButton.element.tap()
        let alertSuccessAdded = AlertScreen.alert.element.staticTexts["Vehicle parked succesfully."].exists
        XCTAssert(alertSuccessAdded)
    }
    
    private func fillForm(vehicleType: String, numberPlate: String, cc: String) {
        AddVehicleScreen.typeVehiclePicker.element.adjust(toPickerWheelValue: vehicleType)
        AddVehicleScreen.numberPlateTextField.element.tap()
        AddVehicleScreen.numberPlateTextField.element.typeText(numberPlate)
        AddVehicleScreen.ccTextField.element.tap()
        AddVehicleScreen.ccTextField.element.typeText(cc)
    }
    
    func testDeleteVehicleFromTableAndConfirmPaymentMessage() {
        let countRecordsBefore = MainParkScreen.vehicleTableView.element.cells.count
        MainParkScreen.vehicleTableView.element.staticTexts["Number Plate: ABC123"].longSwipe(.left)
        let isAlertDelete = AlertScreen.alert.element.staticTexts["Delete vehicle"].exists
        AlertScreen.alert.element.buttons["OK"].tap()
        sleep(1)
        let isAlertPayment = AlertScreen.alert.element.staticTexts["Total to pay!"].exists
        AlertScreen.alert.element.buttons["OK"].tap()
        let countRecordsAfter = MainParkScreen.vehicleTableView.element.cells.count
        
        XCTAssert(isAlertDelete)
        XCTAssert(isAlertPayment)
        XCTAssertNotEqual(countRecordsBefore, countRecordsAfter)
    }
    
    func testCancelAttemptToDeleteAVehicle() {
        let countRecordsBefore = MainParkScreen.vehicleTableView.element.cells.count
        let vehicleCell = MainParkScreen.vehicleTableView.element.staticTexts["Number Plate: ABC123"]
        vehicleCell.longSwipe(.left)
        AlertScreen.alert.element.buttons["CANCEL"].tap()
        let countRecordsAfter = MainParkScreen.vehicleTableView.element.cells.count
        XCTAssertEqual(countRecordsBefore, countRecordsAfter)
    }
}

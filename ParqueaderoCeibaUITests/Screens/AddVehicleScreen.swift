//
//  AddVehicleScreen.swift
//  ParqueaderoCeibaUITests
//
//  Created by Brayam Alberto Mora Arias - Ceiba Software on 8/09/20.
//  Copyright © 2020 Brayam Alberto Mora Arias - Ceiba Software. All rights reserved.
//

import XCTest

enum AddVehicleScreen {
    case typeVehiclePicker
    case numberPlateTextField
    case ccTextField
    case navigationBar
    case doneButton
    
    var element: XCUIElement {
        switch self {
        case .typeVehiclePicker:
            return XCUIApplication().pickerWheels.element
        case .numberPlateTextField:
            return XCUIApplication().textFields["NumberPlateTextField"]
        case .ccTextField:
            return XCUIApplication().textFields["CCTextField"]
        case .navigationBar:
            return XCUIApplication().navigationBars["Add Vehicle"]
        case .doneButton:
            return XCUIApplication().navigationBars["Add Vehicle"].buttons["Done"]
        }
    }
}

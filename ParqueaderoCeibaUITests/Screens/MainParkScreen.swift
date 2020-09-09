//
//  MainParkScreen.swift
//  ParqueaderoCeibaUITests
//
//  Created by Brayam Alberto Mora Arias - Ceiba Software on 8/09/20.
//  Copyright © 2020 Brayam Alberto Mora Arias - Ceiba Software. All rights reserved.
//

import XCTest

enum MainParkScreen {
    case vehicleTableView
    case navigationBar
    case addButton
    
    var element: XCUIElement {
        switch self {
        case .vehicleTableView:
            return XCUIApplication().tables["vehicleTableView"]
        case .navigationBar:
            return XCUIApplication().navigationBars["Vehicles"]
        case .addButton:
            return XCUIApplication().navigationBars["Vehicles"].buttons["Add"]
        }
    }
}

//
//  AlertScreen.swift
//  ParqueaderoCeibaUITests
//
//  Created by Brayam Alberto Mora Arias - Ceiba Software on 8/09/20.
//  Copyright © 2020 Brayam Alberto Mora Arias - Ceiba Software. All rights reserved.
//

import XCTest

enum AlertScreen {
    case alert
    
    var element: XCUIElement {
        switch self {
        case .alert:
            return XCUIApplication().alerts.element
        }
    }
}

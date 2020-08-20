//
//  VehicleDataBuilder.swift
//  ParqueaderoCeibaTests
//
//  Created by Brayam Alberto Mora Arias - Ceiba Software on 18/08/20.
//  Copyright © 2020 Brayam Alberto Mora Arias - Ceiba Software. All rights reserved.
//

import Foundation
@testable import ParqueaderoCeiba

class VehicleTestDataBuilder {
    var type: String
    var numberPlate: String
    var cc: Int
    var date: Date
    
    init() {
        self.type = "Default Value"
        self.numberPlate = "Default Value"
        self.cc = 0
        self.date = Date()
    }
    
    func withType (_ type: String) {
        self.type = type
    }
    
    func withNumberPlate (_ numberPlate: String) {
        self.numberPlate = numberPlate
    }
    
    func withCC (_ cc: Int) {
        self.cc = cc
    }
    
    func withDate (_ date: Date) {
        self.date = date
    }
    
    func build () -> Vehicle {
        return Vehicle(type: type, numberPlate: numberPlate, cc: cc, date: date)
    }
}

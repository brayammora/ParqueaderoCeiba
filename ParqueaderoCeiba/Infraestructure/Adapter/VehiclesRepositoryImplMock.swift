//
//  VehiclesRepositoryImplMock.swift
//  ParqueaderoCeibaTests
//
//  Created by Brayam Alberto Mora Arias - Ceiba Software on 18/08/20.
//  Copyright © 2020 Brayam Alberto Mora Arias - Ceiba Software. All rights reserved.
//

import Foundation

class VehiclesRepositoryImplMock: VehiclesRepository {
    
    var vehicles: [Vehicle]
    
    init() {
        self.vehicles = [
            Vehicle(type: "car", numberPlate: "ABC123", cc: 0, date: Date())
        ]
    }
    
    func getAllParkedVehicles() -> [Vehicle] {
        return vehicles
    }
    
    func addVehicle(_ vehicle: Vehicle) -> Bool {
        return false
    }
    
    func findVehicle(_ numberPlate: String) -> Bool {
        let vehiclePersistent = vehicles.filter{ $0.numberPlate == numberPlate }
        if let _ = vehiclePersistent.first {
            return true
        }
        return false
    }
}

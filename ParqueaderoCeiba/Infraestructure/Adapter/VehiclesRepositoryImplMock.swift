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
    
    func getAllParkedVehicles(completion: @escaping RepositoryCompletion) {
        completion(.success(vehicles))
    }
    
    func addVehicle(_ vehicle: Vehicle) {
        vehicles.append(vehicle)
    }
    
    func findVehicle(_ numberPlate: String) -> Bool {
        let vehiclePersistent = vehicles.filter{ $0.numberPlate == numberPlate }
        if let _ = vehiclePersistent.first {
            return true
        }
        return false
    }
    
    func getCountByVehicleType(_ type: String) -> Int {
        // return type == Constants.car ? Constants.carLimit : Constants.motorbikeLimit
        let vehiclePersistent = vehicles.filter{ $0.type == type }
        return vehiclePersistent.count
    }
    
    func removeVehicle(_ vehicle: Vehicle) {
        if let index = vehicles.firstIndex(where: { $0.numberPlate == vehicle.numberPlate }) {
            vehicles.remove(at: index)
        }
    }
    
}

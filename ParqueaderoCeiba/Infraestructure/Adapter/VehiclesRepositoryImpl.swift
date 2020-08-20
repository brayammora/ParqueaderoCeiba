//
//  VehiclesRepositoryImpl.swift
//  ParqueaderoCeiba
//
//  Created by Brayam Alberto Mora Arias - Ceiba Software on 17/08/20.
//  Copyright © 2020 Brayam Alberto Mora Arias - Ceiba Software. All rights reserved.
//

import Foundation
import RealmSwift

class VehiclesRepositoryImpl: VehiclesRepository {

    var realm: Realm!
        
    init() {
        do {
            realm = try Realm()
        } catch let error {
            print("Error while initializing Realm -> \(error.localizedDescription)")
        }
    }
    
    func getAllParkedVehicles() -> [Vehicle] {
        return MapperVehicleImpl.mapVehicleResultSetToArray(realm.objects(VehiclePersistent.self))
    }
    
    func addVehicle(_ vehicle: Vehicle) -> Bool {
        var response = true
        do {
            try realm.write {
                realm.add(MapperVehicleImpl.mapIntoVehiclePersistent(vehicle))
            }
        } catch let error {
            print("Error while writing into Realm -> \(error.localizedDescription)")
            response = false
        }
        
        return response
    }
    
    func findVehicle(_ numberPlate: String) -> Bool {
        let vehiclePersistent = realm.objects(VehiclePersistent.self).filter("numberPlate == '\(numberPlate)'")
        if let _ = vehiclePersistent.first {
            return true
        }
        return false
    }
    
}

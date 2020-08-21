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
            print("Realm error: \(error.localizedDescription)")
        }
    }
    
    func getAllParkedVehicles() -> [Vehicle] {
        return MapperVehicleImpl.mapVehicleResultSetToArray(realm.objects(VehiclePersistent.self))
    }
    
    func addVehicle(_ vehicle: Vehicle) -> Bool {
        do {
            try realm.write {
                realm.add(MapperVehicleImpl.mapIntoVehiclePersistent(vehicle))
            }
        } catch let error {
            print("Error insert Realm -> \(error.localizedDescription)")
            return false
        }
        
        return true
    }
    
    func findVehicle(_ numberPlate: String) -> Bool {
        let vehiclePersistent = realm.objects(VehiclePersistent.self).filter("numberPlate == '\(numberPlate)'")
        if let _ = vehiclePersistent.first {
            return true
        }
        return false
    }
    
    func getCountByVehicleType(_ type: String) -> Int {
        let vehicleType = realm.objects(VehiclePersistent.self).filter("type = '\(type)'")
        return vehicleType.count
    }
    
    func removeVehicle(_ vehicle: Vehicle) -> Bool {
        let vehiclePersistent = realm.objects(VehiclePersistent.self).filter("numberPlate == '\(vehicle.numberPlate)'")
        if let vPersistent = vehiclePersistent.first {
            do {
                try realm.write {
                    realm.delete(vPersistent)
                }
            } catch let error {
                print("Error delete Realm -> \(error.localizedDescription)")
                return false
            }
        }
        return true
    }
    
}

//
//  VehiclesRepositoryImpl.swift
//  ParqueaderoCeiba
//
//  Created by Brayam Alberto Mora Arias - Ceiba Software on 17/08/20.
//  Copyright © 2020 Brayam Alberto Mora Arias - Ceiba Software. All rights reserved.
//

import Foundation
import RealmSwift

struct VehiclesRepositoryImpl: VehiclesRepository {
    
    private let queue = DispatchQueue(label: "background", qos: .background)
    
    func getAllParkedVehicles(completion: @escaping RepositoryCompletion) {
        queue.async {
            autoreleasepool {
                let realm = try! Realm()
                let vehicles = MapperVehicleImpl.mapVehicleResultSetToArray(realm.objects(VehiclePersistent.self))
                    completion(.success(vehicles))
            }
        }
    }
    
    func addVehicle(_ vehicle: Vehicle) {
        queue.async {
            autoreleasepool {
                do {
                    let realm = try Realm()
                    try realm.write {
                        realm.add(MapperVehicleImpl.mapIntoVehiclePersistent(vehicle))
                    }
                } catch let error {
                    print("Error insert Realm -> \(error.localizedDescription)")
                }
            }
        }
    }
    
    func removeVehicle(_ vehicle: Vehicle) {
        queue.async {
            autoreleasepool {
                let realm = try! Realm()
                let vehiclePersistent =  realm.objects(VehiclePersistent.self).filter("numberPlate == '\(vehicle.numberPlate)'")
                if let vPersistent = vehiclePersistent.first {
                    do {
                        try realm.write {
                            realm.delete(vPersistent)
                        }
                    } catch let error {
                        print("Error delete Realm -> \(error.localizedDescription)")
                    }
                }
            }
        }
    }
    
    func findVehicle(_ numberPlate: String) -> Bool {
        let realm = try! Realm()
        let vehiclePersistent = realm.objects(VehiclePersistent.self).filter("numberPlate == '\(numberPlate)'")
        if let _ = vehiclePersistent.first {
            return true
        }
        return false
    }
    
    func getCountByVehicleType(_ type: String) -> Int {
        let realm = try! Realm()
        let vehicleType = realm.objects(VehiclePersistent.self).filter("type = '\(type)'")
        return vehicleType.count
    }
    
}

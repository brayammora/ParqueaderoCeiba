//
//  MapperVehicleImpl.swift
//  ParqueaderoCeiba
//
//  Created by Brayam Alberto Mora Arias - Ceiba Software on 17/08/20.
//  Copyright © 2020 Brayam Alberto Mora Arias - Ceiba Software. All rights reserved.
//

import Foundation
import RealmSwift

class MapperVehicleImpl: MapperVehicleProtocol {
    
    static func mapIntoVehiclePersistent(_ vehicle: Vehicle) -> VehiclePersistent {
        let vehiclePersistent = VehiclePersistent()
        vehiclePersistent.type = vehicle.type
        vehiclePersistent.numberPlate = vehicle.numberPlate
        vehiclePersistent.cc = vehicle.cc
        vehiclePersistent.date = vehicle.date
        
        return vehiclePersistent
    }
    
    static func mapIntoVehicle(_ vehiclePersistent: VehiclePersistent) -> Vehicle {
        let vehicle = Vehicle(
            type: vehiclePersistent.type,
            numberPlate : vehiclePersistent.numberPlate,
            cc: vehiclePersistent.cc,
            date: vehiclePersistent.date
        )
        return vehicle
    }
    
    static func mapVehicleResultSetToArray(_ vehicleResultSet: Results<VehiclePersistent>) -> [Vehicle] {
        var vehicleList: [Vehicle] = []
        for vPersistent in vehicleResultSet {
            vehicleList.append(mapIntoVehicle(vPersistent))
        }
        return vehicleList
    }
}

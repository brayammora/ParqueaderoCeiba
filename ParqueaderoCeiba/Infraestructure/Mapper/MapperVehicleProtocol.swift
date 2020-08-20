//
//  MapperVehicleProtocol.swift
//  ParqueaderoCeiba
//
//  Created by Brayam Alberto Mora Arias - Ceiba Software on 17/08/20.
//  Copyright © 2020 Brayam Alberto Mora Arias - Ceiba Software. All rights reserved.
//

import Foundation
import RealmSwift

protocol MapperVehicleProtocol {
    static func mapIntoVehiclePersistent (_ vehicle: Vehicle) -> VehiclePersistent
    static func mapIntoVehicle (_ VehiclePersistent: VehiclePersistent) -> Vehicle
    static func mapVehicleResultSetToArray (_ vehicleResultSet: Results<VehiclePersistent>) -> [Vehicle]
}

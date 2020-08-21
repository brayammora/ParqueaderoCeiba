//
//  VehiclesRepository.swift
//  ParqueaderoCeiba
//
//  Created by Brayam Alberto Mora Arias - Ceiba Software on 17/08/20.
//  Copyright © 2020 Brayam Alberto Mora Arias - Ceiba Software. All rights reserved.
//

import Foundation

protocol VehiclesRepository {
    func getAllParkedVehicles() -> [Vehicle]
    func addVehicle(_ vehicle: Vehicle) -> Bool
    func findVehicle(_ numberPlate: String) -> Bool
    func getCountByVehicleType(_ type: String) -> Int
    func removeVehicle(_ vehicle: Vehicle) -> Bool
}

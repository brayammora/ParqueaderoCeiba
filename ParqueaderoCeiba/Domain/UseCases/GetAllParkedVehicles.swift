//
//  GetAllParkedVehicles.swift
//  ParqueaderoCeiba
//
//  Created by Brayam Alberto Mora Arias - Ceiba Software on 16/08/20.
//  Copyright © 2020 Brayam Alberto Mora Arias - Ceiba Software. All rights reserved.
//

import Foundation

typealias GetAllParkedVehiclesCompletion = ( (_ response: Result<Any, GetAllParkedVehiclesErrors>) -> Void )

class GetAllParkedVehicles {
    let vehiclesRepository: VehiclesRepository

    init(withRepository vehiclesRepository: VehiclesRepository) {
        self.vehiclesRepository = vehiclesRepository
    }
    
    func execute(completion: @escaping GetAllParkedVehiclesCompletion) {
        let vehicles = vehiclesRepository.getAllParkedVehicles()
        if !vehicles.isEmpty {
            completion(.success(vehicles))
        } else {
            completion(.failure(.noDataAvaliable))
        }
    }
}


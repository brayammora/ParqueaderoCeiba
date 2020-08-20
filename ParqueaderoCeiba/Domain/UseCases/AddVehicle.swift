//
//  AddVehicle.swift
//  ParqueaderoCeiba
//
//  Created by Brayam Alberto Mora Arias - Ceiba Software on 19/08/20.
//  Copyright © 2020 Brayam Alberto Mora Arias - Ceiba Software. All rights reserved.
//

import Foundation

typealias AddVehicleCompletion = ( (_ response: Result<Any, AddVehicleErrors>) -> Void )

class AddVehicle {
    let vehiclesRepository: VehiclesRepository
    
    // MARK: Messages
    let vehicleAdded = "Vehicle added succesfully."

    init(withRepository vehiclesRepository: VehiclesRepository) {
        self.vehiclesRepository = vehiclesRepository
    }
    
    func execute(_ vehicle: Vehicle, completion: @escaping AddVehicleCompletion) {
        
        if itsAlreadyParked(vehicle.numberPlate) {
            completion(.failure(.itsAlreadyParked))
        }
        
        // si cumple todas las condiciones puede agregar el vehiculo
        let response = vehiclesRepository.addVehicle(vehicle)
        if response {
            completion(.success(vehicleAdded))
        } else {
            completion(.failure(.vehicleCantAdded))
        }
    }
    
    func itsAlreadyParked(_ numberPlate: String) -> Bool {
        return vehiclesRepository.findVehicle(numberPlate)
    }
}

enum AddVehicleErrors: String, Error {
    case itsAlreadyParked = "The vehicle you are trying to enter is already parked."
    case vehicleCantAdded = "The vehicle can't added to database, please try later."
}

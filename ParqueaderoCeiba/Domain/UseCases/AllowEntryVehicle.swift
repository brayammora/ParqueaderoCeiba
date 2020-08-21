//
//  AllowEntryVehicle.swift
//  ParqueaderoCeiba
//
//  Created by Brayam Alberto Mora Arias - Ceiba Software on 19/08/20.
//  Copyright © 2020 Brayam Alberto Mora Arias - Ceiba Software. All rights reserved.
//

import Foundation

typealias AllowEntryVehicleCompletion = ( (_ response: Result<Any, AllowEntryVehicleErrors>) -> Void )

class AllowEntryVehicle {
    let vehiclesRepository: VehiclesRepository
    
    // MARK: Messages
    let vehicleAdded = "Vehicle parked succesfully."

    init(withRepository vehiclesRepository: VehiclesRepository) {
        self.vehiclesRepository = vehiclesRepository
    }
    
    func execute(_ vehicle: Vehicle, completion: @escaping AllowEntryVehicleCompletion) {
        
        if isAlreadyParked(vehicle.numberPlate) {
            completion(.failure(.itsAlreadyParked))
            return
        }
        if isThereSiteAvaliableByVehicleType(vehicle.type) {
            completion(.failure(.parkIsFull))
            return
        }
        if canEnterToday(vehicle.numberPlate) {
            completion(.failure(.canNotEnterToday))
            return
        }
        
        let response = vehiclesRepository.addVehicle(vehicle)
        if response {
            completion(.success(vehicleAdded))
        } else {
            completion(.failure(.vehicleCantAdded))
        }
    }
    
    private func isAlreadyParked(_ numberPlate: String) -> Bool {
        return vehiclesRepository.findVehicle(numberPlate)
    }
    
    private func isThereSiteAvaliableByVehicleType(_ type: String) -> Bool {
        let count = vehiclesRepository.getCountByVehicleType(type)
        return (type.lowercased() == Constants.car && count == Constants.carLimit) ||
            (type.lowercased() == Constants.motorbike && count == Constants.motorbikeLimit)
    }
    
    private func canEnterToday (_ numberPlate: String) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let today = dateFormatter.string(from: Date())
        
        return numberPlate.starts(with: Constants.numberPlateStartsWith) &&
            (today.lowercased() != Constants.sunday ||
            today.lowercased() != Constants.monday)
    }
}

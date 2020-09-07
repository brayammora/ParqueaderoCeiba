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
        if canNotEnterToday(vehicle.numberPlate, vehicle.date) {
            completion(.failure(.canNotEnterToday))
            return
        }
        vehiclesRepository.addVehicle(vehicle)
        completion(.success(vehicleAdded))
    }
    
    private func isAlreadyParked(_ numberPlate: String) -> Bool {
        return vehiclesRepository.findVehicle(numberPlate)
    }
    
    private func isThereSiteAvaliableByVehicleType(_ type: String) -> Bool {
        let count = vehiclesRepository.getCountByVehicleType(type)
        return (type == Constants.car && count == Constants.carLimit) ||
            (type == Constants.motorbike && count == Constants.motorbikeLimit)
    }
    
    private func canNotEnterToday (_ numberPlate: String, _ date: Date) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let today = dateFormatter.string(from: date)
        
        return (today.lowercased() == Constants.sunday ||
            today.lowercased() == Constants.monday) &&
            numberPlate.starts(with: Constants.numberPlateStartsWithA)
    }
}

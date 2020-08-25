//
//  AllowExitVehicle.swift
//  ParqueaderoCeiba
//
//  Created by Brayam Alberto Mora Arias - Ceiba Software on 21/08/20.
//  Copyright © 2020 Brayam Alberto Mora Arias - Ceiba Software. All rights reserved.
//

import Foundation

typealias AllowExitVehicleCompletion = ( (_ response: Result<Any, AllowExitVehicleErrors>) -> Void )

class AllowExitVehicle {
    let vehiclesRepository: VehiclesRepository
    
    // MARK: Messages

    init(withRepository vehiclesRepository: VehiclesRepository) {
        self.vehiclesRepository = vehiclesRepository
    }
    
    func execute(_ vehicle: Vehicle, completion: @escaping AllowExitVehicleCompletion) {
        
        let totalCharge = calculatePayment(vehicle)
        let vehicleExit = "The cost of parking is: \(totalCharge)."
        let response = vehiclesRepository.removeVehicle(vehicle)
        if response {
            completion(.success(vehicleExit))
        } else {
            completion(.failure(.vehicleCantExit))
        }
    }
    
    private func calculatePayment(_ vehicle: Vehicle) -> Double {
        let (days,hours) = CalculateParkingTime.getParkingTime(vehicle.date)
        return CalculatePayment.calculatePayment(withDays: days, withHours: hours, withVehicle: vehicle)
    }
}

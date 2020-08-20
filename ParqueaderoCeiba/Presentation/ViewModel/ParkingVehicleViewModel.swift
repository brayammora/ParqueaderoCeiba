//
//  ParkingVehicleViewModel.swift
//  ParqueaderoCeiba
//
//  Created by Brayam Alberto Mora Arias - Ceiba Software on 16/08/20.
//  Copyright © 2020 Brayam Alberto Mora Arias - Ceiba Software. All rights reserved.
//

import Foundation

class ParkingVehicleViewModel {
    
    let addVehicle: AddVehicle
    var message: String = String()
    var messageError: String = String()
    
    init(with addVehicle: AddVehicle) {
        self.addVehicle = addVehicle
    }
    
    func addVehicle(vehicle: Vehicle) {
        addVehicle.execute(vehicle) { [weak self] response in
            guard let _ = self else {
                return
            }
            
            switch response {
            case .success(let result):
                self?.message = result as! String
                break
            case .failure(let error):
                self?.messageError = error.rawValue
                break
            }
        }
    }
    
}

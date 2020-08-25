//
//  ParkingVehicleViewModel.swift
//  ParqueaderoCeiba
//
//  Created by Brayam Alberto Mora Arias - Ceiba Software on 16/08/20.
//  Copyright © 2020 Brayam Alberto Mora Arias - Ceiba Software. All rights reserved.
//

import Foundation

class ParkingVehicleViewModel {
    
    let allowEntryVehicle: AllowEntryVehicle
//    var pickerSelection: String = String()
    
    // MARK: View Messages
    let cellId = "vehicleCell"
    let navigationTitle = "Add Vehicle"
    let messageMandatoryFields = "Please, all fields are required."
    let pickerOptions = ["Car", "Motorbike"]
    var message: String = ""
    
    init(with allowEntryVehicle: AllowEntryVehicle) {
        self.allowEntryVehicle = allowEntryVehicle
    }
    
    func allowEntryVehicle(_ numberPlate: String, _ cc: String, _ type: String) {
        let newVehicle = Vehicle(type: type, numberPlate: numberPlate, cc: Int(cc) ?? 0, date: Date())
        allowEntryVehicle.execute(newVehicle) { [weak self] response in
            guard let _ = self else {
                return
            }
            switch response {
            case .success(let result):
                self?.message = result as! String
                break
            case .failure(let error):
                self?.message = error.description
                break
            }
        }
    }
    
}

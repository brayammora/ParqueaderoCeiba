//
//  MainParkViewModel.swift
//  ParqueaderoCeiba
//
//  Created by Brayam Alberto Mora Arias - Ceiba Software on 16/08/20.
//  Copyright © 2020 Brayam Alberto Mora Arias - Ceiba Software. All rights reserved.
//

import Foundation

class MainParkViewModel {
    
    let getAllParkedVehicles: GetAllParkedVehicles
    var vechicles: [Vehicle] = [
        Vehicle(type: "car", numberPlate: "ABC123", cc: 0, date: Date())
    ]
    
    // MARK: View Messages
    let cellId = "vehicleCell"
    let navigationTitle = "Vehicles"
    let emptyListMessage = "Parking is empty"
    var messageError: String = String()
    
    init(with getAllParkedVehicles: GetAllParkedVehicles) {
        self.getAllParkedVehicles = getAllParkedVehicles
    }
    
    func loadVechicles() {
        getAllParkedVehicles.execute() { [weak self] response in
            guard let _ = self else {
                return
            }
            
            switch response {
            case .success(let result):
                self?.vechicles = result as! [Vehicle]
                break
            case .failure(let error):
                self?.messageError = error.rawValue
                break
            }
        }
    }
}

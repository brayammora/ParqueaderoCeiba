//
//  MainParkViewModel.swift
//  ParqueaderoCeiba
//
//  Created by Brayam Alberto Mora Arias - Ceiba Software on 16/08/20.
//  Copyright © 2020 Brayam Alberto Mora Arias - Ceiba Software. All rights reserved.
//

import Foundation

protocol MainParkViewModelDelegate: class {
    func reloadTable()
}

class MainParkViewModel {
    
    let getAllParkedVehicles: GetAllParkedVehicles
    let allowExitVehicle: AllowExitVehicle
    weak var delegate: MainParkViewModelDelegate?
    var vechicles: [Vehicle] = []
    
    // MARK: View Messages
    let cellId = "vehicleCell"
    let navigationTitle = "Vehicles"
    let emptyListMessage = "Parking is empty"
    var message = String()
    
    init(with getAllParkedVehicles: GetAllParkedVehicles, with allowExitVehicle: AllowExitVehicle) {
        self.getAllParkedVehicles = getAllParkedVehicles
        self.allowExitVehicle = allowExitVehicle
    }
    
    func loadVechicles() {
        getAllParkedVehicles.execute() { [weak self] response in
            guard let _ = self else {
                return
            }
            
            switch response {
            case .success(let result):
                self?.vechicles = result as! [Vehicle]
                self?.delegate?.reloadTable()
                break
            case .failure(let error):
                self?.message = error.description
                break
            }
        }
    }
    
    func allowExitVehicle(_ vehicle: Vehicle) {
        allowExitVehicle.execute(vehicle) { [weak self] response in
            guard let _ = self else {
                return
            }
            
            switch response {
            case .success(let result):
                self?.message = result as! String
                self?.removeVehicle(vehicle)
                self?.delegate?.reloadTable()
                break
            case .failure(let error):
                self?.message = error.description
                break
            }
        }
    }
    
    private func removeVehicle(_ vehicle: Vehicle) {
        let index = vechicles.firstIndex{ $0.numberPlate == vehicle.numberPlate }
        vechicles.remove(at: index!)
    }
}

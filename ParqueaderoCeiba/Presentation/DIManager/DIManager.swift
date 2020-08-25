//
//  DIManager.swift
//  ParqueaderoCeiba
//
//  Created by Brayam Alberto Mora Arias - Ceiba Software on 19/08/20.
//  Copyright © 2020 Brayam Alberto Mora Arias - Ceiba Software. All rights reserved.
//

import Foundation
import Swinject

class DIManager {
    private var container: Container!
    
    init() {
        container = Container()
        registerRepositories()
        registerUseCases()
        registerViewModels()
        registerViewControllers()
    }
    
    func getContainer() -> Container {
        return self.container
    }
    
    func registerRepositories() {
        container.register(VehiclesRepository.self  ) { _ in
            #if TEST
            return VehiclesRepositoryImplMock()
            #elseif DEBUG
            return VehiclesRepositoryImpl()
            #endif
        }.inObjectScope(.container)
    }
    
    func registerUseCases() {
        container.register(GetAllParkedVehicles.self) { r in
            GetAllParkedVehicles(withRepository: r.resolve(VehiclesRepository.self)!)
        }
        container.register(AllowEntryVehicle.self) { r in
            AllowEntryVehicle(withRepository: r.resolve(VehiclesRepository.self)!)
        }
        container.register(AllowExitVehicle.self) { r in
            AllowExitVehicle(withRepository: r.resolve(VehiclesRepository.self)!)
        }
    }
    
    func registerViewModels() {
        container.register(MainParkViewModel.self) { r in
            MainParkViewModel(with: r.resolve(GetAllParkedVehicles.self)!, with: r.resolve(AllowExitVehicle.self)!)
        }
        container.register(ParkingVehicleViewModel.self) { r in
            ParkingVehicleViewModel(with: r.resolve(AllowEntryVehicle.self)!)
        }
    }
    
    func registerViewControllers() {
        container.register(MainParkViewController.self) { r in
            MainParkViewController(withViewModel: r.resolve(MainParkViewModel.self)!)
        }
        container.register(ParkingVehicleViewController.self) { r in
            ParkingVehicleViewController(withViewModel: r.resolve(ParkingVehicleViewModel.self)!)
        }
    }
}

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
            #if ParqueaderoCeiba
            return VehiclesRepositoryImpl()
            #else
            return VehiclesRepositoryImplMock()
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
    }
    
    func registerViewModels() {
        container.register(MainParkViewModel.self) { r in
            MainParkViewModel(with: r.resolve(GetAllParkedVehicles.self)!)
        }
    }
    
    func registerViewControllers() {
        container.register(MainParkViewController.self) { r in
            MainParkViewController(withViewModel: r.resolve(MainParkViewModel.self)!)
        }
    }
}

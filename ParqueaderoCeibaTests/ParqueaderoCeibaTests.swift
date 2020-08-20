//
//  ParqueaderoCeibaTests.swift
//  ParqueaderoCeibaTests
//
//  Created by Brayam Alberto Mora Arias - Ceiba Software on 5/08/20.
//  Copyright © 2020 Brayam Alberto Mora Arias - Ceiba Software. All rights reserved.
//

import XCTest
import Swinject
@testable import ParqueaderoCeiba

class ParqueaderoCeibaTests: XCTestCase {

    var vehicleDataBuilder: VehicleTestDataBuilder!
    // MARK: - DI initializing
    let container: Container = {
        return DIManager().getContainer()
    }()
    
    override func setUp()  {
        vehicleDataBuilder = VehicleTestDataBuilder()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCanGetgetAllParkedVehiclesFromLocalDataSource() {
        // Arrange - Act
        var vehiclesCount = 0
        container.resolve(GetAllParkedVehicles.self)?.execute() { response in
            switch response {
            case .success(let data):
                vehiclesCount = (data as! [Vehicle]).count
                break
            case .failure(_):
                break
            }
        }
        // Assert
        XCTAssertEqual(vehiclesCount, 1)
    }
        
    func testItsAlreadyParked() {
        // Arrange
        vehicleDataBuilder.withNumberPlate("ABC123")
        let vehicle: Vehicle = vehicleDataBuilder.build()
        // Act
        guard let itsAlreadyParked = container.resolve(AddVehicle.self)?.itsAlreadyParked(vehicle.numberPlate) else { return }
        // Assert
        XCTAssertTrue(itsAlreadyParked)
    }
    
}

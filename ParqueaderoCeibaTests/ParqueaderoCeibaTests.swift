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
    var dateDataBuilder: DateDataBuilder!
    
    // MARK: - DI initializing
    let container: Container = { 
        return DIManager().getContainer()
    }()
    
    override func setUp()  {
        vehicleDataBuilder = VehicleTestDataBuilder()
        dateDataBuilder = DateDataBuilder()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // MARK: GetAllParkedVehicles UseCase Tests
    func testCanGetAllParkedVehiclesWith1VehicleInDataBase() {
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
    
    // MARK: AllowEntryVehicle UseCase Tests
    func testCanPark() {
        // Arrange
        vehicleDataBuilder.withNumberPlate("BBB222")
        let vehicle: Vehicle = vehicleDataBuilder.build()
        var resultMessage: String!
        // Act
        container.resolve(AllowEntryVehicle.self)?.execute(vehicle) { response in
            switch response {
            case .success(let result):
                resultMessage = (result as! String)
                break
            case .failure(_):
                break
            }
        }
        // Assert
        XCTAssertEqual(resultMessage, "Vehicle parked succesfully.")
    }
    
    func testIsAlreadyParked() {
        // Arrange
        vehicleDataBuilder.withNumberPlate("ABC123")
        let vehicle: Vehicle = vehicleDataBuilder.build()
        var errorType: AllowEntryVehicleErrors!
        // Act
        container.resolve(AllowEntryVehicle.self)?.execute(vehicle) { response in
            switch response {
            case .success(_):
                break
            case .failure(let error):
                errorType = error
                break
            }
        }
        // Assert
        XCTAssertEqual(errorType, AllowEntryVehicleErrors.itsAlreadyParked)
    }
    
    func testThereIsNoSiteAvaliableWithCarType() {
        // Arrange
        vehicleDataBuilder.withType(Constants.car)
        let vehicle: Vehicle = vehicleDataBuilder.build()
        var errorType: AllowEntryVehicleErrors!
        // Act
        container.resolve(AllowEntryVehicle.self)?.execute(vehicle) { response in
            switch response {
            case .success(_):
                break
            case .failure(let error):
                errorType = error
                break
            }
        }
        // Assert
        XCTAssertEqual(errorType, AllowEntryVehicleErrors.parkIsFull)
    }
    
    func testThereIsNoSiteAvaliableWithMotorbikeType() {
        // Arrange
        vehicleDataBuilder.withType(Constants.motorbike)
        let vehicle: Vehicle = vehicleDataBuilder.build()
        var errorType: AllowEntryVehicleErrors!
        // Act
        container.resolve(AllowEntryVehicle.self)?.execute(vehicle) { response in
            switch response {
            case .success(_):
                break
            case .failure(let error):
                errorType = error
                break
            }
        }
        // Assert
        XCTAssertEqual(errorType, AllowEntryVehicleErrors.parkIsFull)
    }
    
    func testCanNotEnterWhenIsMondayAndNumberPlateStartsWithA() {
        //Arrange
        vehicleDataBuilder.withNumberPlate("AAA111")
        dateDataBuilder.withMonday()
        vehicleDataBuilder.withDate(dateDataBuilder.build())
        let vehicle: Vehicle = vehicleDataBuilder.build()
        var errorType: AllowEntryVehicleErrors!
        // Act
        container.resolve(AllowEntryVehicle.self)?.execute(vehicle) { response in
            switch response {
            case .success(_):
                break
            case .failure(let error):
                errorType = error
                break
            }
        }
        // Assert
        XCTAssertEqual(errorType, AllowEntryVehicleErrors.canNotEnterToday)
    }
    
    /* La tabla de precios es la siguiente:
            Valor hora carro = 1000
            Valor hora moto = 500
            Valor día carro = 8000
            Valor día moto = 4000
            Moto con CC mayor a 500 = valor total + 2000
    */
    
    // MARK: CalculateParkingTime UseCase Tests
    func testCalculateParkingTimeWithLessThan9Hours() {
        //Arrange
        dateDataBuilder.withDays(0)
        dateDataBuilder.withHours(4)
        dateDataBuilder.withMinutes(30)
        vehicleDataBuilder.withDate(dateDataBuilder.build())
        let vehicle: Vehicle = vehicleDataBuilder.build()
        //Act
        let (days, hours) = CalculateParkingTime.getParkingTime(vehicle.date)
        //Assert
        XCTAssertEqual(0, days)
        XCTAssertEqual(5, hours)
    }
    
    func testCalculateParkingTimeWithMoreThan9HoursAndLessThan24Hours() {
        //Arrange
        dateDataBuilder.withDays(0)
        dateDataBuilder.withHours(15)
        dateDataBuilder.withMinutes(30)
        vehicleDataBuilder.withDate(dateDataBuilder.build())
        let vehicle: Vehicle = vehicleDataBuilder.build()
        //Act
        let (days, hours) = CalculateParkingTime.getParkingTime(vehicle.date)
        //Assert
        XCTAssertEqual(1, days)
        XCTAssertEqual(0, hours)
    }
    
    func testCalculateParkingTimeWith15DaysAnd2Hours() {
        //Arrange
        dateDataBuilder.withDays(15)
        dateDataBuilder.withHours(1)
        dateDataBuilder.withMinutes(30)
        vehicleDataBuilder.withDate(dateDataBuilder.build())
        let vehicle: Vehicle = vehicleDataBuilder.build()
        //Act
        let (days, hours) = CalculateParkingTime.getParkingTime(vehicle.date)
        //Assert
        XCTAssertEqual(15, days)
        XCTAssertEqual(2, hours)
    }
    
    // MARK: CalculatePayment UseCase Tests
    func testCalculatePaymentCarWith4Hours() {
        //Arrange
        dateDataBuilder.withDays(0)
        dateDataBuilder.withHours(3)
        dateDataBuilder.withMinutes(25)
        vehicleDataBuilder.withDate(dateDataBuilder.build())
        vehicleDataBuilder.withType(Constants.car)
        let vehicle: Vehicle = vehicleDataBuilder.build()
        //Act
        let (days, hours) = CalculateParkingTime.getParkingTime(vehicle.date)
        let totalCharge = CalculatePayment.calculatePayment(withDays: days, withHours: hours, withVehicle: vehicle)
        //Assert
        XCTAssertEqual(totalCharge, 4000)
    }
    
    func testCalculatePaymentCarWithMoreThan9HoursAndLessThan24Hours() {
        //Arrange
        dateDataBuilder.withDays(0)
        dateDataBuilder.withHours(13)
        dateDataBuilder.withMinutes(25)
        vehicleDataBuilder.withDate(dateDataBuilder.build())
        vehicleDataBuilder.withType(Constants.car)
        let vehicle: Vehicle = vehicleDataBuilder.build()
        //Act
        let (days, hours) = CalculateParkingTime.getParkingTime(vehicle.date)
        let totalCharge = CalculatePayment.calculatePayment(withDays: days, withHours: hours, withVehicle: vehicle)
        //Assert
        XCTAssertEqual(totalCharge, 8000)
    }
    
    func testCalculatePaymentCarWith3daysAnd2Hours() {
        //Arrange
        dateDataBuilder.withDays(3)
        dateDataBuilder.withHours(1)
        dateDataBuilder.withMinutes(15)
        vehicleDataBuilder.withDate(dateDataBuilder.build())
        vehicleDataBuilder.withType(Constants.car)
        let vehicle: Vehicle = vehicleDataBuilder.build()
        //Act
        let (days, hours) = CalculateParkingTime.getParkingTime(vehicle.date)
        let totalCharge = CalculatePayment.calculatePayment(withDays: days, withHours: hours, withVehicle: vehicle)
        //Assert
        XCTAssertEqual(totalCharge, 26000)
    }
    
    func testCalculatePaymentMotorbikeWith4Hours() {
        //Arrange
        dateDataBuilder.withDays(0)
        dateDataBuilder.withHours(3)
        dateDataBuilder.withMinutes(25)
        vehicleDataBuilder.withDate(dateDataBuilder.build())
        vehicleDataBuilder.withType(Constants.motorbike)
        let vehicle: Vehicle = vehicleDataBuilder.build()
        //Act
        let (days, hours) = CalculateParkingTime.getParkingTime(vehicle.date)
        let totalCharge = CalculatePayment.calculatePayment(withDays: days, withHours: hours, withVehicle: vehicle)
        //Assert
        XCTAssertEqual(totalCharge, 2000)
    }
    
    func testCalculatePaymentMotorbikeWithMoreThan9HoursAndLessThan24Hours() {
        //Arrange
        dateDataBuilder.withDays(0)
        dateDataBuilder.withHours(13)
        dateDataBuilder.withMinutes(25)
        vehicleDataBuilder.withDate(dateDataBuilder.build())
        vehicleDataBuilder.withType(Constants.motorbike)
        let vehicle: Vehicle = vehicleDataBuilder.build()
        //Act
        let (days, hours) = CalculateParkingTime.getParkingTime(vehicle.date)
        let totalCharge = CalculatePayment.calculatePayment(withDays: days, withHours: hours, withVehicle: vehicle)
        //Assert
        XCTAssertEqual(totalCharge, 4000)
    }
    
    func testCalculatePaymentMotorbikeWith3daysAnd2Hours() {
        //Arrange
        dateDataBuilder.withDays(3)
        dateDataBuilder.withHours(1)
        dateDataBuilder.withMinutes(15)
        vehicleDataBuilder.withDate(dateDataBuilder.build())
        vehicleDataBuilder.withType(Constants.motorbike)
        let vehicle: Vehicle = vehicleDataBuilder.build()
        //Act
        let (days, hours) = CalculateParkingTime.getParkingTime(vehicle.date)
        let totalCharge = CalculatePayment.calculatePayment(withDays: days, withHours: hours, withVehicle: vehicle)
        //Assert
        XCTAssertEqual(totalCharge, 13000)
    }
    
    func testCalculatePaymentMotorbikeWith1DayAndExtraCC() {
        //Arrange
        dateDataBuilder.withDays(1)
        dateDataBuilder.withHours(0)
        dateDataBuilder.withMinutes(0)
        vehicleDataBuilder.withDate(dateDataBuilder.build())
        vehicleDataBuilder.withType(Constants.motorbike)
        vehicleDataBuilder.withCC(700)
        let vehicle: Vehicle = vehicleDataBuilder.build()
        //Act
        let (days, hours) = CalculateParkingTime.getParkingTime(vehicle.date)
        let totalCharge = CalculatePayment.calculatePayment(withDays: days, withHours: hours, withVehicle: vehicle)
        //Assert
        XCTAssertEqual(totalCharge, 6000)
    }
    
}

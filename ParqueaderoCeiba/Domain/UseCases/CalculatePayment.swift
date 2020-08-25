//
//  CalculatePayment.swift
//  ParqueaderoCeiba
//
//  Created by Brayam Alberto Mora Arias - Ceiba Software on 21/08/20.
//  Copyright © 2020 Brayam Alberto Mora Arias - Ceiba Software. All rights reserved.
//

import Foundation

class CalculatePayment {
    
    static func calculatePayment(withDays days: Int, withHours hours: Int, withVehicle vehicle: Vehicle) -> Double {
        
        var totalCharge: Double = 0
        
        switch vehicle.type {
            case Constants.car:
                totalCharge =  (CarPrices.day.rawValue * Double(days)) + (CarPrices.hour.rawValue * Double(hours))
                break
            case Constants.motorbike:
                totalCharge = (MotorbikePrices.day.rawValue * Double(days)) + (MotorbikePrices.hour.rawValue * Double(hours))
                if vehicle.cc >= Constants.ccLimitMotorbike {
                    totalCharge += MotorbikePrices.ccExtra.rawValue
                }
                break
            default:
                break
        }
        
        return totalCharge
    }
}

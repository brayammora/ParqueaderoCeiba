//
//  CalculateParkingTime.swift
//  ParqueaderoCeiba
//
//  Created by Brayam Alberto Mora Arias - Ceiba Software on 21/08/20.
//  Copyright © 2020 Brayam Alberto Mora Arias - Ceiba Software. All rights reserved.
//

import Foundation

class CalculateParkingTime {
    
    static func getParkingTime(_ vehicleEnterDate: Date) -> (Int, Int) {
        
        let diffComponents = Calendar.current.dateComponents([.hour, .day, .minute, .second], from: vehicleEnterDate, to: Date())
        var days = diffComponents.day ?? 0
        var hours = diffComponents.hour ?? 0
        var minutes = diffComponents.minute ?? 0
        var seconds = diffComponents.second ?? 0

        if seconds != Constants.zeroMinutes {
            minutes += 1
            seconds = 0
        }
        
        if minutes != Constants.zeroMinutes {
            hours += 1
            minutes = 0
        }
        
        if hours > Constants.maxHoursPerDay {
            days += 1
            hours = 0
        }
        return (days,hours)
    }
    
}

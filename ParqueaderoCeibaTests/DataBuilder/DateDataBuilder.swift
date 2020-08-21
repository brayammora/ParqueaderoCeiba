//
//  DateDataBuilder.swift
//  ParqueaderoCeibaTests
//
//  Created by Brayam Alberto Mora Arias - Ceiba Software on 20/08/20.
//  Copyright © 2020 Brayam Alberto Mora Arias - Ceiba Software. All rights reserved.
//

import Foundation

class DateDataBuilder {
    
    var dateComponents: DateComponents
    var calendar: Calendar
    var year: Int
    var month: Int
    var day: Int
    var hour: Int
    var minute: Int
    
    init() {
        self.dateComponents = DateComponents()
        self.calendar = Calendar.current
        self.dateComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: Date())
        self.year = dateComponents.year!
        self.month = dateComponents.month!
        self.day = dateComponents.day!
        self.hour = dateComponents.hour!
        self.minute = dateComponents.minute!
    }
    
    func withYear (_ year: Int) {
        dateComponents.year = year
    }
    
    func withMonth (_ month: Int) {
        dateComponents.month = month
    }
    
    func withDays (_ days: Int) {
        dateComponents.day = dateComponents.day! - days
    }
    
    func withHours (_ hours: Int) {
        dateComponents.hour = dateComponents.hour! - hours
    }
    
    func withMinutes (_ minutes: Int) {
        dateComponents.minute = dateComponents.minute! - minutes
    }
    
    func withMonday() {
        dateComponents.year = 2020
        dateComponents.day = 24
        dateComponents.month = 8
    }
    
    func build () -> Date {
        return Calendar.current.date(from: dateComponents) ?? Date()
    }
}

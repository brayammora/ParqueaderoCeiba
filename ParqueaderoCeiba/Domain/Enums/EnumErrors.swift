//
//  EnumTypeError.swift
//  ParqueaderoCeiba
//
//  Created by Brayam Alberto Mora Arias - Ceiba Software on 19/08/20.
//  Copyright © 2020 Brayam Alberto Mora Arias - Ceiba Software. All rights reserved.
//

import Foundation

enum GetAllParkedVehiclesErrors: Error {
    case noDataAvaliable
    
    var description: String {
        switch self {
        case .noDataAvaliable:
            return "There is no information available to show."
        }
    }
}

enum AllowEntryVehicleErrors: String, Error {
    case itsAlreadyParked
    case parkIsFull
    case canNotEnterToday
    case vehicleCantAdded
    
    var description: String {
        switch self {
        case .itsAlreadyParked:
            return "The vehicle you are trying to enter is already parked."
        case .parkIsFull:
            return "The park is full. The vehicle can't enter."
        case .canNotEnterToday:
            return "The vehicle can't enter today because number plate not is permitted on monday and sunday."
        case .vehicleCantAdded:
            return "The vehicle can't added to database, please try later."
        }
    }
}

enum AllowExitVehicleErrors: Error {
    case vehicleCantExit
    
    var description: String {
        switch self {
        case .vehicleCantExit:
            return "There is a problem with the exit, please try again."
        }
    }
}

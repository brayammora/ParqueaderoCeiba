//
//  EnumTypeError.swift
//  ParqueaderoCeiba
//
//  Created by Brayam Alberto Mora Arias - Ceiba Software on 19/08/20.
//  Copyright © 2020 Brayam Alberto Mora Arias - Ceiba Software. All rights reserved.
//

import Foundation

enum TypeError: String, Error {
    case internalError = "A internal error has ocurred."
    case serverError = "A serverError error has ocurred."
    case requestError = "A requestError error has ocurred."
}

enum GetAllParkedVehiclesErrors: String, Error {
    case noDataAvaliable = "There is no information available to show."
}

enum AllowEntryVehicleErrors: String, Error {
    case itsAlreadyParked = "The vehicle you are trying to enter is already parked."
    case parkIsFull = "The park is full. The vehicle can't enter."
    case canNotEnterToday = "The vehicle can't enter today because number plate not is permitted on monday and sunday."
    case vehicleCantAdded = "The vehicle can't added to database, please try later."
}

enum AllowExitVehicleErrors: String, Error {
    case vehicleCantExit = "There is a problem with the exit, please try again."
}

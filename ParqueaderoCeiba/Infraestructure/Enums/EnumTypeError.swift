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

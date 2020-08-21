//
//  EnumParkingPrices.swift
//  ParqueaderoCeiba
//
//  Created by Brayam Alberto Mora Arias - Ceiba Software on 21/08/20.
//  Copyright © 2020 Brayam Alberto Mora Arias - Ceiba Software. All rights reserved.
//

import Foundation

enum CarPrices: Double {
    case hour = 1_000
    case day = 8_000
}

enum MotorbikePrices: Double {
    case hour = 500
    case day = 4_000
    case ccExtra = 2_000
}

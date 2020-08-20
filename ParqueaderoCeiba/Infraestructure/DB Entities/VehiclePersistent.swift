//
//  VehiclePersistent.swift
//  ParqueaderoCeiba
//
//  Created by Brayam Alberto Mora Arias - Ceiba Software on 17/08/20.
//  Copyright © 2020 Brayam Alberto Mora Arias - Ceiba Software. All rights reserved.
//

import Foundation
import RealmSwift

class VehiclePersistent: Object {
    @objc dynamic var type: String = ""
    @objc dynamic var numberPlate: String = ""
    @objc dynamic var cc: Int = 0
    @objc dynamic var date: Date = Date()
}

//
//  💯.swift
//  iBarber
//
//  Created by Macbook Pro on 10/11/16.
//  Copyright © 2016 Macbook Pro. All rights reserved.
//

import UIKit
import RealmSwift

class 💯: Object {
    dynamic var operation: String = "hajvágás"
    dynamic var price: Int = 100
    override static func primaryKey() -> String? {
        return "operation"
    }
    
}

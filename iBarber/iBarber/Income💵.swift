//
//  Income💵.swift
//  iBarber
//
//  Created by Macbook Pro on 10/11/16.
//  Copyright © 2016 Macbook Pro. All rights reserved.
//

import UIKit
import RealmSwift

class Income💵: Object {
    dynamic var client: Client😎?
    dynamic var price: Int=420
    dynamic var total: Int=500
    dynamic var tip: Int {
        return total-price
    }
    
    
}

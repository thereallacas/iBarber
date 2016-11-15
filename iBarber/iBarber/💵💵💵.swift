//
//  💵💵💵.swift
//  iBarber
//
//  Created by Macbook Pro on 14/11/16.
//  Copyright © 2016 Macbook Pro. All rights reserved.
//

import UIKit
import RealmSwift

class 💵💵💵: Object {
    dynamic var name = "TheClientList"
    dynamic var createdAt = NSDate()
    let clients = List<💇>()
}

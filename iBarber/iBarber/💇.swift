//
//  💇.swift
//  iBarber
//
//  Created by Macbook Pro on 08/11/16.
//  Copyright © 2016 Macbook Pro. All rights reserved.
//

import UIKit
import RealmSwift

class 💇: Object {

    dynamic var name:String = "Minta Jakab"
    dynamic var picture:String = "NOIMAGE"
    dynamic var desc: String = "Nullással tarkóig 👌😂"
    dynamic var phoneNumber: String = "420"
    dynamic var incomeCount: Int = 0
    
    func addPhoto(Picture p:String){
        picture = p;
    }
    
    override static func primaryKey() -> String? {
        return "name"
    }
    
    
    let incomes = LinkingObjects(fromType: 💵.self, property: "client")
    
    
}

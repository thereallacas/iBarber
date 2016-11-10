//
//  Client😎.swift
//  iBarber
//
//  Created by Macbook Pro on 08/11/16.
//  Copyright © 2016 Macbook Pro. All rights reserved.
//

import UIKit
import RealmSwift

class Client😎: Object {

    dynamic var name:String = "Minta Jakab"
    dynamic var picture:String?
    dynamic var desc: String = "Nullással tarkóig 👌😂"
    dynamic var phoneNumber: Int = 420
    
    func addPhoto(Picture p:String){
        picture = p;
    }
    
    
    
}

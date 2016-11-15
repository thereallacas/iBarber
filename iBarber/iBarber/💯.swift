//
//  💯.swift
//  iBarber
//
//  Created by Macbook Pro on 10/11/16.
//  Copyright © 2016 Macbook Pro. All rights reserved.
//

import UIKit

class 💯: NSObject {
    var pricelist: [String : Int]?
    override init(){
        super.init()
        pricelist = ["Basic": 100, "Fade": 150, "Shaving":200]
        let lazyMapCollection = pricelist!.keys
        
        let stringArray = Array(lazyMapCollection)
        print(stringArray)
    }
}

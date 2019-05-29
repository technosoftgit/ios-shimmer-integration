//
//  DayDataModel.swift

//
//  Created by Zain Arshad on 01/11/2018.
//  Copyright © 2018 Technosoft Solutions. All rights reserved.
//

import Foundation
// Day DataModel
struct DayDataModel {
    var steps:Int
    var day:Int
    var date:Date
    var name:String
    
    init(steps: Int, day: Int, date: Date, name: String) {
        self.steps=steps
        self.day=day
        self.date=date
        self.name=name
    }
}

//
//  WeekDataModel.swift

//
//  Created by Zain Arshad on 01/11/2018.
//  Copyright © 2018 Technosoft Solutions. All rights reserved.
//

import Foundation
// Week DataModel
struct WeekDataModel {
    var steps:Int
    var startDate:Date
    var endDate:Date
    var week:Int
    
    init(steps: Int, startDate: Date, endDate: Date, week: Int) {
        self.steps=steps
        self.startDate=startDate
        self.endDate=endDate
        self.week=week
    }
}


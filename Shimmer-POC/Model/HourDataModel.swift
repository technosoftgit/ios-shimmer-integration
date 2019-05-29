//
//  HourDataModel.swift

//
//  Created by Zain Arshad on 29/10/2018.
//  Copyright © 2018 Technosoft Solutions. All rights reserved.
//

import Foundation

// Hour DataModel
struct HourDataModel {
    var steps:Int
    var date:Date
    var hour:Int       
    
    init(steps: Int, date: Date, hour: Int) {
        self.steps=steps
        self.date=date
        self.hour=hour
    }
    
    func returnHourIndex()->Int{
        return hour-1
    }
}

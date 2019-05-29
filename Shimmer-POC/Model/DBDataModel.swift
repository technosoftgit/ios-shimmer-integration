//
//  SourceDataModel.swift

//
//  Created by Zain Arshad on 07/02/2019.
//  Copyright © 2019 Technosoft Solutions. All rights reserved.
//

import Foundation

struct DBDataModel{
    var date:Date
    var steps:Int
//    var month:String
//    var weekno:Int
    
    init(date: Date, steps: Int) {
        self.date=date
        self.steps=steps
//        self.month=month
//        self.weekno=weekno
    }
}

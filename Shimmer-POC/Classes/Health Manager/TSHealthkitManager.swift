//
//  HealthKitManager.swift

//
//  Created by Zain Arshad on 31/01/2019.
//  Copyright © 2019 Technosoft Solutions. All rights reserved.
//

import UIKit
import HealthKit

class TSHealthKitManager: TSHealthManagerProtocol {
    
    static let shared = TSHealthKitManager()
    
    let healthManager:TSHealthKitInternalManager = TSHealthKitInternalManager()
    
    func authorization(completion: ((_ success: Bool, _ status: PermissionStatus) -> Void)!){
        
        // Seek authorization in HealthKitManager.swift.
        healthManager.authorizeHealthKit { (authorized,  error) -> Void in
            if !authorized && error==nil{
                print("HealthKit not available on device")
                completion(false,PermissionStatus.notAvailableInDevice)
            }
            
            if authorized {
                // Check is any read source available or not
                self.healthManager.healthKitReadSourceCount { (sourceCount) in
                    // No source available to read data
                    if sourceCount==0{
                        print("Not Read Authorized")
                        completion(false,PermissionStatus.noReadPermission)
                    }
                        
                    // Some source available to read data
                    else{
                        print("Read Write Authorized")
                        completion(true,PermissionStatus.permission)
                    }
                }
                
            } else {
                
                if error != nil {
                    print("Any error : \(error as Any)")
                }
                
                print("Permission denied.")
                completion(false, PermissionStatus.noReadWritePermission)
            }
        }
        
    }
    
    func getIntraDayData(date: Date, completion: (([HourDataModel]) -> Void)!) {
        
        var dayHoursData=[HourDataModel]()
        var hourCount=0;
        
        self.healthManager.retrieveHourStepCount(date: date,completion: { (hourData,resultCount) in
            DispatchQueue.main.async {
                if resultCount != 0{
                    // add data when hourCount 0-23
                    if hourCount<24{
                        dayHoursData.append(HourDataModel(steps: hourData.steps, date: date, hour: hourData.hour))
                    }
                }
                // Append zero steps if not step count for given day
                else{
                    // add data when hourCount 0-23
                    if hourCount<24{
                        dayHoursData.append(HourDataModel(steps: 0, date: date, hour: hourData.hour))
                    }
                }
                
                hourCount+=1
                // Call when all data retrieved, hour counter becomes equals to 24
                if hourCount==24{
                    hourCount=0
                    
                    // Return result
                    completion(dayHoursData)
                }
            }
        })
    }
    
    func getDayData(date: Date, completion: ((_ data: Int) -> Void)!){
        healthManager.retrieveGivenDateStepCount(givenDate: date) { (steps) in
            completion(steps)
        }
    }

    func getIntraWeekData(week: WeekDataModel, completion: (([DayDataModel]) -> Void)!) {
        
        var weekDaysData=[DayDataModel]()
        var dayCount = 0;
        
        self.healthManager.retrieveWeekDaysStepCount(weekStartDate: week.startDate, weekEndDate: week.endDate) { (dayData
            , resultCount) in
            DispatchQueue.main.async {
                if resultCount != 0{
                    // add data when dayCount 0-6
                    if dayCount<7{
                        weekDaysData.append(dayData)
                    }
                }
                // Append zero steps if not step count for given day
                else{
                    // add data when dayCount 0-6
                    if dayCount<7{
                        weekDaysData.append(DayDataModel(steps: 0, day: dayData.day, date: dayData.date, name: dayData.name))
                    }
                }
                // increase in dayCount when steps greater than zero
                dayCount+=1
                if dayCount==7{
                    dayCount=0
                    
                    completion(weekDaysData)
                }
            }
        }
    }
    
    func getWeekData(week: WeekDataModel, completion: ((Int) -> Void)!) {
        healthManager.retrieveGivenWeekStepCount(weekStart: week.startDate, weekEnd: week.endDate) { (steps) in
            completion(steps)
        }
    }
    
    func getIntraMonthData(month: MonthDataModel, completion: (([DayDataModel]) -> Void)!) {
        // clear month week data
        var monthDaysData=[DayDataModel]()
        
        var dayCount = 0;
        self.healthManager.retrieveMonthDaysStepCount(monthFirstDate: month.startDate, monthEndDate: month.endDate) { (dayData, resultCount) in
            DispatchQueue.main.async {
                if resultCount != 0{
                    // add data when dayCount 0-29,30,31
                    if dayCount<month.startDate.getDaysInMonth(){
                        monthDaysData.append(dayData)
                    }
                }
                // Append zero steps if not step count for given day
                else{
                    // add data when dayCount 0-29,30,31
                    if dayCount<month.startDate.getDaysInMonth(){
                        monthDaysData.append(DayDataModel(steps: 0, day: dayData.day, date: dayData.date, name: dayData.name))
                    }
                }
                // increase in dayCount when steps greater than zero
                dayCount+=1
                //  print("Days in month : \(Date().getDaysInMonth())")
                if dayCount==month.startDate.getDaysInMonth(){
                    dayCount=0
                    completion(monthDaysData)
                }
            }
        }
    }
    
    func getMonthData(month: MonthDataModel, completion: ((Int) -> Void)!) {
        healthManager.retrieveGivenMonthStepCount(monthStart: month.startDate, monthEnd: month.endDate) { (steps) in
            completion(steps)
        }
    }
    
    
    
}

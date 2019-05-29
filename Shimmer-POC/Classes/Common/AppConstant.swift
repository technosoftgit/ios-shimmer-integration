//
//  AppConstant.swift

//
//  Created by Zain Arshad on 09/01/2019.
//  Copyright © 2019 Technosoft Solutions. All rights reserved.
//

import UIKit


var kOthervalue = "Other"
var kAllvalue = "All"

let kAuthorizationTokenKey = "Authorization"
let kAppVersionKey = "app_version"
let kDeviceTypeKey = "device_type"
let kTimeZoneKey = "Timezone"
let kIsDayLightSaving = "isDayLightSaving"

let kMessageKey = "message"
let kMessagesKey = "messages"
let kErrorKey = "error"
let kCodeKey = "code"
let kDataKey = "data"

//Representative Key
let kPhoneNoKey = "phoneNo"
let kFullNameKey = "FullName"

//Current login User keys
let kUserFullNameKey = "fullname"
let kIdKey = "id"
let kNameKey = "name"
let kUserRoleKey = "role"
let partialText  = "Partial"
let fullText  = "Full"

let kApplicationDate = "ApplicationDate";
let kLastName = "LastName";

let kSet="Set"

let kIsFirstTime="isFirstTime"
let kAuth="isAuthorized"
let kSourceKey="shim-Key"
let kDailyGoals="dailyGoal"
let kFirstTimeSetting="firstTimeSetting"

let kUsername="username"

let UndefinedSteps = -999

let healthSourcesArray:[SourceModel]=[
                           SourceModel(title: "Fitbit", name: HealthSource.fitbit.getName(), icon: HealthSource.fitbit.getIcon()),
                           SourceModel(title: "Misfit", name: HealthSource.misfit.getName(), icon: HealthSource.misfit.getIcon())]
let healthSourceColorArray:[UIColor]=[UIColor(red: 52/255.0, green: 52/255.0, blue: 51/255.0, alpha: 1),
                           UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1)]


#if DEBUG
let BASE_URL = "http://shim-host:8084/"  // Place resource-server.env OPENMHEALTH_SHIMMER_DATA_PROVIDER_REDIRECT_BASE_URL here with port 8084
#else
let BASE_URL = "http://shim-host:8084/"  // Place resource-server.env OPENMHEALTH_SHIMMER_DATA_PROVIDER_REDIRECT_BASE_URL here with port 8084
#endif


let SESSION_EXPIRE_MSG = "Session expired, please re-login"
let NO_CONNECTION_MSG = "No internet connection or server not responding"

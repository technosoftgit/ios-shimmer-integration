//
//  enums.swift

//
//  Created by Zain Arshad on 08/01/2019.
//  Copyright © 2019 Technosoft Solutions. All rights reserved.
//

import Foundation
import UIKit

enum PermissionStatus{
    case notAvailableInDevice
    case noReadPermission
    case noWritePermission
    case noReadWritePermission
    case permission
}

enum ConnectionStatus {
    case noConnection
    case exception
    case unknownServerError
    case successOnline
    case successOffline
}

enum AnimationDirection{
    case fromLeftToRight
    case fromRightToLeft
    case stay
}

enum HealthSource:String{
    case fitbit="fitbit"
    case misfit="misfit"
    
    func getName() -> String {
        switch self {
        case .fitbit:
            return "fitbit"
        case .misfit:
            return "misfit"
        default:
            return ""
        }
    }
    
    func getIcon() -> String {
        return getName()
    }
}

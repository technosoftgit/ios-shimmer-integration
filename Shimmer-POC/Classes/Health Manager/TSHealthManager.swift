//
//  HealthSourceManager.swift

//
//  Created by Zain Arshad on 31/01/2019.
//  Copyright © 2019 Technosoft Solutions. All rights reserved.
//

import UIKit

protocol TSHealthManagerProtocol{
    func authorization(completion: ((_ success: Bool, _ status: PermissionStatus) -> Void)!)
}

class TSHealthManager{
    
    static let shared = TSHealthManager()
    
    // Return Instance related Health Source 
    func getInstance() -> TSHealthManagerProtocol {
        
        let defaults = UserDefaults.standard
        let source=(defaults.value(forKeyPath: kSourceKey) as! String)
        
        switch source {
            
        case HealthSource.misfit.getName():
            return TSMisFitManager.shared
            
        case HealthSource.fitbit.getName():
            return TSFitBitManager.shared
            
        default:
            return TSMisFitManager.shared
        }
    }
}

//
//  FitBitManager.swift

//
//  Created by Zain Arshad on 31/01/2019.
//  Copyright © 2019 Technosoft Solutions. All rights reserved.
//

import UIKit

class TSFitBitManager: TSHealthManagerProtocol{
    
    static let shared = TSFitBitManager()
    
    let defaults = UserDefaults.standard

    var username = ""
    
    func authorization(completion: ((Bool, PermissionStatus) -> Void)!) {
        let webServices = WebServicesUtil()
        
        if (defaults.value(forKey: kUsername) != nil){
            username=defaults.value(forKey: kUsername) as! String
            let urlNameAndSource="\(HealthSource.fitbit)?username=\(self.username)"
            webServices.getAuthorizationData(sourceAndName: urlNameAndSource){
                (response, success, message) in
                if (success){
                    
                    if let isAuthorized = response?["isAuthorized"]{
                        let isAuth:Bool = isAuthorized as! Bool
                        if(isAuth){
                            DispatchQueue.main.async{
                                print("user already Authorized")
                                completion(true, .permission)
                            }
                        }
                        else{
                            self.openHealthSourceController()
                        }
                    }
                    else{
                        self.openHealthSourceController()
                        
                    }
                }
                else{
                    self.openHealthSourceController()
                }
            }
            
        }
        else{
            self.openHealthSourceController()
        }
        
        
        
        //        if (defaults.value(forKey: kUsername) != nil){
        //            username=defaults.value(forKey: kUsername) as! String
        //            if username.count>0{
        //                completion(true, .permission)
        //            }
        //            else{
        //                completion(false,.noReadWritePermission)
        //            }
        //        }
        //        else{
        //            completion(false, .noReadWritePermission)
        //        }
    }
    
    func openHealthSourceController(){
        self.username=""
        self.defaults.set(self.username, forKey: kUsername)
        defaults.set(false, forKey: kAuth)
        self.defaults.synchronize()
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "SourceNavID") as UIViewController
        UIApplication.shared.keyWindow?.rootViewController = viewController;
        UIApplication.shared.keyWindow?.makeKeyAndVisible()
    }
}

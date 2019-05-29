//
//  CommonMethods.swift

//
//  Created by Zain Arshad on 09/01/2019.
//  Copyright © 2019 Technosoft Solutions. All rights reserved.
//

import UIKit

/** Random alphanumeric string of N length*/
func randomString(length: Int) -> String {
    let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    return String((0...length-1).map{ _ in letters.randomElement()! })
}

/** Open source selection controller */
fileprivate func openSourceViewControllerInternal(){
    clearCodentials()
    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    let viewController = mainStoryboard.instantiateViewController(withIdentifier: "SourceNavID") as UIViewController
    UIApplication.shared.keyWindow?.rootViewController = viewController;
    UIApplication.shared.keyWindow?.makeKeyAndVisible()
}

/** Open source selection controller */
func openSourceViewController(){
    if Thread.isMainThread {
        openSourceViewControllerInternal()
    } else {
        DispatchQueue.main.async {
            openSourceViewControllerInternal()
        }
    }
}

/** Clear codentials username, source and auth */
func clearCodentials(){
    let defaults = UserDefaults.standard
    defaults.set(false, forKey: kAuth)
    defaults.set("", forKey: kUsername)
    defaults.set("", forKey: kSourceKey)
    defaults.synchronize()
}

/** Get saved or random generated user name */
func getUserName() -> String {
    let defaults = UserDefaults.standard
    var localUserName=""
    if let name = defaults.value(forKey: kUsername){
        if (name as! String).count==0{
            localUserName=randomString(length: 25)
        }
        else {
            localUserName = defaults.value(forKey: kUsername) as! String
        }
    }
    else{
        localUserName=randomString(length: 25)
    }
    return localUserName
}



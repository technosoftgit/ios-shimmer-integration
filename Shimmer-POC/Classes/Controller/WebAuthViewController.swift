//
//  WebAuthViewController.swift

//
//  Created by Zain Arshad on 25/01/2019.
//  Copyright © 2019 Technosoft Solutions. All rights reserved.
//

import UIKit
import MKProgress

class WebAuthViewController: UIViewController, UIWebViewDelegate{
    
    @IBOutlet weak var webView: UIWebView!
    
    @IBOutlet weak var navBarItem: UINavigationItem!
    
    var username:String = ""
    var sourceName:String = ""
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backImage = UIImage.init(named: "back")!.withRenderingMode(.alwaysOriginal)
        self.navBarItem.leftBarButtonItem = UIBarButtonItem(image: backImage, style: .done, target: self, action: #selector(backActionBtn(_:)))
        
        sourceName = defaults.value(forKey: kSourceKey) as! String
        // Check username related to sourceName, if username exist then use this, else generate random string and save to related sourceName
        username = getUserName()
        
        print("Source name key : \(sourceName)")
        print("User name : \(username)")
        
        // Change navigation controller title text
        navigationController?.navigationBar.topItem?.title=""
        
        webView.delegate = self
        let urlNameAndSource="\(self.sourceName)?username=\(self.username)"
        
        showProgress()
        
        // If internet connected than use online auth
        if Connectivity.isConnectedToInternet() && Connectivity.verifyUrl(urlString: BASE_URL){
            WebServicesUtil.shared.getAuthorizationData(sourceAndName: urlNameAndSource){
                
                (response, success, message) in
                if (success){
                    
                    if let isAuthorized = response?["isAuthorized"]{
                        let isAuth:Bool = isAuthorized as! Bool
                        if(isAuth){
                            
                            DispatchQueue.main.async{
                                print("user already Authorized")
                                
                                // If already authonticate
                                self.defaults.set(false, forKey:kIsFirstTime)
                                self.defaults.set(self.sourceName, forKey:kSourceKey)
                                self.defaults.set(self.username, forKey: kUsername)
                                self.defaults.set(true, forKey: kAuth)
                                self.defaults.synchronize()
                                
                                self.hideProgress()
                                // TODO: Place code on successful authentication
                                self.showAlertAlertView("", "You are already logged in")
                            }
                        }else{
                            clearCodentials()
                            self.openWebView(dic: response!)
                        }
                    }else{
                        clearCodentials()
                        self.openWebView(dic: response!)
                    }
                }else{
                    clearCodentials()
                    self.hideProgress()
                    self.showAlertAlertView("", message!)    // Problem
                }
            }
        }
        // Else check offline auth
        else{
           self.showAlertAlertView("", "Internet not connected")
        }
    }
    
    func openWebView(dic: Dictionary<String, Any>) {
        
        DispatchQueue.main.async {
            if let authorizationUrl = dic["authorizationUrl"]{
                
                if let url = NSURL(string: authorizationUrl as! String) {
                    DispatchQueue.main.async{
                        let request = NSURLRequest(url: url as URL)
                        self.cleareCache()
                        self.webView.loadRequest(request as URLRequest)
                    }
                }
            }else{
                self.hideProgress()
            }
        }
    }
    
    func cleareCache() {
        
        let storage = HTTPCookieStorage.shared
        for cookie in storage.cookies! {
            storage.deleteCookie(cookie)
        }
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        hideProgress()
        print("webViewDidStartLoad")
    }
    func webViewDidFinishLoad(_ webView: UIWebView) {
        hideProgress()
        print("webViewDidFinishLoad")
    }
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        print("didFailLoadWithError")
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebView.NavigationType) -> Bool {
        
        let urlString = request.url?.absoluteString ?? "";
        
        if(urlString.contains("authorize/\(self.sourceName)/callback?code")){
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                // After authonticate
                self.defaults.set(false, forKey:kIsFirstTime)
                self.defaults.set(self.sourceName, forKey:kSourceKey)
                self.defaults.set(self.username, forKey: kUsername)
                self.defaults.synchronize()
                
                self.hideProgress()
                // TODO: Place code on successful authentication
                self.showAlertAlertView("", "Authentication Successfully")
            }
            self.webView.isHidden = true
        }
        else{
            self.defaults.set(false, forKey: kAuth)
            self.defaults.synchronize()
            hideProgress()
        }
        
        return true;
    }
    
    func showProgress(){
        DispatchQueue.main.async {
            MKProgress.show()
        }
    }
    
    func hideProgress(){
        DispatchQueue.main.async {
            MKProgress.hide()
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    func showAlertAlertView(_ aTitle: String, _ aMessage: String)
    {
        let alert = UIAlertController(title: aTitle, message: aMessage, preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "OK", style: .cancel) { (action: UIAlertAction!) in
            // TODO: Place code on successful authentication
        }
        alert.addAction(actionOk)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func backActionBtn(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
}

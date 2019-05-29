//
//  HealthSourceVCViewController.swift

//
//  Created by Zain Arshad on 25/01/2019.
//  Copyright © 2019 Technosoft Solutions. All rights reserved.
//

import UIKit
import MKProgress

class HealthSourceViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    let numberOfSection = 6
    let cellIdentifier="SourceCellIdentifier"
    let totalAnimationFrame = 25
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        // Adding "openHome" Notification Observers to reload UI
        NotificationCenter.default.addObserver(self, selector: #selector(self.openMain(_:)), name: NSNotification.Name(rawValue: "openMain"), object: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    @objc func openMain(_ notification: Notification) {
        //TODO: Open after some delay
        DispatchQueue.main.async {
            self.navigationController?.dismiss(animated: true, completion: {
                // Root Controller setting (More to main UI, get shim-key and process data according)
                // openHomeViewController()
                // TODO:
                self.showAlertAlertView("", "Authentication Successfully")
            })
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
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return healthSourcesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! SourceSelectionCell
        
        cell.background.layer.cornerRadius=20
        
        cell.icon.image = UIImage(named: healthSourcesArray[indexPath.row].icon)
        cell.name.text = healthSourcesArray[indexPath.row].title
        cell.name.textColor = healthSourceColorArray[indexPath.row]
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model=healthSourcesArray[indexPath.row]
        let color=healthSourceColorArray[indexPath.row]
        
        print("Source Key : \(model.name)")
        
        
            // If internet connected and server URL is working
            if Connectivity.isConnectedToInternet() && Connectivity.verifyUrl(urlString: BASE_URL){
                defaults.set(model.name, forKey: kSourceKey)
                defaults.synchronize()
                
                
                if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WebAuthID") as? WebAuthViewController {
                    
                    if let navigator = navigationController {
                        // Load selected source logo in MKProgress
                        MKProgress.config.logoImage = UIImage(named: model.name)
                        MKProgress.config.circleBorderColor=color
                        
                        navigator.present(viewController, animated: true, completion: nil)
                    }
                }
            }
            // If not working show toast
            else{
                noInternetAlart(title: model.title)
            }
            
        
    }
    
    /** Show No Internet alert */
    func noInternetAlart(title: String){
        let alert = UIAlertController(title: "Connection Problem", message: "\"\(title)\" server not responding", preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "OK", style: .cancel) { (action: UIAlertAction!) in
        }
        alert.addAction(actionOk)
        self.present(alert, animated: true, completion: nil)
    }
    
    // Single cell size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // Setting for one items per row
        let spacing=collectionView.frame.width*0.66
        return CGSize(width: (collectionView.frame.width-spacing), height: (collectionView.frame.width-spacing))
    }
    
    // Spacing around single row, first cell left spacing, last cell right spacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        // Setting for one items per row
        let topSpacing = (collectionView.frame.width*0.333)/3
        let leftSpacing = collectionView.frame.width*0.333
        let bottomSpacing = collectionView.frame.width*0.333
        let rightSpacing = collectionView.frame.width*0.333
        return UIEdgeInsets.init(top: topSpacing, left: leftSpacing, bottom: bottomSpacing, right: rightSpacing)
    }
    
    // Spacing between rows
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        let spacing=(collectionView.frame.width*0.333)/3
        return spacing
    }
    
    func showAlertAlertView(_ aTitle: String, _ aMessage: String)
    {
        let alert = UIAlertController(title: aTitle, message: aMessage, preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "OK", style: .cancel) { (action: UIAlertAction!) in
            
        }
        alert.addAction(actionOk)
        self.present(alert, animated: true, completion: nil)
    }
}

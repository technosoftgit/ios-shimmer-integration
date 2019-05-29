Open m Health Shimmer integration
=================================

An **Open m Health Shimmer IOS App** 


## Installation and Configuration

1. Clone openmhealth-shimmer code from `https://github.com/openmhealth/shimmer`.
2. Use openmhealth-shimmer guideline, install Docker
   Follow installation option 2(Recommended), build and run the code in Docker, in a terminal run command
   ./run-dockerized.sh -d  
   visist http://<shimmer-host>:8083
3. Copy http://<shimmer-host>:8083 and paste in resource-server.env OPENMHEALTH_SHIMMER_DATA_PROVIDER_REDIRECT_BASE_URL field.
4. Configure resource-server.env. Register application on FITBIT and  MISFIT developer site
5. resource-server.env REDIRECT_BASE_URL use in application registation.
6. For MISFIT visit 
	https://build.misfit.com/signup
   For FITBIT visit(opennhealth-shimmer clone must be deployed on Amazon EC2 like web services) 
    https://dev.fitbit.com/login
7. Copy registered application Client_ID(required), Client_secret(required) and copy other if present, paste into resource-server.env
8. After registeration confirmation re-run docker using 
   ./run-dockerized.sh -d

9. Open `Shimmer-POC.xcworkspace`, Assign REDIRECT_BASE_URL to BASE_URL in AppConstant.swift
10.Install POD using `pod install` command in project directory
11. Open the project file `Shimmer-POC.xcworkspace` in Xcode 8+.
12. Place resource-server.env OPENMHEALTH_SHIMMER_DATA_PROVIDER_REDIRECT_BASE_URL in AppConstant.swift 
12. Select an iPhone simulator and press **Run**.


## What's Happening?

This app allows you to connect with **MISFIT and FITBIT** via shimmer. After configure FITBIT or MISFIT on develop 
portal select health data source on main screen.

## Add Custom Code 

If you want to add custom task after successful authentication add code in **WebAuthViewController.swift** TODO
Line : 55
```
	DispatchQueue.main.async{
        print("user already Authorized")                    
        ...                
        // TODO: Place code on successful authentication
        self.showAlertAlertView("", "Authentication Successfully")
	}
```
Line : 133
```
	DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
        ...
        // TODO: Place code on successful authentication
        self.showAlertAlertView("", "Authentication Successfully")
    }
```
Line : 176
	func showAlertAlertView(_ aTitle: String, _ aMessage: String)
    {
        ...
        let actionOk = UIAlertAction(title: "OK", style: .cancel) { (action: UIAlertAction!) in
            // TODO: Place code on successful authentication
        }
        ...
    }

### Credits
  The code based on below libraries

  - Open M Health 
    * Open M Health Shimmer
    * [http://www.getshimmer.co/](http://www.getshimmer.co/)

  - openmhealth/shimmer
  	* Shimmer
  	* [https://github.com/openmhealth/shimmer](https://github.com/openmhealth/shimmer)
  	

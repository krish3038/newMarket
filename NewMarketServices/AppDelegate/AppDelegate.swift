//
//  AppDelegate.swift
//  NewMarketServices
//
//  Created by RAMESH on 6/1/18.
//  Copyright © 2018 RAMESH. All rights reserved.
//

import UIKit
import MMDrawerController

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
         UIApplication.shared.statusBarStyle = .lightContent
        
        let sn = "Ie/IFqDcXdhuSWYP8PYnahCgEuCmDEh6d0Z0VkwnMBUzYXs+JP47kw=="
        let key = "ezKXTl8mtG5zD+tKFKSz35QFJWJdSPvqzWdWkN07EbT/jsuzHy5kwtu8ubnDda31/cbW5Ll5PgFs8xElobsn4Hhv319DVUO35nw6BsEPJ3f8MLD4XHSNbQ+aJrO5Tsxyvy/l5vLvyc6u6oRq+wCbTpwcY8qLMh5ulziQKHpuyjBGPVAajYj1feArqIP4+mTBInCRIp5sSCt+TErGoKJXEh8kJ9ndTdwbDCon51sqZ2KftqpAfmR19zrhHoF0malCcXizsX7pgmpPVj08MpJlCRznk57VoxtpUlPhQ1KxKudLJbPSfasZWOpnPfbojraCZwMdVPEPGcHrt5ro3P9X95rhFraIBFtWnha3IZ2ghpX7VQuFRI6IgFmykuwtRAWTbRmfT7zwekdfGsQ5cD/8ODKYzmv5JyRmmCty1VxqP7YkS/OTFnZ49A0AbjsAqRx55ND1ozzHhqN/AhwEYdmcxLpmm2l/djJY0w7SG4YbYIXNdGf9/D3seqXll2iHELPS/8CXSWoNOTJ3Vkrpr3594rQv/aDG1716hk91gah6E3lcCzXIZu0+AATO3JgQQZT/qn54KG6afgPUOQnQVEariYtyOkA79E0fsf5piD08rYyde7KMiVxXINdzULYhPiMsR+ecvni6mJPVQehSqlYqwgvaMHyuaC4Um4jbVeFZ+BCp+kgGdyHit8oBJblsFnP2hLhXoPZJBfwEgQOsbYJW882ViP+NalTQ66OHicFfouBJeOPzztmZ7FQ5AjGvdLqFuRLKCtyAPVLnM0Jx1H7ZQjUqJ48dq1ywB8mFr4vest2yNnss9a1GXP4tKGz9ciYs6PgaqmGJWaxYykU4Z0F8Fh8Nz03418rGs/ID6/iZAFxalmVrt5TdsSHOMUfua6h4FAxhzQoFE8f8hn7PyZ47yQjl7geZlTYxNg6c12DOnDjlzsIWivRCgcWOIBSFSrx/lXvALKmFMBtv5Y4PRxGaIJZ7Be+FkwWE603u1LdpuSU1PhGJRVmD6HyJerTGOF8QJ4zbqHJDJULRu6Mnjzv8tNtljgjdnH/iSgaeeavaHyHDKKcvIz0gjbxa6egqoQF7aPHkJL6mpeUdPySfbDPfWKGC49M5XFm3uJDeJY5TKTNplfTkzZ0KTUd2b3klBeChxmzYV64OE4wrCtv9/jbyegUiqnfCeyGwUhhS4qY7ykJXlcSeIZgh94ZvCPLab6j0"
        
        let eRet = FSLibrary.init(sn, key:key)
        if FS_ERRORCODE.e_errSuccess != eRet {
            print("Invalid License")
            //return false
        }
        
        window =  UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        showLogin()
        
        return true
    }
    
    func showLogin() {
        guard let window = UIApplication.shared.keyWindow else {
            return
        }
        
        // instantiate View Controller With Identifier
        let mainStoryBoard: UIStoryboard = UIStoryboard(name: "iPadScreens", bundle: nil)
        let loginVC  = mainStoryBoard.instantiateViewController(withIdentifier: "ID_LOGIN") as! UINavigationController
        
        UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: {
            window.rootViewController = loginVC
        }, completion: { completed in
            // maybe do something here
        })
    }
    
    func showDashboard() {
        guard let window = UIApplication.shared.keyWindow else {
            return
        }
        
        // instantiate dashboard View Controller With Identifier
        let mainStoryBoard: UIStoryboard = UIStoryboard(name: "iPadScreens", bundle: nil)
        let centerViewController  = mainStoryBoard.instantiateViewController(withIdentifier: "ID_DASHBOARD") as! UINavigationController
        // instantiate menu View Controller With Identifier
        let leftMenuViewController = mainStoryBoard.instantiateViewController(withIdentifier: "ID_LEFT_MENU") as! LeftMenuViewController
        
        let leftSideNav = UINavigationController(rootViewController: leftMenuViewController)
        leftSideNav.isNavigationBarHidden = true
        //let centerSideNav = UINavigationController(rootViewController: centerViewController)
        let centerContainer : MMDrawerController = MMDrawerController(center: centerViewController, leftDrawerViewController: leftSideNav)
        centerContainer.showsShadow                  = false
        centerContainer.restorationIdentifier        = "MMDrawer"
        centerContainer.maximumLeftDrawerWidth       = UIScreen.main.bounds.size.width * 0.25 // 25% of screen width
        centerContainer.openDrawerGestureModeMask    = MMOpenDrawerGestureMode.all
        centerContainer.closeDrawerGestureModeMask   = MMCloseDrawerGestureMode.all
        centerContainer.shouldStretchDrawer          = false
        
        UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: {
            window.rootViewController = centerContainer
        }, completion: { completed in
            // maybe do something here
        })
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}


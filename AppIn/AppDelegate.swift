//
//  AppDelegate.swift
//  AppIn
//
//  Created by sameer khan on 14/06/20.
//  Copyright © 2020 Sameer khan. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    fileprivate let kFlurryKey = "B53YVH8X7K994Y2GFK79"
    static var userId: Int?
    static var token: String?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        sleep(3)
        // Override point for customization after application launch.
        
        UserManager.sharedInstance.currentAuthorizedUser { (user) in
            print("Checking if a user exists")
            
            if user?.id != 0 && user != nil {
                AppDelegate.userId = user?.id
                print("User exists, so navigating to application, user id is: \(String(describing: user?.id))")
                self.navigateToDashboardScreen()
            }else {
                
                if let userData = CustomUserDefault.getUserData() {
                    if userData.id != 0 {
                        
                        OAuth2Handler.sharedInstance.refreshExpiredToken { (bool, acc_token, ref_token) in
                            
                            if bool {
                                OAuth2Handler.sharedInstance.update(accessToken: acc_token ?? "", refreshToken: ref_token ?? "")
                                
                                UserManager.sharedInstance.storeUserData(userData)
                                AppDelegate.userId = userData.id
                                print("User exists, so navigating to application, user id is: \(String(describing: userData.id))")
                                                                
                                DispatchQueue.main.async(execute: {
                                    if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                                        appDelegate.navigateToDashboardScreen()
                                    }
                                })
                                
                            }else {
                                print("User id is 0, so going to login method")
                                OAuth2Handler.sharedInstance.clearAccessToken()
                                self.navigateToLoginScreen()
                            }
                        }
                    }else {
                        print("User id is 0, so going to login method")
                        OAuth2Handler.sharedInstance.clearAccessToken()
                        self.navigateToLoginScreen()
                    }
                }else {
                    print("User id is 0, so going to login method")
                    OAuth2Handler.sharedInstance.clearAccessToken()
                    self.navigateToHomeScreen()
                }
            }
        }
        
        return true
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
    
    //MARK: Custom Methods
    func navigateToHomeScreen() {
        let  story = UIStoryboard.init(name: "Main", bundle: nil)
        self.window?.rootViewController = story.instantiateViewController(withIdentifier: "Home_Nav")
    }
    
    func navigateToLoginScreen() {
        let  story = UIStoryboard.init(name: "Main", bundle: nil)
        self.window?.rootViewController = story.instantiateViewController(withIdentifier: "Login_Nav")
    }
    
    func navigateToDashboardScreen() {
        let  story = UIStoryboard.init(name: "Dashboard", bundle: nil)
        self.window?.rootViewController = story.instantiateViewController(withIdentifier: "Dashboard_Nav")
    }

    // MARK: UISceneSession Lifecycle

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}


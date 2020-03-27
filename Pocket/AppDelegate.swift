//
//  AppDelegate.swift
//  Pocket
//
//  Created by Danielle Gomes on 2020-01-14.
//  Copyright © 2020 Danielle Gomes. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FacebookCore
import GoogleSignIn

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {

    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        // ...
          
        if let error = error {
            if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
              print("The user has not signed in before or they have since signed out.")
            } else {
              print("\(error.localizedDescription)")
            }
            return
        }
        
        let idToken = user.authentication.idToken // Safe to send to the server
        let email = user.profile.email

        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                            accessToken: authentication.accessToken)
        let session = FirebaseSession()
        //let userController = UserController()
        session.signInGoogle(authCredential: credential) { (res, err) in
            if err != nil {
                print((err?.localizedDescription)!)
                return
            }
            
            session.session?.email = email
            session.session?.uid = idToken
            
        }
        
        
    }

    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
        GIDSignIn.sharedInstance().signOut()
        print("Google disconected")
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        
        //Google social login
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        
        //Facebook social Login
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        
        return true
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
    
        let isFBOpenUrl = ApplicationDelegate.shared.application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
        let isGoogleOpenUrl = GIDSignIn.sharedInstance().handle(url)
        
        if isFBOpenUrl { return true }
        if isGoogleOpenUrl { return true }
        
        return false
    }

    @available(iOS 9.0, *)
    func application(_ application: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any]) -> Bool {
        
        let isFBOpenUrl = ApplicationDelegate.shared.application(application, open: url, options: options)
        let isGoogleOpenUrl = GIDSignIn.sharedInstance().handle(url)
        
        if isFBOpenUrl { return true }
        if isGoogleOpenUrl { return true }
        
       return false
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
      AppEvents.activateApp()
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}


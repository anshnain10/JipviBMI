//
//  JipviBMIAssignmentApp.swift
//  JipviBMIAssignment
//
//  Created by ANSH on 22/06/24.
//

import SwiftUI
import Firebase
import GoogleSignIn

@main
struct JipviBMIAssignmentApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject private var personalDetailsStore = PersonalDetailStore()
       var body: some Scene {
           WindowGroup {
               InitialView(personalDetailsStore: personalDetailsStore)
           }
       }
   }

   class AppDelegate: NSObject, UIApplicationDelegate{
       func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool{
           FirebaseApp.configure()
           return true
       }
       
       @available(iOS 9.0, *)
       
       func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
           return GIDSignIn.sharedInstance.handle(url)
       }
       
       
       
   }

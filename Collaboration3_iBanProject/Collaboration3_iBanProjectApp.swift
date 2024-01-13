//
//  Collaboration3_iBanProjectApp.swift
//  Collaboration3_iBanProject
//
//  Created by Ani's Mac on 10.01.24.
//

import SwiftUI
import FirebaseCore

@main
struct Collaboration3_iBanProjectApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            UIKitNavigationController()
                .tint(Color.customAccentColor)
                .background(Color.customBackgroundColor)
                .edgesIgnoringSafeArea(.all)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}



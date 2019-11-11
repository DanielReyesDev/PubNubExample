//
//  AppDelegate.swift
//  PubNubExample
//
//  Created by Daniel Reyes on 11/11/19.
//  Copyright © 2019 Daniel Reyes. All rights reserved.
//

import UIKit
import PubNub

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var client: PubNub!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        connectToPubNub()
        return true
    }

    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
    
        
    
    func connectToPubNub(){
        let configuration = PNConfiguration(publishKey: "pub-c-955af0d5-f7cd-4e4c-83df-03081bee0778",
                                            subscribeKey: "sub-c-f0ed332a-04b0-11ea-a577-b207d7d0b791")
//        configuration.stripMobilePayload = false
        configuration.uuid = UUID().uuidString
        UserDefaults.standard.set(configuration.uuid, forKey: "uuid")
        self.client = PubNub.clientWithConfiguration(configuration)
    }


}


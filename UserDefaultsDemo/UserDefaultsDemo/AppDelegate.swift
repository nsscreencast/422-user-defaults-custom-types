//
//  AppDelegate.swift
//  UserDefaultsDemo
//
//  Created by Ben Scheirman on 12/5/19.
//  Copyright © 2019 NSScreencast. All rights reserved.
//

import UIKit

extension UserDefaults.Key where Value == Int {
    static let launchCount = UserDefaults.Key<Int>(name: "launchCount")
}

extension UserDefaults.Key where Value == User {
    static let currentUser = UserDefaults.Key<User>(name: "currentUser")
}

struct User: UserDefaultsSerializable {
    let id: Int
    let name: String
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let count = (UserDefaults.standard.value(for: .launchCount) ?? 0) + 1
        UserDefaults.standard.set(count, for: .launchCount)
        
        print("Launch count is \(count)")
        
        if let currentUser: User = UserDefaults.standard.value(for: .currentUser) {
            print("Current user is \(currentUser.name)")
        } else {
            let user = User(id: 1, name: "Ben")
            UserDefaults.standard.set(user, for: .currentUser)
            print("Set current user to \(user.name)")
        }

        
        return true
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


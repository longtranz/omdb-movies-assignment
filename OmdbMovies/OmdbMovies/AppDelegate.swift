//
//  AppDelegate.swift
//  OmdbMovies
//
//  Created by LongTM3 on 11/20/21.
//

import UIKit
import AlamofireNetworkActivityLogger

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        loadApiKey()

        NetworkActivityLogger.shared.startLogging()

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

    private func loadApiKey() {
        guard let apiConfigPath = Bundle.main.path(forResource: "API", ofType: "plist"),
              let apiConfig = NSDictionary(contentsOfFile: apiConfigPath),
              let apiKey = apiConfig.value(forKey: "APIKey") as? String else {
            fatalError("Cannot load APIKey from API.plist")
        }

        AppConstants.API.APIKey = apiKey
    }
}


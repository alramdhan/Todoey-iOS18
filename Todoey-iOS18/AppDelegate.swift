//
//  AppDelegate.swift
//  Todoey-iOS18
//
//  Created by Dika Alfarell on 18/08/25.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        // path for UserDefaults directory save plist print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as String)
        return true
    }

    // MARK: UISceneSession Lifecycle
    func applicationWillResignActive(_ application: UIApplication) {
        // method dimana dapat melakukan sesuatu untuk pencegahan kehilangan data. seperti mengisi formulir dan ditengah-tengah mendapatkan panggilan telepon.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // terjadi ketika aplikasi menghilang dari layar. misalnya ketika menekan tombol beranda dan aplikasi memasuki latar belakang.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // ketika aplikasi akan benar-benar diberhentikan dan dihapus dari memory.
    }

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


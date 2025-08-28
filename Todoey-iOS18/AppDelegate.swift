//
//  AppDelegate.swift
//  Todoey-iOS18
//
//  Created by Dika Alfarell on 18/08/25.
//

import UIKit
//import CoreData
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        // path for UserDefaults directory save plist print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as String)
        //print(Realm.Configuration.defaultConfiguration.fileURL)
        
        do {
            _ = try Realm()
        } catch {
            print("Error initialising new Realm, \(error)")
        }
        
        return true
    }

    // MARK: UISceneSession Lifecycle
    func applicationWillResignActive(_ application: UIApplication) {
        // method dimana dapat melakukan sesuatu untuk pencegahan kehilangan data. seperti mengisi formulir dan ditengah-tengah mendapatkan panggilan telepon.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // terjadi ketika aplikasi menghilang dari layar. misalnya ketika menekan tombol beranda dan aplikasi memasuki latar belakang.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // ketika aplikasi akan benar-benar diberhentikan dan dihapus dari memory.
//        self.saveContext()
    }
    
    // MARK: - Core Data stack
//    lazy var persistentContainer: NSPersistentContainer = {
//        let container = NSPersistentContainer(name: "DataModel") // Replace with your .xcdatamodeld file name
//        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
//            if let error = error as NSError? {
//                fatalError("Unresolved error \(error), \(error.userInfo)")
//            }
//        })
//        return container
//    }()
    
    // MARK: - Core Data Saving support
//    func saveContext () {
//        let context = persistentContainer.viewContext
//        if context.hasChanges {
//            do {
//                try context.save()
//            } catch {
//                let nserror = error as NSError
//                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
//            }
//        }
//    }

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

extension UIViewController {
    func initNavigationBar(_ navigationController: UINavigationController?) {
        let navbar = navigationController!.navigationBar
        let standardAppearance = UINavigationBarAppearance()
        standardAppearance.configureWithOpaqueBackground()
        standardAppearance.backgroundColor = .systemPink
        standardAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
    //        standardAppearance.backgroundImage = backImageForDefaultBarMetrics
        let compactAppearance = standardAppearance.copy()
        compactAppearance.backgroundColor = .systemPink
        compactAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navbar.standardAppearance = standardAppearance
        navbar.scrollEdgeAppearance = standardAppearance
        navbar.compactAppearance = compactAppearance
        navbar.barTintColor = .systemBlue
    }
}

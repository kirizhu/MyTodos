//
//  AppDelegate.swift
//  MyTodos
//
//  Created by Eddy Garcia on 2019-09-04.
//  Copyright © 2019 Eddy Garcia. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        print("didFinishLaunchingWithOptions")
        // prints filepath to realm database
        //print(Realm.Configuration.defaultConfiguration.fileURL)
        
        do{//initialising a new Real which throws
            _ = try Realm()

        }catch{
            print("Error initialisin new realm \(error)")
        }
        
        return true
    }

    
    
}

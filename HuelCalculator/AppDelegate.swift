//
//  AppDelegate.swift
//  HuelCalculator
//
//  Created by Linda on 09/12/2016.
//  Copyright © 2016 Linda CC Nordstrom. All rights reserved.
//

import UIKit
import Fabric
import Crashlytics

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        if let apiKey = valueForAPIKey(keyname: "FabricApiKey") {
            Fabric.with([Crashlytics.self.start(withAPIKey: apiKey)])
        }
        return true
    }

    private func valueForAPIKey(keyname: String) -> String? {
        guard let filePath = Bundle.main.path(forResource: "Keys", ofType: "plist"),
            let plist = NSDictionary(contentsOfFile: filePath),
            let value = plist.object(forKey: keyname) as? String else { return nil }
        
        return value
    }

}

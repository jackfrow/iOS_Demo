//
//  AppDelegate.swift
//  24.CalayerTutorial
//
//  Created by yy on 2019/9/17.
//  Copyright © 2019 Jackfrow. All rights reserved.
//

//参考文章:https://www.raywenderlich.com/402-calayer-tutorial-for-ios-getting-started#toc-anchor-008

import UIKit

let swiftOrangeColor = UIColor(red: 248/255, green: 96/255.0, blue: 47/255.0, alpha: 1.0)
let lighterSwiftOrangeColor = UIColor(red: 255/255, green: 160/255.0, blue: 70/255.0, alpha: 1.0)

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

      var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
      
        UIConfigure()
        
        return true
    }
    
    func UIConfigure()  {
            
        UITableView.appearance().separatorColor = swiftOrangeColor
        UITableViewCell.appearance().separatorInset = UIEdgeInsets.zero
        
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().barTintColor = swiftOrangeColor
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont(name: "Avenir-light", size: 20.0)!]
        
        UILabel.appearance().font = UIFont(name: "Avenir-Light", size: 17.0)
        UILabel.appearance(whenContainedInInstancesOf: [UITableViewCell.self]).font = UIFont(name: "Avenir-light", size: 14.0)
        
        UISwitch.appearance().tintColor = swiftOrangeColor
         UISlider.appearance().tintColor = swiftOrangeColor
         UISegmentedControl.appearance().tintColor = swiftOrangeColor
        
        //write to cash
        let size = CGSize(width: sideLength, height: sideLength)
        UIImage.saveTileOfSize(size, name: fileName)

    }

    // MARK: UISceneSession Lifecycle

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}


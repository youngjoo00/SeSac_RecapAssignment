//
//  SceneDelegate.swift
//  SeSac_RecapAssignment
//
//  Created by youngjoo on 1/18/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
      
        UserDefaults.standard.set(false, forKey: "userState")
//        
//        UserDefaults.standard.setValue(0, forKey: "likeCount")
        
        let value = UserDefaults.standard.bool(forKey: "userState")

        if !value {
            guard let scene = (scene as? UIWindowScene) else { return }
            
            window = UIWindow(windowScene: scene)
            
            let OnBoarding = UINavigationController(rootViewController: OnBoardingViewController())
            
            window?.rootViewController = OnBoarding
            window?.makeKeyAndVisible()
        } else {
            guard let scene = (scene as? UIWindowScene) else { return }
            
            window = UIWindow(windowScene: scene)
            
            let sb = UIStoryboard(name: "Main", bundle: nil)
            
            // tabbarController 불러오기
            let vc = sb.instantiateViewController(identifier: "MainTabBarController") as! UITabBarController
                    
            window?.rootViewController = vc
            
            window?.makeKeyAndVisible()
        }

    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    // 앱이 백그라운드로 진입했을때 12시에 노티알람 보내기
    func sceneDidEnterBackground(_ scene: UIScene) {

        let content = UNMutableNotificationContent()
        content.title = "SeSac Shopping"
        content.body = "쇼핑리스트를 관리 해보세요!!"
        content.badge = 0
        
        var component = DateComponents()
        component.hour = 12
        
        let calendarTrigger = UNCalendarNotificationTrigger(dateMatching: component, repeats: true)
       
        let request = UNNotificationRequest(identifier: "\(Date())", content: content, trigger: calendarTrigger)
        
        UNUserNotificationCenter.current().add(request)
    }


}


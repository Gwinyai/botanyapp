//
//  SceneDelegate.swift
//  BotanyApp
//
//  Created by Gwinyai Nyatsoka on 4/9/2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    let tabBarDelegate = TabBarDelegate()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        
        //First create the tab bar controller
        let tabController = UITabBarController()
        
        //next create the root view controllers for each tab. We have 3 tabs so we have 3 vcs
        
        //we embded the main vc in a naviagtion controller
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let mainVC = mainStoryboard.instantiateViewController(withIdentifier: "ViewController")
        let mainNav = UINavigationController(rootViewController: mainVC)
        
        let postStoryboard = UIStoryboard(name: "Post", bundle: nil)
        let postVC = postStoryboard.instantiateViewController(withIdentifier: "AddPlantViewController")
        
        
        let favoritesStoryboard = UIStoryboard(name: "Favorites", bundle: nil)
        let favoritesVC = favoritesStoryboard.instantiateViewController(withIdentifier: "FavoritesViewController")
        let favoritesNav = UINavigationController(rootViewController: favoritesVC)
        
        //we create the icon and title for each tab
        mainNav.tabBarItem.image = UIImage(systemName: "house.fill")
        mainNav.title = "Home"
        
        postVC.tabBarItem.image = UIImage(systemName: "paperplane.fill")
        postVC.title = "Post"
        
        favoritesNav.tabBarItem.image = UIImage(systemName: "heart.fill")
        favoritesNav.title = "Favorites"
        
        //we will add all the vcs to the tab bar controller
        tabController.viewControllers = [mainNav, postVC, favoritesNav]
        tabController.delegate = tabBarDelegate
        
        //we will make the tab bar controller the root of the app
        //first we need to get the window
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        self.window?.rootViewController = tabController
        self.window?.makeKeyAndVisible()
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

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}


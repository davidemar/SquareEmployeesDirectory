//
//  SceneDelegate.swift
//  SquareEmployeeDirectory
//
//  Created by David Mar on 11/22/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowsScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowsScene)
        let employeesViewController = EmployessViewController()
        window?.rootViewController = employeesViewController
        window?.makeKeyAndVisible()
    }
}

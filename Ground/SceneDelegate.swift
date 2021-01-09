//
//  SceneDelegate.swift
//  Ground
//
//  Created by 17790204 on 19.11.2020.
//  Copyright © 2020 Splash Fire. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?

	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		guard let windowScene = (scene as? UIWindowScene) else { return }

		let window = UIWindow(windowScene: windowScene)
		window.rootViewController = GroundAssembly().makeTabBatController()
		window.makeKeyAndVisible()
		self.window = window
	}
}

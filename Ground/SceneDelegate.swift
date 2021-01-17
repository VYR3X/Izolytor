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

		// Появление контроллера с анимацией затухания
//		let launchScreen = UIStoryboard(name: "LaunchScreen", bundle: nil)
//		window.rootViewController = launchScreen.instantiateInitialViewController()
//		window.makeKeyAndVisible()
//
//		UIView.animate(
//			withDuration: 1.0, animations: {window.alpha = 1},
//			completion: { (value: Bool) in UIView.animate(
//				withDuration: 1.0,
//				animations: {sleep(UInt32(0.5))},
//				completion: { (value: Bool) in UIView.animate(
//					withDuration: 2.0,
//					animations: {window.alpha = 0},
//					completion: {_ in
//						window.alpha = 1
//						self.window?.rootViewController = GroundAssembly().makeTabBatController()
//					})})})

		/// Сначало инициализируем Launch Screen
		window.rootViewController = UIStoryboard(name: "LaunchScreen", bundle: nil).instantiateInitialViewController()
		window.makeKeyAndVisible()

		/// Делаем 1.5  секунды задержки и потом уже инициализируем главный экран
		DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5) {
			self.window?.rootViewController = GroundAssembly().makeTabBatController()
		 }

		// 2 старый способ для инициализации

//		let rootViewControlle = GroundAssembly().makeTabBatController()
//		window.rootViewController = GroundAssembly().makeTabBatController()
//		window.makeKeyAndVisible()
		self.window = window
	}
}

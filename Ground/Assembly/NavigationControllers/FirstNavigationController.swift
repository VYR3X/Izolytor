//
//  FirstNavigationController.swift
//  Ground
//
//  Created by 17790204 on 27.11.2020.
//  Copyright © 2020 Splash Fire. All rights reserved.
//

import UIKit

/// Протокол навигационого бара
protocol NavigationControllerProtocol {

	/// Окраска навигационного бара
	var customNavigationBarTintColot: UIColor { get set }

	/// Цвет текста в навигационном баре
	var customNavigationBarTitleColor: UIColor { get set }

	/// Шрифт - изменяем выделение текста ( 20, 30, ... )
	var customNavigationBarTitleFont: UIFont { get set }

	/// Навигационный бар установить с большим заголовком
	var navBarTitle: Bool { get set }
}

/// Навигейшн контроллер, для первого tabbarItem 
final class FirstNavigationController: UINavigationController {

	var customNavigationBarTintColot: UIColor = .blue {
		didSet {
			self.navigationBar.barTintColor = customNavigationBarTintColot
		}
	}

	var customNavigationBarTitleColor: UIColor = .white {
		didSet {
			self.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: customNavigationBarTitleColor]
		}
	}

	var customNavigationBarTitleFont: UIFont = UIFont.boldSystemFont(ofSize: 20)

	var navBarTitle: Bool = true

//	var navBarfont: UIFont = UIFont.OpenSans(.bold, size: 20)

	override init(rootViewController: UIViewController) {
		super.init(rootViewController: rootViewController)
		self.navigationBar.titleTextAttributes = [
			NSAttributedString.Key.foregroundColor: customNavigationBarTitleColor,
			NSAttributedString.Key.font: customNavigationBarTitleFont
		]
		self.navigationBar.largeTitleTextAttributes = [
			NSAttributedString.Key.foregroundColor: UIColor.white,
//			NSAttributedString.Key.font: navBarfont
		]
		self.navigationBar.prefersLargeTitles = navBarTitle
		self.navigationBar.barTintColor = customNavigationBarTintColot
		self.navigationBar.isTranslucent = true
	}

	override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

	required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

	private var gradientLayer: CAGradientLayer = {
		let gradientLayer = CAGradientLayer()
		let colorLeft = UIColor.systemBlue.cgColor
		let colorRight = UIColor.blue.cgColor

		gradientLayer.colors = [colorLeft, colorRight]
		gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
		gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
		return gradientLayer
	}()

}

// MARK: - NavigationControllerProtocol

extension FirstNavigationController: NavigationControllerProtocol {}


extension FirstNavigationController {

	private func setupNavigationBar() {
		// https://stackoverflow.com/questions/46196848/custom-background-image-with-large-titles-navigationbar-in-ios-11
		self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
		self.navigationController?.navigationBar.prefersLargeTitles = true
		self.navigationController?.navigationBar.barTintColor = .blue
	//		updateImageWithGradient()
		self.navigationController?.navigationBar.isTranslucent = true
		self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
//		title = "Изолятор"
	}

	// Устанавливаем картинук с градиентом
	private func updateImageWithGradient() {
		let navBarHeight  = self.navigationController?.navigationBar.frame.size.height
		let heightAdjustment: CGFloat = 2
		let gradientHeight = navBarHeight! + heightAdjustment
		let width = UIScreen.main.bounds.size.width

		let gradientImage = imageWithGradient(size: CGSize(width: width, height: gradientHeight))
		navigationController?.navigationBar.barTintColor = UIColor(patternImage: gradientImage)
	}

	// Градиет для navbar
	private func imageWithGradient(size: CGSize) -> UIImage {
		self.gradientLayer.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
		UIGraphicsBeginImageContext(gradientLayer.bounds.size)
		gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
		let image = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		return image!
	}

}

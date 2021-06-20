//
//  NavigationBar.swift
//  Izolyator
//
//  Created by 17790204 on 03.02.2021.
//  Copyright © 2021 Splash Fire. All rights reserved.
//

import UIKit

class NavigationBarCustom: UINavigationBar {

	private var gradientLayer: CAGradientLayer = {
		let gradientLayer = CAGradientLayer()
		let colorLeft = UIColor.red.cgColor
		let colorRight = UIColor.orange.cgColor

		gradientLayer.colors = [colorLeft, colorRight]
		gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
		gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
		return gradientLayer
	}()

	override init(frame: CGRect) {
		super.init(frame: .zero)
		self.translatesAutoresizingMaskIntoConstraints = false
		self.backgroundColor = .orange
		setNavBar()
	}

	required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

	private func setNavBar() {
		self.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
		self.prefersLargeTitles = true
		updateImageWithGradient()
		self.isTranslucent = true
		self.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
	//		self.navigationController?.navigationItem.largeTitleDisplayMode = .never
	}

	// Устанавливаем картинук с градиентом
	private func updateImageWithGradient() {
		let navBarHeight  = self.frame.size.height
		let heightAdjustment: CGFloat = 2
		let gradientHeight = navBarHeight + heightAdjustment
		let width = UIScreen.main.bounds.size.width

		let gradientImage = imageWithGradient(size: CGSize(width: width, height: gradientHeight))
		self.barTintColor = UIColor(patternImage: gradientImage)
	}

	// Градиент для navbar
	private func imageWithGradient(size: CGSize) -> UIImage {
		self.gradientLayer.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
		UIGraphicsBeginImageContext(gradientLayer.bounds.size)
		gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
		let image = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		return image!
	}
}

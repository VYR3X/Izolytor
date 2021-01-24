//
//  MainBackGroundView.swift
//  Izolyator
//
//  Created by 17790204 on 24.01.2021.
//  Copyright © 2021 Splash Fire. All rights reserved.
//

import UIKit


final class MainBackGroundView: UIView {

//	private let mainImageView: UIImageView = {
//		let view = UIImageView(image: UIImage(named: "MainBackground"))
//		view.translatesAutoresizingMaskIntoConstraints = false
//		return view
//	}()

//	private let mainGradientView:

	required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

	override init(frame: CGRect) {
		super.init(frame: .zero)
		self.translatesAutoresizingMaskIntoConstraints = false
//		self.backgroundColor = UIColor(hex: 0x2E3944)
		setGradientBackground()
	}

//	private func setupConstraints() {
//		self.addSubview(mainImageView)
//		mainImageView.pinToSuperView()
//	}

	func setGradientBackground() {
		let colorTop =  UIColor(red: 255.0/255.0, green: 149.0/255.0, blue: 0.0/255.0, alpha: 1.0).cgColor
		let colorBottom = UIColor(red: 255.0/255.0, green: 94.0/255.0, blue: 58.0/255.0, alpha: 1.0).cgColor

		let gradientLayer = CAGradientLayer()
		gradientLayer.colors = [colorTop, colorBottom]
		gradientLayer.locations = [0.0, 1.0]
		gradientLayer.frame = self.bounds

		self.layer.insertSublayer(gradientLayer, at:0)
	}

}

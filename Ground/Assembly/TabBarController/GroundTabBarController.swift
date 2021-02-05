//
//  GroundTabBarController.swift
//  Ground
//
//  Created by 17790204 on 27.11.2020.
//  Copyright © 2020 Splash Fire. All rights reserved.
//

import UIKit

protocol StartViewControllerProtocol: class {

    var presenter: StartPresenterProtocol? { get set }

    func display(_ viewControllers: [UIViewController])
}

class GroundTabBarController: UITabBarController {

    var presenter: StartPresenterProtocol?

	init() {
		super.init(nibName: nil, bundle: nil)
		self.tabBar.barTintColor = .white
		addSeparator()
	}

	private func addSeparator() {
		self.tabBar.layer.borderWidth = 0.50
		self.tabBar.layer.borderColor = UIColor.systemGray.cgColor
		self.tabBar.clipsToBounds = true
	}
	
	required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

}

extension GroundTabBarController: StartViewControllerProtocol {

    func display(_ viewControllers: [UIViewController]) {
        self.viewControllers = viewControllers
    }
}

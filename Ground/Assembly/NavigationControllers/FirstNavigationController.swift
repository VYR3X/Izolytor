//
//  FirstNavigationController.swift
//  Ground
//
//  Created by 17790204 on 27.11.2020.
//  Copyright © 2020 Splash Fire. All rights reserved.
//

import UIKit

/// Навигейшн контроллер, для первого tabbarItem 
final class FirstNavigationController: UINavigationController {

	override init(rootViewController: UIViewController) {
		super.init(rootViewController: rootViewController)
//		navigationBar.isHidden = true
	}

	override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

	required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

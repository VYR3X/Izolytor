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
}

extension GroundTabBarController: StartViewControllerProtocol {

    func display(_ viewControllers: [UIViewController]) {
        self.viewControllers = viewControllers
    }
}

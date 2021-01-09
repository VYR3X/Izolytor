//
//  GroundTabBarPresenter.swift
//  Ground
//
//  Created by 17790204 on 27.11.2020.
//  Copyright © 2020 Splash Fire. All rights reserved.
//

import UIKit

protocol StartPresenterProtocol: class {

    var router: StartCoordinatorProtocol? { get set }
    var interactor: GroundTabBarInteractor? { get set }
    var tabBarController: GroundTabBarController? { get set }

    func setupViewControllers()
}

class GroundTabBarPresenter {

    var router: StartCoordinatorProtocol?
    var interactor: GroundTabBarInteractor?
    weak var tabBarController: GroundTabBarController?
}

extension GroundTabBarPresenter: StartPresenterProtocol {

    func setupViewControllers() {
        //guard let controllers = self.router?.getViewControllers() else { return }
		var controllers: [UIViewController] = []
		let home = self.router?.routeToHomeViewController()
		let search = self.router?.routeToSearchViewController()
		let library = self.router?.routeToLibraryViewController()
		controllers.append(home!)
		controllers.append(search!)
		controllers.append(library!)
		guard let items = self.router?.getTabBabItems() else { return }
		controllers[0].tabBarItem = items[0]
		controllers[1].tabBarItem = items[1]
		controllers[2].tabBarItem = items[2]
        self.tabBarController!.display(controllers)
    }
}


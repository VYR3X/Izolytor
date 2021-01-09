//
//  GroundAssembly.swift
//  Ground
//
//  Created by 17790204 on 19.11.2020.
//  Copyright © 2020 Splash Fire. All rights reserved.
//

import UIKit

protocol StartCoordinatorProtocol {

    var presenter: GroundTabBarPresenter? { get set }

	var tabBarViewController: UIViewController? { get set }

	func getTabBabItems() -> [UITabBarItem]

	func routeToHomeViewController() -> UIViewController

	func routeToSearchViewController() -> UIViewController

	func routeToLibraryViewController() -> UIViewController

	/// Переход на второй экрна для модуля FM
	func routeToSecondViewControllerInFM()

	/// Переход на второй экрна для модуля SM
	func routeToSecondViewControllerInSM()

	/// Переход на второй экрна для модуля TM
	func routeToSecondViewControllerInTM()
}

class GroundCoordinator {

	private let assembly: GroundAssembly
    weak var presenter: GroundTabBarPresenter?
    weak var tabBarViewController: UIViewController?
	/// Здесь для примера создаю три навигационных контроллера чтобы сдалать три вкладки на панели таббара
	private var firstNavigationController: FirstNavigationController?
	private var secondNavigationController: SecondNavigationController?
	private var thirdNavigationController: ThirdNavigationController?

	init (assembly: GroundAssembly) {
		self.assembly = assembly
	}
}

extension GroundCoordinator: StartCoordinatorProtocol {

	func routeToHomeViewController() -> UIViewController {
		let home = assembly.makeHomeViewController()
		firstNavigationController = FirstNavigationController(rootViewController: home)
		return firstNavigationController!
	}

	func routeToSearchViewController() -> UIViewController {
		let search = assembly.makeSearchViewController()
		secondNavigationController = SecondNavigationController(rootViewController: search)
		return secondNavigationController!
	}

	func routeToLibraryViewController() -> UIViewController {
		let library = assembly.makeLibraryViewController()
		thirdNavigationController = ThirdNavigationController(rootViewController: library)
		return thirdNavigationController!
	}

	// три метода для перехода на вторый экраны в модулях FM, SM, TM, ...
	// для каждого модуля есть свой управлюящий навигационный контроллер first, second, third, ...

	func routeToSecondViewControllerInFM() {
		let viewController = assembly.makeSecondViewControllerFM()
		firstNavigationController?.pushViewController(viewController, animated: true)
	}

	func routeToSecondViewControllerInSM() {
		let viewController = assembly.makeSecondViewControllerSM()
		secondNavigationController?.pushViewController(viewController, animated: true)
	}

	func routeToSecondViewControllerInTM() {
		let viewController = assembly.makeSecondViewControllerTM()
		thirdNavigationController?.pushViewController(viewController, animated: true)
	}

	func getTabBabItems() -> [UITabBarItem] {
		let homeTabBar = UITabBarItem()
		homeTabBar.title = "Home"
		let searchTabBar = UITabBarItem()
		searchTabBar.title = "Search"
		let libraryTabBar = UITabBarItem()
		libraryTabBar.title = "Library"
		var items: [UITabBarItem] = []
		items.append(homeTabBar)
		items.append(searchTabBar)
		items.append(libraryTabBar)
		return items
	}
}


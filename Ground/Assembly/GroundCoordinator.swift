//
//  GroundAssembly.swift
//  Ground
//
//  Created by Vladislav Zhokhov on 19.11.2020.
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

	/// Переход на второй экрна для модуля SM
	func routeToSecondViewControllerInSM()

	/// Переход на второй экрна для модуля TM
	func routeToSecondViewControllerInTM()

	/// Переход на экран с AR сценой
	func routeToARSceneViewController()

	// Переход на экран с каталогом вводов
	func routeToProductListContoller(presentNextView: Bool)

	/// Переход на экран с pdf вью
	func routeToPDFViewController(resourceName: String)

	/// Переход на кран с отображение видео материалов 
	func routeToYouTubeViewController()

	///  Обработчик нажатия назад в FM
	func popViewControllerFM()

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

// MARK: - StartCoordinatorProtocol

extension GroundCoordinator: StartCoordinatorProtocol {

	func routeToHomeViewController() -> UIViewController {
		let home = assembly.makeIzolyatorMainViewController()
		firstNavigationController = FirstNavigationController(rootViewController: home)
		return firstNavigationController!
	}

	func routeToSearchViewController() -> UIViewController {
		let search = assembly.makeSearchViewController(presentNextView: true)
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

	func routeToARSceneViewController() {
		let viewController = ARViewController() //assembly.makeSearchViewController()
		firstNavigationController?.pushViewController(viewController, animated: true)
	}

	func routeToProductListContoller(presentNextView: Bool) {
		let viewController = assembly.makeSearchViewController(presentNextView: presentNextView)
//		let viewController = assembly.makeSearchViewController()
		firstNavigationController?.present(viewController, animated: true, completion: nil)
	}


	func routeToPDFViewController(resourceName: String) {
		let viewController = assembly.makeProductDetailViewController(name: resourceName)
		firstNavigationController?.pushViewController(viewController, animated: true)
	}

	func routeToYouTubeViewController() {
		let viewController = assembly.makeYouTubeViewController()
		firstNavigationController?.pushViewController(viewController, animated: true)
	}

	func popViewControllerFM() {
//		firstNavigationController?.popToRootViewController(animated: true)
		firstNavigationController?.popViewController(animated: true)
	}

	func routeToSecondViewControllerInSM() {
		let viewController = assembly.makeProductDetailViewController(name: "product")
		secondNavigationController?.pushViewController(viewController, animated: true)
	}

	func routeToSecondViewControllerInTM() {
		let viewController = assembly.makeSecondViewControllerTM()
		thirdNavigationController?.pushViewController(viewController, animated: true)
	}

	func getTabBabItems() -> [UITabBarItem] {

		let catalogTabBarItem = UITabBarItem(title: "Каталог",
										 image: UIImage(named: "homeIcon"),
										 selectedImage: UIImage(named: "homeIcon"))
//		let catalogTabBarItem = UITabBarItem()
//		catalogTabBarItem.title = "Каталог"
//		catalogTabBarItem.image = UIImage(named: "chevron_down")
		let searchTabBarItem = UITabBarItem()
		searchTabBarItem.title = "Поиск"
		searchTabBarItem.image = UIImage(named: "searchIcon")
		let profileTabBarItem = UITabBarItem()
		profileTabBarItem.title = "Профиль"
		profileTabBarItem.image = UIImage(named: "profileIcon")
		var items: [UITabBarItem] = []
		items.append(catalogTabBarItem)
		items.append(searchTabBarItem)
		items.append(profileTabBarItem)
		return items
	}
}


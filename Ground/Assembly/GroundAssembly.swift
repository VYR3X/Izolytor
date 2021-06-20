//
//  MusicAssembly.swift
//  SplashMusicPlayer
//
//  Created by 17790204 on 12/08/2020.
//  Copyright © 2020 Splash Fire. All rights reserved.
//

import UIKit

/// Сборщик основого флоу приложения
final class GroundAssembly {

	private let services = ServiceAssembly()
	private var startRouter: StartCoordinatorProtocol?

	init() {}

	func makeTabBatController() -> UIViewController {

		let tabBarController = GroundTabBarController()
		let interactor = GroundTabBarInteractor()
		let presenter = GroundTabBarPresenter()
		startRouter = GroundCoordinator(assembly: self)

		tabBarController.presenter = presenter

		presenter.interactor = interactor
		presenter.tabBarController = tabBarController
		presenter.router = startRouter

		interactor.presenter = presenter

		startRouter?.presenter = presenter
		startRouter?.tabBarViewController = tabBarController

		presenter.setupViewControllers()

		return tabBarController
	}

	/// Метод для сборки экрана "IzolyatorMain" для таббара
	func makeIzolyatorMainViewController() -> UIViewController {
		let service = services.makeFirstService()
		let interactor = IzolyatorMainInteractor(service: service)
		let presenter = IzolyatorMainPresenter(interactor: interactor, coordinator: startRouter!)
		let view = IzolyatorMainViewController(listener: presenter)
		presenter.viewController = view
		return view
	}

	/// Метод для сборки экрана "Search" для таббара
	func makeSearchViewController(presentNextView: Bool) -> UIViewController {
		let service = services.makeFirstService()
		let interactor = SearchInteractor(service: service)
		let presenter = SearchPresenter(interactor: interactor, coordinator: startRouter!)
		let view = SearchViewController(listener: presenter)
		view.presentNextView = presentNextView
		presenter.viewController = view
		return view
	}

	/// Метод для сборки экрана "Profile" для таббара
	func makeProfileViewController() -> UIViewController {
		let service = services.makeFirstService()
		let interactor = ProfileInteractor(service: service)
		let presenter = ProfilePresenter(interactor: interactor, coordinator: startRouter!)
		let view = ProfileViewController(listener: presenter)
		presenter.viewController = view
		return view
	}

	/// Метод для сборки экрана c подробном описанием модели ввода ( чертеж в PDF )
	func makeProductDetailViewController(name: String) -> UIViewController {
		let service = services.makeSecondService()
		let interactor = ProductDetailInteractor(service: service)
		let presenter = ProductDetailPresenter(interactor: interactor, coordinator: startRouter!)
		let view = ProductDetailViewController(listener: presenter)
		view.pdfResourceName = name
		presenter.viewController = view
		return view
	}

	/// Метод для сборки экрана  "Монтаж ввода" с видео материалами, и сопроводительной документаций
	func makeInstallationProductViewController() -> UIViewController {
		let service = services.makeFirstService()
		let interactor = InstallationProductInteractor(service: service)
		let presenter = InstallationProductPresenter(interactor: interactor, coordinator: startRouter!)
		let view = InstallationProductViewController(listener: presenter)
		presenter.viewController = view
		return view
	}


	/// второй экран для перехода в модуле SM
	func makeSecondViewControllerSM() -> UIViewController {
		let service = services.makeSecondService()
		let interactor = SecondScreenSMInteractor(service: service)
		let presenter = SecondScreenSMPresenter(interactor: interactor, coordinator: startRouter!)
		let view = SecondScreenSMViewController(listener: presenter)
		presenter.viewController = view
		return view
	}
}

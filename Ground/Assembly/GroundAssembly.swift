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

	/// Метод для сборки экрана "Home" для таббара
	func makeHomeViewController() -> UIViewController {
//		var view = SplashViewController()
		let service = services.makeFirstService()
		let interactor = FirstScreenFMInteractor(service: service)
		let presenter = FirstScreenFMPresenter(interactor: interactor, coordinator: startRouter!)
		let view = FirstScreenFMViewController(listener: presenter)
		presenter.viewController = view
		return view
	}

	/// Метод для сборки экрана "Search" для таббара
	func makeSearchViewController() -> UIViewController {
		let service = services.makeFirstService()
		let interactor = FirstScreenSMInteractor(service: service)
		let presenter = FirstScreenSMPresenter(interactor: interactor, coordinator: startRouter!)
		let view = FirstScreenSMViewController(listener: presenter)
		presenter.viewController = view
		return view
	}

	/// Метод для сборки экрана "Library" для таббара
	func makeLibraryViewController() -> UIViewController {
		let service = services.makeFirstService()
		let interactor = FirstScreenTMInteractor(service: service)
		let presenter = FirstScreenTMPresenter(interactor: interactor, coordinator: startRouter!)
		let view = FirstScreenTMViewController(listener: presenter)
		presenter.viewController = view
		return view
	}

	/// второй экран для перехода в модуле FM
	func makeSecondViewControllerFM() -> UIViewController {
		let service = services.makeSecondService()
		let interactor = SecondScreenFMInteractor(service: service)
		let presenter = SecondScreenFMPresenter(interactor: interactor, coordinator: startRouter!)
		let view = SecondScreenFMViewController(listener: presenter)
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

	/// второй экран для перехода в модуле TM
	func makeSecondViewControllerTM()-> UIViewController {
		let service = services.makeSecondService()
		let interactor = SecondScreenTMInteractor(service: service)
		let presenter = SecondScreenTMPresenter(interactor: interactor, coordinator: startRouter!)
		let view = SecondScreenTMViewController(listener: presenter)
		presenter.viewController = view
		return view
	}
}

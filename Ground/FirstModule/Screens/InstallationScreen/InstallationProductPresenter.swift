//
//  YouTubePresenter.swift
//  Izolyator
//
//  Created by Vladislav Zhokhov on 21.01.2021.
//  Copyright © 2021 Splash Fire. All rights reserved.
//

import UIKit

/// Интерфейс взаимодействия с презентером экрана IzolyatorMainViewController
protocol InstallationProductPresentable {}

/// Презентер главного экрана приложения
final class InstallationProductPresenter: InstallationProductPresentable {

	weak var viewController: UIViewController?

	private let interactor: InstallationProductInteractable
	private let coordinator: StartCoordinatorProtocol

	init(interactor: InstallationProductInteractable,
		 coordinator: StartCoordinatorProtocol) {
		self.interactor = interactor
		self.coordinator = coordinator
	}
}

// MARK: - InstallationProductViewControllerListener

extension InstallationProductPresenter: InstallationProductViewControllerListener {

	func loadView() {
		
	}

	func didLoad(_ viewController: ProductDetailViewControllable) {}

	func didTapBackButton() {
		coordinator.popViewControllerFM()
	}

	func didTapOnTechInfoButton() {
		coordinator.routeToProductListContoller(presentNextView: false)
//		coordinator.routeToPDFViewController(resourceName: "product")
	}

	func didTapOnManualCell() {
		coordinator.routeToPDFViewController(resourceName: "manual")
	}

	func didTapOnArButton() {
		coordinator.routeToARSceneViewController()
	}
}

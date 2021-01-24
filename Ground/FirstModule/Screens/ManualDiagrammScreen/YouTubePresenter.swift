//
//  YouTubePresenter.swift
//  Izolyator
//
//  Created by Vladislav Zhokhov on 21.01.2021.
//  Copyright © 2021 Splash Fire. All rights reserved.
//

/// Интерфейс взаимодействия с презентером экрана IzolyatorMainViewController
protocol YouTubePresentable {}


/// Презентер главного экрана приложения
final class YouTubePresenter: YouTubePresentable {

	weak var viewController: YouTubeViewControllable?

	private let interactor: YouTubeInteractable
	private let coordinator: StartCoordinatorProtocol

	init(interactor: YouTubeInteractable,
		 coordinator: StartCoordinatorProtocol) {
		self.interactor = interactor
		self.coordinator = coordinator
	}
}

// MARK: - YouTubeViewControllerListener

extension YouTubePresenter: YouTubeViewControllerListener {

	func didTapBackButton() {
		coordinator.popViewControllerFM()
	}

	func didTapOnManualCell() {
		coordinator.routeToPDFViewController(resourceName: "manual")
	}

	func loadView() {}

	func didLoad(_ viewController: ProductDetailViewControllable) {}

	func didTapOnTechInfoButton() {
		coordinator.routeToPDFViewController(resourceName: "product")
	}

	func didTapOnArButton() {
		coordinator.routeToARSceneViewController()
	}
}

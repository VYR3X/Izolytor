//
//  SecondScreenFMPresenter.swift
//  Ground
//
//  Created by Vladislav Zhokhov on 27.11.2020.
//  Copyright © 2020 Splash Fire. All rights reserved.
//

/// Интерфейс взаимодействия с презентером экрана ProductDetailPresenter
protocol ProductDetailPresentable {}

/// Презентер экрана детальной информации
final class ProductDetailPresenter: ProductDetailPresentable {

    weak var viewController: ProductDetailViewControllable?

    private let interactor: ProductDetailInteractable
    private let coordinator: StartCoordinatorProtocol

    init(interactor: ProductDetailInteractable,
        coordinator: StartCoordinatorProtocol) {
        self.interactor = interactor
        self.coordinator = coordinator
    }
}

// MARK: - ProductDetailViewControllerListener

extension ProductDetailPresenter: ProductDetailViewControllerListener {

	func didTapOnLeftButton() {
		coordinator.popViewControllerFM()
	}

	func didTapOnArButton() {
		coordinator.routeToARSceneViewController()
	}

	func didLoad(_ viewController: ProductDetailViewControllable) {}
}

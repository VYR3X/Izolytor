//
//  FirstScreenSMPresenter.swift
//  Ground
//
//  Created by 17790204 on 27.11.2020.
//  Copyright © 2020 Splash Fire. All rights reserved.
//

/// Интерфейс взаимодействия с презентером экрана поиска.
protocol SearchPresentable {}

final class SearchPresenter: SearchPresentable {

    weak var viewController: SearchViewControllable?

    private let interactor: SearchInteractable
    private let coordinator: StartCoordinatorProtocol

    init(interactor: SearchInteractable,
        coordinator: StartCoordinatorProtocol) {
        self.interactor = interactor
        self.coordinator = coordinator
    }
}

// MARK: - SearchPresentableListener

extension SearchPresenter: SearchPresentableListener {

	func didLoad(_ viewController: SearchViewControllable) {}

	func didTapOnButton() {
//		coordinator.routeToPDFViewController(resourceName: "product")
//		coordinator.routeToSecondViewControllerInSM()
	}

	func didSelectBushingInSearchList() {
		coordinator.routeToSecondViewControllerInSM()
	}
}

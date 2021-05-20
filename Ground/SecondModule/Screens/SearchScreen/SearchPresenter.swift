//
//  FirstScreenSMPresenter.swift
//  Ground
//
//  Created by 17790204 on 27.11.2020.
//  Copyright © 2020 Splash Fire. All rights reserved.
//

/// Интерфейс взаимодействия с презентером экрана FirstScreenSM во флоу GG.
protocol FirstScreenSMPresentable {}

final class SearchPresenter: FirstScreenSMPresentable {

    weak var viewController: SearchViewControllable?

    private let interactor: FirstScreenSMInteractable
    private let coordinator: StartCoordinatorProtocol

    init(interactor: FirstScreenSMInteractable,
        coordinator: StartCoordinatorProtocol) {
        self.interactor = interactor
        self.coordinator = coordinator
    }
    // MARK: FirstScreenSMGGPresentable

}

// MARK: - FirstScreenSMPresentableListener

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

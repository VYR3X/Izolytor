//
//  FirstScreenSMPresenter.swift
//  Ground
//
//  Created by 17790204 on 27.11.2020.
//  Copyright © 2020 Splash Fire. All rights reserved.
//

/// Интерфейс взаимодействия с презентером экрана FirstScreenSM во флоу GG.
protocol FirstScreenSMPresentable {}

final class FirstScreenSMPresenter: FirstScreenSMPresentable {

    weak var viewController: FirstScreenSMViewControllable?

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

extension FirstScreenSMPresenter: FirstScreenSMPresentableListener {

	func didLoad(_ viewController: FirstScreenSMViewControllable) {}

	func didTapOnButton() {
		coordinator.routeToSecondViewControllerInSM()
	}
}

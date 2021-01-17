//
//  FirstScreenTMPresenter.swift
//  Ground
//
//  Created by 17790204 on 27.11.2020.
//  Copyright © 2020 Splash Fire. All rights reserved.
//

/// Интерфейс взаимодействия с презентером экрана FirstScreenTM во флоу GG.
protocol FirstScreenTMPresentable {}

final class FirstScreenTMPresenter: FirstScreenTMPresentable {

    weak var viewController: FirstScreenTMViewControllable?

    private let interactor: FirstScreenTMInteractable
    private let coordinator: StartCoordinatorProtocol

    init(interactor: FirstScreenTMInteractable,
        coordinator: StartCoordinatorProtocol) {
        self.interactor = interactor
        self.coordinator = coordinator
    }
    // MARK: FirstScreenTMGGPresentable

}

// MARK: - FirstScreenTMPresentableListener

extension FirstScreenTMPresenter: FirstScreenTMPresentableListener {

	func didLoad(_ viewController: FirstScreenTMViewControllable) {}

	func didTapOnButton() {
		coordinator.routeToSecondViewControllerInTM()
	}
}
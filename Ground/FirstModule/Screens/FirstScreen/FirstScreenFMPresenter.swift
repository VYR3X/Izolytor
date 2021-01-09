//
//  FirstScreenFMPresenter.swift
//  Ground
//
//  Created by 17790204 on 27.11.2020.
//  Copyright © 2020 Splash Fire. All rights reserved.
//

/// Интерфейс взаимодействия с презентером экрана FirstScreenFM во флоу GG.
protocol FirstScreenFMPresentable {}

final class FirstScreenFMPresenter: FirstScreenFMPresentable {

    weak var viewController: FirstScreenFMViewControllable?

    private let interactor: FirstScreenFMInteractable
    private let coordinator: StartCoordinatorProtocol

    init(interactor: FirstScreenFMInteractable,
		 coordinator: StartCoordinatorProtocol) {
        self.interactor = interactor
        self.coordinator = coordinator
    }

    // MARK: FirstScreenFMGGPresentable

}

// MARK: - FirstScreenFMPresentableListener

extension FirstScreenFMPresenter: FirstScreenFMPresentableListener {

	func didTapOnButton() {
		coordinator.routeToSecondViewControllerInFM()
	}

	func didLoad(_ viewController: FirstScreenFMViewControllable) {}

	
}

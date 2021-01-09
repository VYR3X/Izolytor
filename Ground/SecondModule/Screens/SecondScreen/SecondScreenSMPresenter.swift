//
//  SecondScreenSMPresenter.swift
//  Ground
//
//  Created by 17790204 on 27.11.2020.
//  Copyright © 2020 Splash Fire. All rights reserved.
//

/// Интерфейс взаимодействия с презентером экрана SecondScreenSM во флоу GG.
protocol SecondScreenSMPresentable {}

final class SecondScreenSMPresenter: SecondScreenSMPresentable {

    weak var viewController: SecondScreenSMViewControllable?

    private let interactor: SecondScreenSMInteractable
    private let coordinator: StartCoordinatorProtocol

    init(interactor: SecondScreenSMInteractable,
        coordinator: StartCoordinatorProtocol) {
        self.interactor = interactor
        self.coordinator = coordinator
    }

    // MARK: SecondScreenSMPresentable

}

// MARK: - SecondScreenSMPresentableListener

extension SecondScreenSMPresenter: SecondScreenSMPresentableListener {

	func didLoad(_ viewController: SecondScreenSMViewControllable) {}
}

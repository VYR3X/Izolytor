//
//  SecondScreenTMPresenter.swift
//  Ground
//
//  Created by 17790204 on 27.11.2020.
//  Copyright © 2020 Splash Fire. All rights reserved.
//

/// Интерфейс взаимодействия с презентером экрана SecondScreenTM во флоу GG.
protocol SecondScreenTMPresentable {}

final class SecondScreenTMPresenter: SecondScreenTMPresentable {

    weak var viewController: SecondScreenTMViewControllable?

    private let interactor: SecondScreenTMInteractable
    private let coordinator: StartCoordinatorProtocol

    init(interactor: SecondScreenTMInteractable,
        coordinator: StartCoordinatorProtocol) {
        self.interactor = interactor
        self.coordinator = coordinator
    }

    // MARK: SecondScreenTMPresentable

}

// MARK: - SecondScreenTMPresentableListener

extension SecondScreenTMPresenter: SecondScreenTMPresentableListener {

	func didLoad(_ viewController: SecondScreenTMViewControllable) {}
}

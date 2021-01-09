//
//  SecondScreenFMPresenter.swift
//  Ground
//
//  Created by 17790204 on 27.11.2020.
//  Copyright © 2020 Splash Fire. All rights reserved.
//

/// Интерфейс взаимодействия с презентером экрана SecondScreenFM во флоу Ground.
protocol SecondScreenFMPresentable {}

final class SecondScreenFMPresenter: SecondScreenFMPresentable {

    weak var viewController: SecondScreenFMViewControllable?

    private let interactor: SecondScreenFMInteractable
    private let coordinator: StartCoordinatorProtocol

    init(interactor: SecondScreenFMInteractable,
        coordinator: StartCoordinatorProtocol) {
        self.interactor = interactor
        self.coordinator = coordinator
    }

    // MARK: SecondScreenFMPresentable

}

// MARK: - SecondScreenFMPresentableListener

extension SecondScreenFMPresenter: SecondScreenFMPresentableListener {

	func didLoad(_ viewController: SecondScreenFMViewControllable) {}
}

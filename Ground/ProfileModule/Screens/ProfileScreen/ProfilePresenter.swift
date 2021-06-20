//
//  FirstScreenTMPresenter.swift
//  Ground
//
//  Created by 17790204 on 27.11.2020.
//  Copyright © 2020 Splash Fire. All rights reserved.
//

protocol ProfilePresentable {}

final class ProfilePresenter: ProfilePresentable {

    weak var viewController: ProfileViewControllable?

    private let interactor: ProfileInteractable
    private let coordinator: StartCoordinatorProtocol

    init(interactor: ProfileInteractable,
        coordinator: StartCoordinatorProtocol) {
        self.interactor = interactor
        self.coordinator = coordinator
    }
}

// MARK: - FirstScreenTMPresentableListener

extension ProfilePresenter: ProfilePresentableListener {

	func didLoad(_ viewController: ProfileViewControllable) {}
}

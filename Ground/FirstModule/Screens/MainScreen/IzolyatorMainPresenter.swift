//
//  IzolyatorMainPresenter.swift
//  Ground
//
//  Created by Vladislav Zhokhov on 27.11.2020.
//  Copyright © 2020 Splash Fire. All rights reserved.
//

/// Интерфейс взаимодействия с презентером экрана IzolyatorMainViewController
protocol IzolyatorMainPresentable {}


/// Презентер главного экрана приложения
final class IzolyatorMainPresenter: IzolyatorMainPresentable {

    weak var viewController: IzolyatorMainViewControllable?

    private let interactor: IzolyatorMainInteractable
    private let coordinator: StartCoordinatorProtocol

    init(interactor: IzolyatorMainInteractable,
		 coordinator: StartCoordinatorProtocol) {
        self.interactor = interactor
        self.coordinator = coordinator
    }
}

// MARK: - IzolyatorMainPresentableListener

extension IzolyatorMainPresenter: IzolyatorMainPresentableListener {

	func didTapOnButton() {
		coordinator.routeToSecondViewControllerInFM()
	}

	func didLoad(_ viewController: IzolyatorMainViewControllable) {}
}

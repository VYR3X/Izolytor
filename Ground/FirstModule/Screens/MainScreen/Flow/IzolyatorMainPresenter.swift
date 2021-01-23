//
//  IzolyatorMainPresenter.swift
//  Ground
//
//  Created by Vladislav Zhokhov on 27.11.2020.
//  Copyright © 2020 Splash Fire. All rights reserved.
//

import Foundation

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

	private func loadProduct() {
//		viewController?.displayInitialLoading()
		interactor.getDataSource { product in
			switch product {
			case let .success(productsModel):
				print("success")
				self.present(favChange: productsModel, on: self.viewController!)
			case let .failure(error):
				print("error log:  \(error)")
				self.presentErrorAlert()
			}
		}
	}

	private func present(favChange: [ProductServiceModel.MainScreenProductType], on viewController: IzolyatorMainViewControllable) {
		DispatchQueue.main.async {
			viewController.updateScreenWith(products: favChange)
		}
	}

	private func presentErrorAlert() {
		print("error")
	}
}

// MARK: - IzolyatorMainPresentableListener

extension IzolyatorMainPresenter: IzolyatorMainPresentableListener {

	func didTapOnARButton() {
		coordinator.routeToARSceneViewController()
	}

	/// надо переименовать
	func didTapOnFullInfoButton() {
		coordinator.routeToYouTubeViewController()
	}

	func didTapOnButton() {
		coordinator.routeToSecondViewControllerInFM()
	}

	func didLoad(_ viewController: IzolyatorMainViewControllable) {
		loadProduct()
	}
}

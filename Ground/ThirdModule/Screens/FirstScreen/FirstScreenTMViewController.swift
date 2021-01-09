//
//  FirstScreenTMViewController.swift
//  Ground
//
//  Created by 17790204 on 27.11.2020.
//  Copyright © 2020 Splash Fire. All rights reserved.
//

import UIKit

/// Интерфейс взаимодействия с вью-контроллером экрана FirstScreenTM.
protocol FirstScreenTMViewControllable: UIViewController {}

protocol FirstScreenTMPresentableListener {

	func didLoad(_ viewController: FirstScreenTMViewControllable)

	func didTapOnButton()
}

final class FirstScreenTMViewController: UIViewController, FirstScreenTMViewControllable {

    private let listener: FirstScreenTMPresentableListener

	// MARK: - UI

	private lazy var titleButton: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
		button.tintColor = .black
		button.backgroundColor = .white
		return button
	}()

    init(listener: FirstScreenTMPresentableListener) {
        self.listener = listener
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func viewDidLoad() {
        super.viewDidLoad()
		// Configuration
		// didLoad(_:)
		listener.didLoad(self)
		view.backgroundColor = .purple
		setupConstraints()
    }

	private func setupConstraints() {
		view.addSubview(titleButton)

		NSLayoutConstraint.activate([
			titleButton.heightAnchor.constraint(equalToConstant: 50),
			titleButton.widthAnchor.constraint(equalToConstant: 50),
			titleButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
			titleButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
		])
	}

	/// Метод для воспроизведение следующей композиции
	@objc func didTapButton() {
		listener.didTapOnButton()
	}
}

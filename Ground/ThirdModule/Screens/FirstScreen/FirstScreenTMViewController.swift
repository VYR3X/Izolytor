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

	private lazy var imageView: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.image = UIImage(named: "greetingsLogo")
		return imageView
	}()

	private lazy var titleLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.text = """
Компания «Изолятор» разрабатывает, производит и осуществляет сервисную поддержку высоковольтных вводов переменного и постоянного тока на напряжение от 12 до 1200 кВ.\n\nПредприятие является единственным в России, способным разрабатывать, производить и испытывать вводы на сверхвысокие классы напряжения.
"""
		label.numberOfLines = 0
		label.textColor = .black
//		label.backgroundColor = .white
		return label
	}()

//	private lazy var titleButton: UIButton = {
//		let button = UIButton()
//		button.translatesAutoresizingMaskIntoConstraints = false
//		button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
//		button.tintColor = .black
//		button.backgroundColor = .white
//		return button
//	}()

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
		view.backgroundColor = .white
		setupConstraints()
    }

	private func setupConstraints() {
		view.addSubviews(titleLabel, imageView)

		NSLayoutConstraint.activate([

			imageView.topAnchor.constraint(equalTo: view.safeTopAnchor, constant: 25),
			imageView.heightAnchor.constraint(equalToConstant: 120),
			imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
			imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),

			titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
			titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
			titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
		])
	}

	/// Метод для воспроизведение следующей композиции
	@objc func didTapButton() {
		listener.didTapOnButton()
	}
}

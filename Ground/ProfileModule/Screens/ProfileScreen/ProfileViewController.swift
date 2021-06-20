//
//  ProfileViewController.swift
//  Ground
//
//  Created by 17790204 on 27.11.2020.
//  Copyright © 2020 Splash Fire. All rights reserved.
//

import UIKit

/// Интерфейс взаимодействия с вью-контроллером экрана ProfileViewControllable.
protocol ProfileViewControllable: UIViewController {}

protocol ProfilePresentableListener {

	func didLoad(_ viewController: ProfileViewControllable)
}

/// Вью контроллер экрана - Профиль
final class ProfileViewController: UIViewController, ProfileViewControllable {

	private struct Constants {
		static let offset: CGFloat = 25
		static let titleLabelTopOffset: CGFloat = 20
	}

    private let listener: ProfilePresentableListener

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
		return label
	}()

    init(listener: ProfilePresentableListener) {
        self.listener = listener
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func viewDidLoad() {
        super.viewDidLoad()
		listener.didLoad(self)
		view.backgroundColor = .white
		setupConstraints()
    }

	private func setupConstraints() {
		view.addSubviews(titleLabel, imageView)

		NSLayoutConstraint.activate([

			imageView.topAnchor.constraint(equalTo: view.safeTopAnchor, constant: Constants.offset),
			imageView.heightAnchor.constraint(equalToConstant: 120),
			imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.offset),
			imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.offset),

			titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: Constants.titleLabelTopOffset),
			titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.offset),
			titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.offset),
		])
	}
}

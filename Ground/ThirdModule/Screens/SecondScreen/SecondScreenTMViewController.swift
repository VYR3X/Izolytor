//
//  SecondScreenTMViewController.swift
//  Ground
//
//  Created by 17790204 on 27.11.2020.
//  Copyright © 2020 Splash Fire. All rights reserved.
//

import UIKit

/// Интерфейс взаимодействия с вью-контроллером экрана SecondScreenTM.
protocol SecondScreenTMViewControllable: UIViewController {}

protocol SecondScreenTMPresentableListener {

	func didLoad(_ viewController: SecondScreenTMViewControllable)
}

final class SecondScreenTMViewController: UIViewController, SecondScreenTMViewControllable {

    private let listener: SecondScreenTMPresentableListener

    init(listener: SecondScreenTMPresentableListener) {
        self.listener = listener
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
		// Configuration
		// didLoad(_:)
		listener.didLoad(self)
		view.backgroundColor = .orange
    }
}

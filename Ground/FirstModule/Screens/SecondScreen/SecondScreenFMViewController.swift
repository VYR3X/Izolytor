//
//  SecondScreenFMViewController.swift
//  Ground
//
//  Created by 17790204 on 27.11.2020.
//  Copyright © 2020 Splash Fire. All rights reserved.
//

import UIKit

/// Интерфейс взаимодействия с вью-контроллером экрана SecondScreenFM.
protocol SecondScreenFMViewControllable: UIViewController {}

protocol SecondScreenFMPresentableListener {

	func didLoad(_ viewController: SecondScreenFMViewControllable)
}

final class SecondScreenFMViewController: UIViewController, SecondScreenFMViewControllable {

    private let listener: SecondScreenFMPresentableListener

    init(listener: SecondScreenFMPresentableListener) {
        self.listener = listener
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func viewDidLoad() {
        super.viewDidLoad()
		listener.didLoad(self)
		view.backgroundColor = .orange
    }

    // MARK: SecondScreenFMViewControllable
}

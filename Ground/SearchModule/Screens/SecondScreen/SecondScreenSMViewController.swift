//
//  SecondScreenSMViewController.swift
//  Ground
//
//  Created by 17790204 on 27.11.2020.
//  Copyright © 2020 Splash Fire. All rights reserved.
//

import UIKit
import SceneKit

/// Интерфейс взаимодействия с вью-контроллером экрана SecondScreenSM.
protocol SecondScreenSMViewControllable: UIViewController {}

protocol SecondScreenSMPresentableListener {

	func didLoad(_ viewController: SecondScreenSMViewControllable)
}

final class SecondScreenSMViewController: UIViewController, SecondScreenSMViewControllable {

    private let listener: SecondScreenSMPresentableListener

	private let sceneView = SCNView()

    init(listener: SecondScreenSMPresentableListener) {
        self.listener = listener
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func viewDidLoad() {
        super.viewDidLoad()
		listener.didLoad(self)
		sceneView.translatesAutoresizingMaskIntoConstraints = false
		setupConstraints()
		view.backgroundColor = .orange
    }

	private func setupConstraints() {
		view.addSubview(sceneView)
		sceneView.backgroundColor = .blue
		NSLayoutConstraint.activate([
			sceneView.topAnchor.constraint(equalTo: view.topAnchor),
			sceneView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			sceneView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			sceneView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])
	}

	
}

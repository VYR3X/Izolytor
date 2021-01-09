//
//  FirstScreenSMViewController.swift
//  Ground
//
//  Created by 17790204 on 27.11.2020.
//  Copyright © 2020 Splash Fire. All rights reserved.
//

import UIKit
import SceneKit

/// Интерфейс взаимодействия с вью-контроллером экрана FirstScreenSM.
protocol FirstScreenSMViewControllable: UIViewController {}

protocol FirstScreenSMPresentableListener {

	func didLoad(_ viewController: FirstScreenSMViewControllable)

	func didTapOnButton()
}

final class FirstScreenSMViewController: UIViewController, FirstScreenSMViewControllable {

    private let listener: FirstScreenSMPresentableListener

	// MARK: - UI
	private let sceneView = SCNView()

//	lazy var titleLabel: UILabel = {
//		let label = UILabel()
//		label.translatesAutoresizingMaskIntoConstraints = false
//		return label
//	}

    init(listener: FirstScreenSMPresentableListener) {
        self.listener = listener
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func viewDidLoad() {
        super.viewDidLoad()
		listener.didLoad(self)
		sceneView.translatesAutoresizingMaskIntoConstraints = false
		initSceneWithContent()
		setupConstraints()
    }

	private func setupConstraints() {
		view.addSubview(sceneView)
		view.backgroundColor = .white
		NSLayoutConstraint.activate([
			sceneView.topAnchor.constraint(equalTo: view.topAnchor),
			sceneView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			sceneView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			sceneView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -300)
		])
	}

	/// Метод для воспроизведение следующей композиции
	@objc func didTapButton() {
		listener.didTapOnButton()
	}

	private func initSceneWithContent() {
		// 1: Load .obj file
		let scene = SCNScene(named: "converse_obj.obj")

		// 2: Add camera node
		let cameraNode = SCNNode()
		cameraNode.camera = SCNCamera()
		// 3: Place camera
		cameraNode.position = SCNVector3(x: 0, y: 10, z: 35)
		// 4: Set camera on scene
		scene?.rootNode.addChildNode(cameraNode)

		// 5: Adding light to scene
		let lightNode = SCNNode()
		lightNode.light = SCNLight()
		lightNode.light?.type = .omni
		lightNode.position = SCNVector3(x: 0, y: 10, z: 35)
		scene?.rootNode.addChildNode(lightNode)

		// 6: Creating and adding ambien light to scene
		let ambientLightNode = SCNNode()
		ambientLightNode.light = SCNLight()
		ambientLightNode.light?.type = .ambient
		ambientLightNode.light?.color = UIColor.darkGray
		scene?.rootNode.addChildNode(ambientLightNode)

		// Allow user to manipulate camera
		sceneView.allowsCameraControl = true

		// Show FPS logs and timming
		// sceneView.showsStatistics = true

		// Set background color
		sceneView.backgroundColor = UIColor.white

		// Allow user translate image
		sceneView.cameraControlConfiguration.allowsTranslation = false

		// Set scene settings
		sceneView.scene = scene
	}

    // MARK: FirstScreenSMViewControllable
}

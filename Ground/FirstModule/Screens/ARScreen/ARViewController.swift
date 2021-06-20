//
//  ARViewController.swift
//  Izolyator
//
//  Created by 17790204 on 31.01.2021.
//  Copyright © 2021 Splash Fire. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

/// AR вью котнроллер
final class ARViewController: UIViewController {

	// вынес ноду самолет в локальную переменную для возможности позиционирования
	private var shipNode: SCNNode?
	// Store The Rotation Of The CurrentNode
	private var currentAngleY: Float = 0.0
	// Not Really Necessary But Can Use If You Like
	private var isRotating = false

	// AugmentedRealityView
	private lazy var sceneView: ARSCNView = {
		let sceneView = ARSCNView()
		sceneView.delegate = self
		// Отображаем fps и еще данные статистики
		sceneView.showsStatistics = false
		return sceneView
	}()

	private let informationLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.backgroundColor = .clear
		label.text = "Трансформаторный ввод"
		label.textAlignment = .center
		return label
	}()

	private lazy var scaleButton: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.addTarget(self, action: #selector(scaleObjectFromButton(_:)), for: .touchUpInside)
		button.tintColor = .black
		button.backgroundColor = .white
		return button
	}()

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		let configuration = ARWorldTrackingConfiguration()
		sceneView.session.run(configuration)
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		createShipSceneNode()
		setupView()
		setUpGesture()
	}

	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		sceneView.session.pause()
	}

	private func setupView() {

		view.addSubview(sceneView)
//		sceneView.addSubviews(informationLabel, scaleButton)
		sceneView.addSubview(informationLabel)
		sceneView.pinToSuperView()
		NSLayoutConstraint.activate([
			informationLabel.centerXAnchor.constraint(equalTo: sceneView.centerXAnchor),
			informationLabel.heightAnchor.constraint(equalToConstant: 25),
			informationLabel.widthAnchor.constraint(equalTo: view.widthAnchor),
			informationLabel.bottomAnchor.constraint(equalTo: view.safeBottomAnchor)

//			scaleButton.centerYAnchor.constraint(equalTo: sceneView.centerYAnchor),
//			scaleButton.heightAnchor.constraint(equalToConstant: 25),
//			scaleButton.widthAnchor.constraint(equalToConstant: 25),
//			scaleButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
		])
	}

	private func setUpGesture() {
		// По нажатию перемещаю
		self.addTapGesture()
		// Перемещение по касанию 
//		self.addPanGesture()
		// Увеличение работает
		self.addPinchGesture()
		// Крутится вокруг своей оси
		self.addRotationGesture()
		//	Крутится не вокруг своей оси а вокруг носа
//		self.addRotationGestureToMoveObject()
	}

	private func createShipSceneNode() {
		//"art.scnassets/ship.scn"
		guard let shipScene = SCNScene(named: "art.scnassets/bushing3D.dae") else { return }
//		"shipMesh"
		shipNode = shipScene.rootNode.childNode(withName: "Cylinder475", recursively: true)
		sceneView.scene = shipScene

//		guard let shipScene = SCNScene(named: "art.scnassets/DemaModel.dae") else { return }
//		shipNode = shipScene.rootNode.childNode(withName: "Cylinder507", recursively: true)
//		sceneView.scene = shipScene
	}

	/// Установить жест для перемещения модели по нажатию на экран
	private func addTapGesture() {
		let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTap(_:)))
		self.sceneView.addGestureRecognizer(tapGesture)
	}

	/// Установить жест для увеличения размера модели
	private func addPinchGesture() {
		let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(scaleObject(_:)))
		self.sceneView.addGestureRecognizer(pinchGesture)
	}

	/// Установить жест для вращения модели
	private func addRotationGesture() {
		let panGesture = UIRotationGestureRecognizer(target: self, action: #selector(rotateNode(_:)))
		self.sceneView.addGestureRecognizer(panGesture)
	}

	// Доп метод
	private func addPanGesture() {
		let panGesture = UIPanGestureRecognizer(target: self, action: #selector(moveNode(_:)))
//		let panGesture = UIPanGestureRecognizer(target: self, action: #selector(rotateObject(_:)))
		self.sceneView.addGestureRecognizer(panGesture)
	}

	private func addRotationGestureToMoveObject() {
		let panGesture = UIRotationGestureRecognizer(target: self, action: #selector(rotateNodeSecond(_:)))
		self.sceneView.addGestureRecognizer(panGesture)
	}

	// добавляем освещение к ноде ( то есть к обьекту)
	func addLightNodeTo(_ node: SCNNode) {
		let lightNode = getLightNode()
		node.addChildNode(lightNode)
//		lightNodes.append(lightNode)
	}

	// создаем освещение
	func getLightNode() -> SCNNode {
		let light = SCNLight()
		light.type = .omni
		light.intensity = 0
		light.temperature = 0

		let lightNode = SCNNode()
		lightNode.light = light
		lightNode.position = SCNVector3(0,1,0)

		return lightNode
	}

	func getSphereNode(withPosition position: SCNVector3) -> SCNNode {
		let sphere = SCNSphere(radius: 0.1)

		let sphereNode = SCNNode(geometry: sphere)
		sphereNode.position = position
		sphereNode.position.y += Float(sphere.radius) + 1

		return sphereNode
	}

	/// Нажатие на экран для перемещения обьекта
	@objc func didTap(_ gesture: UIPanGestureRecognizer) {
		// Координата нажатия пальца на экране
		let tapLocation = gesture.location(in: self.sceneView)
		// Найдем точку на виртульной плоскости
		let results = self.sceneView.hitTest(tapLocation, types: .featurePoint)
		// Получаем первое касание по экрану
		guard let result = results.first else { return }

		let translation = result.worldTransform.translation

		shipNode!.position = SCNVector3Make(translation.x, translation.y, translation.z)
		self.sceneView.scene.rootNode.addChildNode(shipNode!)
		addLightNodeTo(shipNode!)
	}

	@objc func moveNode(_ gesture: UIPanGestureRecognizer) {
		if !isRotating {
		//1. Get The Current Touch Point
		let currentTouchPoint = gesture.location(in: self.sceneView)
		//2. Get The Next Feature Point Etc
		guard let hitTest = self.sceneView.hitTest(currentTouchPoint, types: .existingPlane).first else { return }
		//3. Convert To World Coordinates
		let worldTransform = hitTest.worldTransform
		//4. Set The New Position
		let newPosition = SCNVector3(worldTransform.columns.3.x, worldTransform.columns.3.y, worldTransform.columns.3.z)
		//5. Apply To The Node
		shipNode?.position = SCNVector3Make(newPosition.x, newPosition.y, newPosition.z)
//		shipNode?.simdPosition = float3(newPosition.x, newPosition.y, newPosition.z)
		}
	}

	@objc func rotateNode(_ gesture: UIRotationGestureRecognizer){
		//1. Get The Current Rotation From The Gesture
		let rotation = Float(gesture.rotation)
		//2. If The Gesture State Has Changed Set The Nodes EulerAngles.y
		if gesture.state == .changed {
			isRotating = true
			shipNode?.eulerAngles.y = currentAngleY + rotation
		}
		//3. If The Gesture Has Ended Store The Last Angle Of The Cube
		if(gesture.state == .ended) {
			currentAngleY = (shipNode?.eulerAngles.y)!
			isRotating = false
		}
	}

	/// вращение вокруг носа корабля а не оси хотя я хотел переместить а не вращать
	@objc func rotateNodeSecond(_ gesture: UIRotationGestureRecognizer){
		//1. Get The Current Rotation From The Gesture
		let rotation = Float(gesture.rotation)
		//2. If The Gesture State Has Changed Set The Nodes EulerAngles.y
		if gesture.state == .changed {
			shipNode?.eulerAngles.y = currentAngleY + rotation
		}
		//3. If The Gesture Has Ended Store The Last Angle Of The Cube
		if(gesture.state == .ended) {
			currentAngleY = (shipNode?.eulerAngles.y)!
		}
	}

	/// третий способ лдя вращения
	@objc func rotateObject(_ gesture: UIPanGestureRecognizer) {
		guard let nodeToRotate = shipNode else { return }
		let translation = gesture.translation(in: gesture.view!)
		var newAngleY = (Float)(translation.x) * (Float)(Double.pi) / 180.0
		newAngleY += currentAngleY
		nodeToRotate.eulerAngles.y = newAngleY
		if(gesture.state == .ended) { currentAngleY = newAngleY }
		print(nodeToRotate.eulerAngles)
	}

	// первая версия скейлинга
//	@objc func didPinch(_ gesture: UIPinchGestureRecognizer) {
//        let originalScale = node.scale
//
//        switch gesture.state {
//        case .began:
//            gesture.scale = CGFloat(originalScale.x)
//        case .changed:
//            var newScale: SCNVector3
//            if gesture.scale < 0.5 {
//                newScale = SCNVector3(x: 0.5, y: 0.5, z: 0.5)
//            } else if gesture.scale > 3 {
//                newScale = SCNVector3(3, 3, 3)
//            } else {
//                newScale = SCNVector3(gesture.scale, gesture.scale, gesture.scale)
//            }
//            node.scale = newScale
//        default:
//            break
//        }
//    }

	@objc func scaleObject(_ gesture: UIPinchGestureRecognizer) {

		let location = gesture.location(in: sceneView)
		let hitTestResults = sceneView.hitTest(location)
		guard let nodeToScale = hitTestResults.first?.node else { return }

		if gesture.state == .changed {
			let pinchScaleX: CGFloat = gesture.scale * CGFloat((nodeToScale.scale.x))
			let pinchScaleY: CGFloat = gesture.scale * CGFloat((nodeToScale.scale.y))
			let pinchScaleZ: CGFloat = gesture.scale * CGFloat((nodeToScale.scale.z))
			nodeToScale.scale = SCNVector3Make(Float(pinchScaleX), Float(pinchScaleY), Float(pinchScaleZ))
			gesture.scale = 1
		}
		if gesture.state == .ended { }
	}


	@objc func scaleObjectFromButton(_ gesture: UIPinchGestureRecognizer) {

		let location = gesture.location(in: sceneView)
		let hitTestResults = sceneView.hitTest(location)
		guard let nodeToScale = hitTestResults.first?.node else { return }

		if gesture.state == .changed {
			let pinchScaleX: CGFloat = 2 * CGFloat((nodeToScale.scale.x))
			let pinchScaleY: CGFloat = 2 * CGFloat((nodeToScale.scale.y))
			let pinchScaleZ: CGFloat = 2 * CGFloat((nodeToScale.scale.z))
			nodeToScale.scale = SCNVector3Make(Float(pinchScaleX), Float(pinchScaleY), Float(pinchScaleZ))
			gesture.scale = 1
		}
		if gesture.state == .ended { }
	}

/*
	/// Находим точку на экране телефона где мы нажали на экране
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		//self.sceneView.scene.removeAllParticleSystems()
		// Получаем первое касание на экране
		guard let touch = touches.first else { return }
		// координата нажатия пальца на экране
		let position = touch.location(in: sceneView)
		// Найдем точку на виртульной плоскости
		let result = sceneView.hitTest(position, types: [.featurePoint])
		// hitTest - это по факту луч от телефона до виртульаной плоскости
		guard let hitResult = result.last else { return }
		// матрица - описывающая точку пересечения луча и виртуальной плоскотси
		let hitMatrix = hitResult.worldTransform
		// создадим матрицу из hitMatrix
		let matrix = SCNMatrix4.init(hitMatrix)
		// теперь из матрицы SCNMatrix можно получить координаты точки на виртуальной плоскости
		// x = matrix.m41, y = matrix.m42, z = matrix.m43
		// создадим вектор позиций
		let hitVextor = SCNVector3(matrix.m41, matrix.m42, matrix.m43)
		createBall(position: hitVextor)
	}

	//  создадим обьект который будем размещать
	func createBall(position: SCNVector3) {
		// начинаем создание обьекта с создания его геометрии
		let ballShape = SCNSphere(radius: 0.05)
		// создадим узел - узел это и есть объект который мы разместим
		// установим в узел геометрию и позицию
		let ballNode = SCNNode(geometry: ballShape)
		ballNode.position = position
		// добавляем обьек на сцену
		sceneView.scene.rootNode.addChildNode(ballNode)
	}
*/

	// Drag object
	/*
	override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
		//1. Get The Current Touch Point
		guard let currentTouchPoint = touches.first?.location(in: self.sceneView),
			//2. Get The Next Feature Point Etc
			let hitTest = sceneView.hitTest(currentTouchPoint, types: .existingPlane).first else { return }

		//3. Convert To World Coordinates
		let worldTransform = hitTest.worldTransform

		//4. Set The New Position
		let newPosition = SCNVector3(worldTransform.columns.3.x, worldTransform.columns.3.y, worldTransform.columns.3.z)

		//5. Apply To The Node
		self.sceneView.scene.rootNode.enumerateChildNodes{ (node, _) in
		   node.simdPosition = float3(newPosition.x, newPosition.y, newPosition.z)
		}
	}
*/
}

extension float4x4 {
	var translation: float3 {
		let translation = self.columns.3
		return float3(translation.x, translation.y, translation.z)
	}
}

extension ARViewController: ARSCNViewDelegate {

}

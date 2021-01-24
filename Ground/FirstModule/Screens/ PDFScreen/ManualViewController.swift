//
//  ManualViewController.swift
//  Izolyator
//
//  Created by Vladislav Zhokhov on 23.01.2021.
//  Copyright © 2021 Splash Fire. All rights reserved.
//

import UIKit
import PDFKit

/// Интерфейс взаимодействия с вью-контроллером экрана ProductDetailViewController.
protocol ManualViewControllable: UIViewController {}

protocol ManualViewControllerListener {

	func didLoad(_ viewController: ProductDetailViewControllable)

	func didTapOnYouTubeButton()

	func didTapOnArButton()
}

final class ManualViewController: UIViewController, ManualViewControllable {

	private let listener: ManualViewControllerListener

	private lazy var pdfView: PDFView = {
		let view = PDFView()
		view.translatesAutoresizingMaskIntoConstraints = false
//		view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		view.autoScales = true
		return view
	}()

	private lazy var multipleView: MultipleView = {
		let view = MultipleView()
		view.productFullInfoLabel.text = "Youtube Source"
		view.delegate = self
		return view
	}()

	init(listener: ManualViewControllerListener) {
		self.listener = listener
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

	override func viewDidLoad() {
		super.viewDidLoad()
		setupView()
		loadPDF()
	}

	private func setupView() {
		view.addSubview(pdfView)
		pdfView.addSubview(multipleView)

		NSLayoutConstraint.activate([
			pdfView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
			pdfView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
			pdfView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			pdfView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

			multipleView.heightAnchor.constraint(equalToConstant: 45),
			multipleView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			multipleView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			multipleView.bottomAnchor.constraint(equalTo: view.safeBottomAnchor)
		])
	}

	private func loadPDF() {
		guard let path = Bundle.main.url(forResource: "manual", withExtension: "pdf") else {
			return
		}
		if let document = PDFDocument(url: path) {
			pdfView.document = document
		}
	}
}

// MARK: - MultipleViewDelegate

extension ManualViewController: MultipleViewDelegate {

	func didTapLeftButton() {
		listener.didTapOnYouTubeButton()
	}

//	func openFullInfoViewController() {
//		listener.didTapOnYouTubeButton()
//	}

	func openArScene() {
		listener.didTapOnArButton()
	}
}


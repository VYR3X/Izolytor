//
//  SecondScreenFMViewController.swift
//  Ground
//
//  Created by Vladislav Zhokhov on 27.11.2020.
//  Copyright © 2020 Splash Fire. All rights reserved.
//

import UIKit
import PDFKit

/// Интерфейс взаимодействия с вью-контроллером экрана ProductDetailViewController.
protocol ProductDetailViewControllable: UIViewController {}

protocol ProductDetailViewControllerListener {

	func didLoad(_ viewController: ProductDetailViewControllable)

	func didTapOnLeftButton()

	func didTapOnArButton()
}

final class ProductDetailViewController: UIViewController, ProductDetailViewControllable {

	/// Название pdf документа для отображения
	var pdfResourceName: String = ""

    private let listener: ProductDetailViewControllerListener

	private lazy var pdfView: PDFView = {
		let view = PDFView()
		view.translatesAutoresizingMaskIntoConstraints = false
//		view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		view.autoScales = true
		return view
	}()

//	private lazy var multipleView: MultipleView = {
//		let view = MultipleView()
//		view.productFullInfoLabel.text = "Youtube Source"
//		view.delegate = self
//		return view
//	}()

	required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    init(listener: ProductDetailViewControllerListener) {
        self.listener = listener
        super.init(nibName: nil, bundle: nil)
    }

	override func viewDidLoad() {
        super.viewDidLoad()
		setupView()
		loadPDF(resource: pdfResourceName)
    }

	private func setupView() {
		view.addSubview(pdfView)
//		pdfView.addSubview(multipleView)

		NSLayoutConstraint.activate([
			pdfView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
			pdfView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
			pdfView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			pdfView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

//			multipleView.heightAnchor.constraint(equalToConstant: 45),
//			multipleView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//			multipleView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//			multipleView.bottomAnchor.constraint(equalTo: view.safeBottomAnchor)
		])
	}

	private func loadPDF(resource: String) {
		guard let path = Bundle.main.url(forResource: resource,
										 withExtension: "pdf") else { return }
		if let document = PDFDocument(url: path) {
			pdfView.document = document
		}
	}
}

// MARK: - MultipleViewDelegate

//extension ProductDetailViewController: MultipleViewDelegate {
//
//	func didTapLeftButton() {
//		listener.didTapOnLeftButton()
//	}
//
//	func openArScene() {
//		listener.didTapOnArButton()
//	}
//}

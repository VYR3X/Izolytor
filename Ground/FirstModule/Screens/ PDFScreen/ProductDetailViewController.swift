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

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
		
	}
	override func viewDidLoad() {
        super.viewDidLoad()
		setupView()
		loadPDF(resource: pdfResourceName)
		self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
		// https://stackoverflow.com/questions/22413193/dark-shadow-on-navigation-bar-during-segue-transition-after-upgrading-to-xcode-5
		// фикс бага
		self.navigationController?.view.backgroundColor = .white
		// или вот так ( хотя таб бар тоже темный сука )
//		navigationController?.navigationBar.isTranslucent = false
    }

	private func setNavigationBar() {
		let screenSize: CGRect = UIScreen.main.bounds
		let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 50))
//		navBar.backgroundColor = .blue
		let navItem = UINavigationItem(title: "")
		let rightButton = UIBarButtonItem(title: "test", style: .done, target: self, action: #selector(addTapped))
		//let doneItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.camera, target: self, action: #selector(addTapped))
		navItem.rightBarButtonItem = rightButton
		navBar.setItems([navItem], animated: false)
//		navBar.isTranslucent = true
		self.view.addSubview(navBar)
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

	@objc func addTapped() {
		let alert = UIAlertController(title: "Меню", message: "Выберите опцию", preferredStyle: .actionSheet)

		alert.addAction(UIAlertAction(title: "Открыть AR сцену", style: .default , handler:{ (UIAlertAction) in
			print("User click Edit button")
			self.listener.didTapOnArButton()
		}))

		alert.addAction(UIAlertAction(title: "Поделиться", style: .default , handler:{ (UIAlertAction) in
			self.btnTapped()
			print("User click Delete button")
		}))

		alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:{ (UIAlertAction) in
			print("User click Dismiss button")
		}))


		//uncomment for iPad Support
		//alert.popoverPresentationController?.sourceView = self.view

		self.present(alert, animated: true, completion: {
			print("completion block")
		})
	}

	private func loadPDF(resource: String) {
		guard let path = Bundle.main.url(forResource: resource,
										 withExtension: "pdf") else { return }
		if let document = PDFDocument(url: path) {
			pdfView.document = document
		}
	}

	// https://stackoverflow.com/questions/37990711/use-of-uiactivityviewcontroller-and-uiactivityitemprovider-to-share-pdf
	// sharing screen
	private func btnTapped() {
		if let pdf = Bundle.main.url(forResource: pdfResourceName,
									 withExtension: "pdf",
									 subdirectory: nil,
									 localization: nil)  {
			self.sharePdf(path: pdf)
		}
	}

	private func sharePdf(path: URL) {

		let fileManager = FileManager.default

		if fileManager.fileExists(atPath: path.path) {
			let activityViewController: UIActivityViewController = UIActivityViewController(activityItems: [path],
																							applicationActivities: nil)
			activityViewController.popoverPresentationController?.sourceView = self.view
			self.present(activityViewController, animated: true, completion: nil)
		} else {

			let alertController = UIAlertController(title: "Error",
													message: "Document was not found!",
													preferredStyle: .alert)
			print("document was not found")
			let defaultAction = UIAlertAction.init(title: "ok",
												   style: UIAlertAction.Style.default,
												   handler: nil)
			alertController.addAction(defaultAction)
			self.present(alertController, animated: true, completion: nil)
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

//
//  IzolyatorMainViewController.swift
//  Ground
//
//  Created by Vladislav Zhokhov on 27.11.2020.
//  Copyright © 2020 Splash Fire. All rights reserved.
//

import UIKit
import Skyline

/// Интерфейс взаимодействия с вью-контроллером экрана IzolyatorMainViewController.
protocol IzolyatorMainViewControllable: UIViewController {

//	var dataSource: ProductType { get set }

//	func updateScreenWith(viewModel: Result<ProductsViewModel, Error>)

	/// Отображает текущий город.
	/// - Parameter city: Название города.
	func updateScreenWith(products: [ProductServiceModel.MainScreenProductModel])

	/// Отображает премьеры.
	/// - Parameter premieres: Премьеры.
//	func show(premieres: MainViewModel.Movies)

	/// Отображает кинотеатры.
	/// - Parameter cinemas: Кинотеатры.
//	func show(cinemas: MainViewModel.Cinemas)

	/// Отображает добавление кинотеатра в «Избранное».
	/// - Parameter change: Вью-модель с идентификатором кинотеатра и признаком наличия в «Избранном».
//	func show(_ change: MainViewModel.FavoriteCinemasChange)

	/// Отображает заглушку.
	///
	/// - Parameter emptySate: Вью-модель заглушки.
//	func show(_ emptyState: EmptyStateTableItem)

	/// Отображает предложение города.
	/// - Parameter suggestion: Предложение города.
//	func show(_ suggestion: LangIdentifier)
}


/// Листенер главного экрана приложения
protocol IzolyatorMainPresentableListener {

	func didLoad(_ viewController: IzolyatorMainViewControllable)

	func didTapOnARButton()

	func didTapOnFullInfoButton()
}


/// Главный экран приложения с каруселью продуктов
final class IzolyatorMainViewController: UIViewController {

	/// Продукты 
	var productsMain: [ProductServiceModel.MainScreenProductModel] = []

	/// Индекс текущей ячейки
	var currentIndex: Int = 0

	private struct Constants {
		static let productTableViewCellHeight: CGFloat = 350
		static let modelTableViewCellHeight: CGFloat = 45
		static let collapse: CGFloat = 100
		static let sectionsCount = 3
	}

	/// Секции для content table view 
	private enum Section: Int, CaseIterable {
		/// Карусель с продуктами
		case products = 0
		/// Информация о вводе
		case info
	}

	private let listener: IzolyatorMainPresentableListener

	private let mainBackGroundView = MainBackGroundView()

	private var gradientLayer: CAGradientLayer = {
		let gradientLayer = CAGradientLayer()
		let colorLeft = UIColor.systemBlue.cgColor
		let colorRight = UIColor.blue.cgColor

		gradientLayer.colors = [colorLeft, colorRight]
		gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
		gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
		return gradientLayer
	}()

	private lazy var containerTableView: UITableView = {
		let tableView = UITableView(frame: .zero, style: .plain)
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.register(ProductTableViewCell.self,
						   forCellReuseIdentifier: String(describing: ProductTableViewCell.self))
		tableView.register(ProductInfoTableViewCell.self,
						   forCellReuseIdentifier: String(describing: ProductInfoTableViewCell.self))
		tableView.delegate = self
		tableView.dataSource = self
		tableView.separatorStyle = .none
		tableView.backgroundColor = .clear
		tableView.showsVerticalScrollIndicator = false
		tableView.allowsSelection = false
		return tableView
	}()

	private lazy var multipleView: MultipleView = {
		let view = MultipleView()
		view.productFullInfoLabel.text = "Монтаж"
		view.delegate = self
		return view
	}()

	// Навигационный бар
	private var navBar: NavigationControllerProtocol {
		get {
			return self.navigationController as! NavigationControllerProtocol
		}
		set {}
	}

	// MARK: - LIVE VIEW CONTROLER

	/// hide navigation bar
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
//		self.navigationController?.navigationBar.prefersLargeTitles = true
//		setupNavigationBar()
		setGradientBackground()

		// пример изменения полей у навигациооного бара
//		navBar.customNavigationBarTintColot = .orange
//		navBar.customNavigationBarTitleColor = .black
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		listener.didLoad(self)
		multipleView.delegate = self
		setupConstraints()
		self.navigationItem.title = "Изолятор"
		self.navigationItem.largeTitleDisplayMode = .always
    }

	init(listener: IzolyatorMainPresentableListener) {
		self.listener = listener
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }


	private func setupConstraints() {
		view.addSubview(containerTableView)
		view.backgroundColor = .white
		containerTableView.addSubview(multipleView)

		NSLayoutConstraint.activate([
			containerTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
			containerTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
			containerTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			containerTableView.topAnchor.constraint(equalTo: view.topAnchor),

			multipleView.heightAnchor.constraint(equalToConstant: 60),
			multipleView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			multipleView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			multipleView.bottomAnchor.constraint(equalTo: view.safeBottomAnchor, constant: -20)
		])
	}

	private func setGradientBackground() {
		self.gradientLayer.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height / 2)
		self.view.layer.insertSublayer(gradientLayer, at:0)
	}
}


// MARK: - UITableViewDelegate

extension IzolyatorMainViewController: UITableViewDelegate {

	/// Выставили высоту для 1 и 3 ячейки в 0
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return section == 0 || section == 2 ? .leastNormalMagnitude : 45.0
	}

	// https://stackoverflow.com/questions/30364067/space-between-sections-in-uitableview
	// убрал ебучий отступ между секцией и ячейками
	func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
		return .leastNormalMagnitude
	}

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		switch indexPath.section {
		case Section.products.rawValue:
			return Constants.productTableViewCellHeight // 350
		case Section.info.rawValue:
			return 450 //Constants.productTableViewCellHeight
		default:
			return 0
		}
	}


	/// Вью для секции ячеек
//	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//		let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as? CollapsibleTableViewHeader ?? CollapsibleTableViewHeader(reuseIdentifier: "header")
//		if productsMain.isEmpty {
//			return header
//		} else {
//			header.typeLabel.text = productsMain[currentIndex].typeName //"ВВ Трансформаторный тип" //sections[section].name
//			header.setCollapsed(productsMain[currentIndex].modelSectionCollapsed)
//
//			header.section = section
//			header.delegate = self
//
//			return header
//		}
//	}
}

// MARK: - UITableViewDataSource

extension IzolyatorMainViewController: UITableViewDataSource {

	func numberOfSections(in tableView: UITableView) -> Int {
		return Section.allCases.count
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		switch section {
		case Section.products.rawValue:
			return 1
//		case Section.models.rawValue:
			//return sections[section].collapsed ? 0 : sections[section].items.count
//			if productsMain.isEmpty {
//				return 0
//			} else {
//				return  productsMain[currentIndex].modelSectionCollapsed ? 0 : productsMain[currentIndex].models.count
//			}
		case Section.info.rawValue:
			return 1
		default:
			return 0
		}
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		switch indexPath.section {
		case Section.products.rawValue:
			guard let cell = containerTableView.dequeueReusableCell(withIdentifier:
																		String(describing: ProductTableViewCell.self),
																	for: indexPath) as? ProductTableViewCell else {
				return UITableViewCell()
			}
			cell.backgroundColor = .clear
			cell.updateCollectionViewWith(source: productsMain,
										  delegate: self)
			return cell
		case Section.info.rawValue:
			guard let cell = containerTableView.dequeueReusableCell(withIdentifier:
																		String(describing: ProductInfoTableViewCell.self), for: indexPath) as? ProductInfoTableViewCell else {
				return UITableViewCell()
			}

			cell.backgroundColor = .white
			if productsMain.isEmpty {
			 return cell
			} else {
				cell.bind(title: productsMain[currentIndex].typeName,
						  text: productsMain[currentIndex].typeInfo)
			}
			return cell
		default:
			return UITableViewCell()
		}
	}
}


// MARK: - IzolyatorMainViewControllable

extension IzolyatorMainViewController: IzolyatorMainViewControllable {

	func updateScreenWith(products: [ProductServiceModel.MainScreenProductModel]) {
		productsMain = products
		containerTableView.reloadData()
	}
}


// MARK: - ProductTableViewCellDelegate

extension IzolyatorMainViewController: ProductTableViewCellDelegate {
	func detectCurrentCellIndex(_ index: Int) {
		currentIndex = index
		containerTableView.reloadData()
	}

	func didSelectAlbum(position: Int) {
//		listener.didTapOnAlbumCard(position: position, vc: self, songs: albumsSongs[position])
	}
}

// MARK: - CollapsibleTableViewHeaderDelegate

extension IzolyatorMainViewController: CollapsibleTableViewHeaderDelegate {

	// https://github.com/jeantimex/ios-swift-collapsible-table-section
	func toggleSection(_ header: CollapsibleTableViewHeader, section: Int) {
//		let collapsed = !sections[section].collapsed
//		sections[section].collapsed = collapsed

		let collapsed = !productsMain[currentIndex].modelSectionCollapsed
		productsMain[currentIndex].modelSectionCollapsed = collapsed
		header.setCollapsed(collapsed)

		containerTableView.reloadSections(NSIndexSet(index: section) as IndexSet, with: .automatic)
	}
}

extension IzolyatorMainViewController: MultipleViewDelegate {

	func didTapLeftButton() {
		listener.didTapOnFullInfoButton()
	}

	func openArScene() {
		listener.didTapOnARButton()
	}
}

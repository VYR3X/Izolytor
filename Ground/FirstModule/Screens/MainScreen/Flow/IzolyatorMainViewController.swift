//
//  IzolyatorMainViewController.swift
//  Ground
//
//  Created by Vladislav Zhokhov on 27.11.2020.
//  Copyright © 2020 Splash Fire. All rights reserved.
//

import UIKit

/// Интерфейс взаимодействия с вью-контроллером экрана IzolyatorMainViewController.
protocol IzolyatorMainViewControllable: UIViewController {}


/// Листенер главного экрана приложения
protocol IzolyatorMainPresentableListener {

	func didLoad(_ viewController: IzolyatorMainViewControllable)

	func didTapOnButton()

	func didTapOnARButton()

	func didTapOnFullInfoButton()
}


/// Главный экран приложения с каруселью продуктов
final class IzolyatorMainViewController: UIViewController, IzolyatorMainViewControllable {

	var sections = sectionsData

	private struct Constants {
		static let productTableViewCellHeight: CGFloat = 400
		static let modelTableViewCellHeight: CGFloat = 45
		static let collapse: CGFloat = 100
		static let sectionsCount = 3
	}

	/// Секции для content table view 
	private enum Section: Int, CaseIterable {
		/// Карусель с продуктами
		case products = 0
		/// секиция выбора модели и типа высоковольтного ввода
		case models
		/// Информация о вводе
		case info
	}

	private let listener: IzolyatorMainPresentableListener

	private lazy var containerTableView: UITableView = {
		let tableView = UITableView()
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.register(ProductTableViewCell.self,
						   forCellReuseIdentifier: String(describing: ProductTableViewCell.self))
		tableView.register(CollapsibleTableViewCell.self,
						   forCellReuseIdentifier: String(describing: CollapsibleTableViewCell.self))
//		tableView.register(ProductModelTableViewCell.self,
//						   forCellReuseIdentifier: String(describing: ProductModelTableViewCell.self))
		tableView.register(ProductInfoTableViewCell.self,
						   forCellReuseIdentifier: String(describing: ProductInfoTableViewCell.self))
		tableView.delegate = self
		tableView.dataSource = self
		tableView.separatorStyle = .none
		tableView.backgroundColor = .white
		tableView.showsVerticalScrollIndicator = false
		return tableView
	}()

	private let multipleView = MultipleView()

	required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    init(listener: IzolyatorMainPresentableListener) {
        self.listener = listener
        super.init(nibName: nil, bundle: nil)
    }

	/// hide navigation bar
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.setNavigationBarHidden(true, animated: animated)
	}

	/// hide navigation bar
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		navigationController?.setNavigationBarHidden(false, animated: animated)
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		multipleView.delegate = self
		listener.didLoad(self)
		setupConstraints()
    }

	private func setupConstraints() {
		view.addSubview(containerTableView)
		containerTableView.addSubview(multipleView)

		NSLayoutConstraint.activate([
			containerTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
			containerTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
			containerTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			containerTableView.topAnchor.constraint(equalTo: view.topAnchor),

			multipleView.heightAnchor.constraint(equalToConstant: 45),
			multipleView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			multipleView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			multipleView.bottomAnchor.constraint(equalTo: view.safeBottomAnchor)
		])
	}

	/// Метод для воспроизведение следующей композиции
//	@objc func didTapButton() {
//		listener.didTapOnButton()
//	}
}


// MARK: - UITableViewDelegate

extension IzolyatorMainViewController: UITableViewDelegate {

	/// Выставили высоту для 1 и 3 ячейки в 0
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return section == 0 || section == 2 ? 0 : 45.0
	}

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		switch indexPath.section {
		case Section.products.rawValue:
			return Constants.productTableViewCellHeight // 400
		case Section.models.rawValue:
			return UITableView.automaticDimension
		case Section.info.rawValue:
			return Constants.productTableViewCellHeight // 400
		default:
			return 0
		}
	}

	/// Вью для секции ячеек
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as? CollapsibleTableViewHeader ?? CollapsibleTableViewHeader(reuseIdentifier: "header")

		header.titleLabel.text = "Models" //sections[section].name
		header.arrowLabel.text = ">"
		header.setCollapsed(sections[section].collapsed)

		header.section = section
		header.delegate = self

		return header
	}
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
		case Section.models.rawValue:
			return sections[section].collapsed ? 0 : sections[section].items.count
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
			cell.backgroundColor = LightPalette().color(.aqua)
			return cell
		case Section.models.rawValue:
			guard let cell = containerTableView.dequeueReusableCell(withIdentifier:
																		String(describing: CollapsibleTableViewCell.self), for: indexPath) as? CollapsibleTableViewCell else {
				return UITableViewCell()
			}
			let item: Item = sections[indexPath.section].items[indexPath.row]

			cell.nameLabel.text = item.name
			cell.detailLabel.text = item.detail

			return cell
		case Section.info.rawValue:
			guard let cell = containerTableView.dequeueReusableCell(withIdentifier:
																		String(describing: ProductInfoTableViewCell.self), for: indexPath) as? ProductInfoTableViewCell else {
				return UITableViewCell()
			}
			return cell
		default:
			return UITableViewCell()
		}
	}
}


// MARK: - ProductTableViewCellDelegate

extension IzolyatorMainViewController: ProductTableViewCellDelegate {
	func didSelectAlbum(position: Int) {
//		listener.didTapOnAlbumCard(position: position, vc: self, songs: albumsSongs[position])
	}
}

// MARK: - ProductModelTableViewCellDelegate

extension IzolyatorMainViewController: ProductModelTableViewCellDelegate {
	func addTableViewCell() {}
}

// MARK: - CollapsibleTableViewHeaderDelegate


extension IzolyatorMainViewController: CollapsibleTableViewHeaderDelegate {

	func toggleSection(_ header: CollapsibleTableViewHeader, section: Int) {
		let collapsed = !sections[section].collapsed
		// Toggle collapse
		sections[section].collapsed = collapsed
		header.setCollapsed(collapsed)

		containerTableView.reloadSections(NSIndexSet(index: section) as IndexSet, with: .automatic)
	}
	// https://github.com/jeantimex/ios-swift-collapsible-table-section
}

extension IzolyatorMainViewController: MultipleViewDelegate {

	func openFullInfoViewController() {
		listener.didTapOnFullInfoButton()
	}

	func openArScene() {
		listener.didTapOnARButton()
	}
}

//
//  YouTubeViewController.swift
//  Izolyator
//
//  Created by Vladislav Zhokhov on 21.01.2021.
//  Copyright © 2021 Splash Fire. All rights reserved.
//

import UIKit

/// Интерфейс взаимодействия с вью-контроллером экрана ProductDetailViewController.
protocol YouTubeViewControllable: UIViewController {}

protocol YouTubeViewControllerListener {

	func didLoad(_ viewController: ProductDetailViewControllable)

	func didTapOnTechInfoButton()

	func didTapOnArButton()

	func loadView()

	func didTapOnManualCell()
}

final class YouTubeViewController: UIViewController, YouTubeViewControllable {

	var sections = sectionsData

	private struct Constants {
		static let productTableViewCellHeight: CGFloat = 350
		static let rowHeight: CGFloat = 72
		static let modelTableViewCellHeight: CGFloat = 45
		static let collapse: CGFloat = 100
	}

	/// Секции для content table view
	private enum Section: Int, CaseIterable {
		/// Вью с YouTube плеером
		case youTubeSection
		/// Секция с каталогом моделей по выбранному типу ввода
		case productCatalogSection
		/// Секция c руководством
		case manualSection
		/// Секция с 3D моделью
		case arSection
	}

	private let listener: YouTubeViewControllerListener

	private lazy var containerTableView: UITableView = {
		let tableView = UITableView(frame: .zero, style: .plain)
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.register(YouTubeTableViewCell.self,
						   forCellReuseIdentifier: String(describing: YouTubeTableViewCell.self))
		tableView.register(CollapsibleTableViewCell.self,
						   forCellReuseIdentifier: String(describing: CollapsibleTableViewCell.self))
		tableView.delegate = self
		tableView.dataSource = self
		tableView.separatorStyle = .none
		tableView.backgroundColor = .white
		tableView.showsVerticalScrollIndicator = false
		return tableView
	}()

	// Create the navigation bar
	private lazy var navBar: UINavigationBar = {
		// Offset by 20 pixels vertically to take the status bar into account
		let navigationBar = UINavigationBar(frame: CGRect(x: 0,
														  y: 0,
														  width: self.view.frame.width,
														  height: 100))
		navigationBar.backgroundColor = .green
//		navigationBar.delegate = self;

		// Create a navigation item with a title
		let navigationItem = UINavigationItem()
		navigationItem.title = "Title"

		// Create left and right button for navigation item
		let leftButton =  UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(addTapped))
		let rightButton = UIBarButtonItem(title: "Right", style: .plain, target: self, action: nil)

		// Create two buttons for the navigation item
		navigationItem.leftBarButtonItem = leftButton
		navigationItem.rightBarButtonItem = rightButton

		// Assign the navigation item to the navigation bar
		navigationBar.items = [navigationItem]
		return navigationBar
	}()

	init(listener: YouTubeViewControllerListener) {
		self.listener = listener
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

	override func viewWillAppear(_ animated: Bool) {
//		super.viewWillAppear(animated)
//		self.navigationController?.navigationBar.prefersLargeTitles = false
//		navigationController?.navigationBar.barTintColor = .white
	}

	override func willMove(toParent parent: UIViewController?) {
		self.navigationController?.navigationBar.prefersLargeTitles = false
		self.navigationController?.navigationBar.tintColor = .white
		self.navigationController?.navigationBar.barTintColor = .blue
//		tabBarController?.tabBar.barTintColor = .white
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		setupConstraints()
//		setNavigationBar() // хз что за рофл но устанавливать бар нужно в последнюю очередь, а то будет странный оттенок
//		self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
	}

	private func setupConstraints() {
		view.addSubview(containerTableView)
		containerTableView.pinToSuperView()
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
		self.view.addSubview(navBar)
	}

	@objc func addTapped() {
		print("action button")
	}
}

// MARK: - UITableViewDelegate

extension YouTubeViewController: UITableViewDelegate {

	/// занулили секцию для кастомно вигационного бара
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 50.0
	}

	/// брали отступы между секциями и ячейками - смотри главный экран
	func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
		return .leastNormalMagnitude
	}

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		switch indexPath.section {
		case Section.youTubeSection.rawValue:
			return Constants.productTableViewCellHeight // 350
		case Section.productCatalogSection.rawValue:
			return Constants.rowHeight //UITableView.automaticDimension
		case Section.manualSection.rawValue:
			return Constants.rowHeight
		case Section.arSection.rawValue:
			return Constants.rowHeight
		default:
			return 0
		}
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		switch indexPath.section {
		case Section.youTubeSection.rawValue: break
		case Section.manualSection.rawValue:
			print("нажали на одну из ячеек секции руководства секции")
			listener.didTapOnManualCell()
		case Section.arSection.rawValue:
			print("нажали на ячейку секции AR")
			listener.didTapOnArButton()
		case Section.productCatalogSection.rawValue:
			print("нажали на одну из ячеек секции чертеж модели")
			listener.didTapOnTechInfoButton()
		default:
			break
		}
	}
}

// MARK: - UITableViewDataSource

extension YouTubeViewController: UITableViewDataSource {

	func numberOfSections(in tableView: UITableView) -> Int {
		return Section.allCases.count
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		switch section {
		case Section.youTubeSection.rawValue:
			return 1
		case Section.productCatalogSection.rawValue:
			return sections[section].collapsed ? 0 : 1 //sections[section].items.count
		case Section.arSection.rawValue:
			return sections[section].collapsed ? 0 : sections[section].items.count
		case Section.manualSection.rawValue:
			return sections[section].collapsed ? 0 : sections[section].items.count
		default:
			return 0
		}
	}

	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as? ManualHeaderView ?? ManualHeaderView(reuseIdentifier: "header")
		switch section {
		case Section.youTubeSection.rawValue:
			header.secionName.text = "Видео"
		case Section.productCatalogSection.rawValue:
			header.secionName.text = "Каталог моделей"
		case Section.manualSection.rawValue:
			header.secionName.text = "Руководство по эксплуатации"
		case Section.arSection.rawValue:
			header.secionName.text = "AR рендеринг"
		default:
			return header
		}
		header.section = section
		header.delegate = self
		header.setCollapsed(sections[section].collapsed)
		return header
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		switch indexPath.section {
		case Section.youTubeSection.rawValue:
			guard let cell = containerTableView.dequeueReusableCell(withIdentifier:
																		String(describing: YouTubeTableViewCell.self),
																	for: indexPath) as? YouTubeTableViewCell else {
				return UITableViewCell()
			}
			cell.delegate = self
			cell.backgroundColor = LightPalette().color(.aqua)
			return cell
		case Section.productCatalogSection.rawValue:
			guard let cell = containerTableView.dequeueReusableCell(withIdentifier:
																		String(describing: CollapsibleTableViewCell.self), for: indexPath) as? CollapsibleTableViewCell else {
				return UITableViewCell()
			}

//			let item: Item = sections[1].items[indexPath.row]
			cell.bind(title: "Открыть список вводов", subTitle: "Перейдите в каталог", iconName: "add")

			return cell
		case Section.manualSection.rawValue:
			guard let cell = containerTableView.dequeueReusableCell(withIdentifier:
																		String(describing: CollapsibleTableViewCell.self), for: indexPath) as? CollapsibleTableViewCell else {
				return UITableViewCell()
			}
			let item: Item = sections[2].items[indexPath.row]
			cell.bind(title: item.name, subTitle: item.detail, iconName: "add")

			return cell
		case Section.arSection.rawValue:
			guard let cell = containerTableView.dequeueReusableCell(withIdentifier:
																		String(describing: CollapsibleTableViewCell.self), for: indexPath) as? CollapsibleTableViewCell else {
				return UITableViewCell()
			}

			let item: Item = sections[3].items[indexPath.row]
			cell.bind(title: item.name, subTitle: item.detail, iconName: "add")

			return cell
		default:
			return UITableViewCell()
		}
	}
}


// MARK: - YouTubeTableViewCellDelegate

extension YouTubeViewController: YouTubeTableViewCellDelegate {

	func loadVideo() {
		listener.loadView()
	}
}

// MARK: - ManualHeaderViewDelegate

extension YouTubeViewController: ManualHeaderViewDelegate {

	func collapseSection(_ header: ManualHeaderView, section: Int) {
		let collapsed = !sections[section].collapsed
		// Toggle collapse
		sections[section].collapsed = collapsed
		header.setCollapsed(collapsed)

		containerTableView.reloadSections(NSIndexSet(index: section) as IndexSet, with: .automatic)
	}
}

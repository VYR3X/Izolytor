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

	func didTapOnYouTubeButton()

	func didTapOnArButton()

	func loadView()
}

final class YouTubeViewController: UIViewController, YouTubeViewControllable {

	var sections = sectionsData

	private struct Constants {
		static let productTableViewCellHeight: CGFloat = 400
		static let modelTableViewCellHeight: CGFloat = 45
		static let collapse: CGFloat = 100
		static let sectionsCount = 3
	}

	/// Секции для content table view
	private enum Section: Int, CaseIterable {
		/// Вью с YouTube плеером
		case youTubeSection = 0
		/// Секция со словестным описанием видео
//		case audioTextSection
		/// Секция с описанием монтажа ввода
		case monthagSection
	}

	private let listener: YouTubeViewControllerListener

	private lazy var containerTableView: UITableView = {
		let tableView = UITableView()
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

	private lazy var multipleView: MultipleView = {
		let view = MultipleView()
		view.productFullInfoLabel.text = "PDF чертеж"
		view.delegate = self
		return view
	}()

	/// hide navigation bar
//	override func viewWillAppear(_ animated: Bool) {
//		super.viewWillAppear(animated)
//		navigationController?.setNavigationBarHidden(true, animated: animated)
//	}

	/// hide navigation bar
//	override func viewWillDisappear(_ animated: Bool) {
//		super.viewWillDisappear(animated)
//		navigationController?.setNavigationBarHidden(false, animated: animated)
//	}

	init(listener: YouTubeViewControllerListener) {
		self.listener = listener
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

	override func viewDidLoad() {
		super.viewDidLoad()
		multipleView.delegate = self
//		listener.didLoad(self)
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
}

// MARK: - MultipleViewDelegate

extension YouTubeViewController: MultipleViewDelegate {

	func openFullInfoViewController() {
		listener.didTapOnYouTubeButton()
	}

	func openArScene() {
		listener.didTapOnArButton()
	}
}

// MARK: - UITableViewDelegate

extension YouTubeViewController: UITableViewDelegate {

	/// Выставили высоту для 1 ячейки в 0
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return section == 0 ? 0 : 45.0
	}

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		switch indexPath.section {
		case Section.youTubeSection.rawValue:
			return Constants.productTableViewCellHeight // 400
		case Section.monthagSection.rawValue:
			return UITableView.automaticDimension
		default:
			return 0
		}
	}

	/// Вью для секции ячеек
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as? CollapsibleTableViewHeader ?? CollapsibleTableViewHeader(reuseIdentifier: "header")

		header.typeLabel.text = "Руководство эксплуатации" //sections[section].name
//		header.arrowLabel.text = ">"
		header.setCollapsed(sections[section].collapsed)

		header.section = section
		header.delegate = self

		return header
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
		case Section.monthagSection.rawValue:
			return sections[section].collapsed ? 0 : sections[section].items.count
		default:
			return 0
		}
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		switch indexPath.section {
		case Section.youTubeSection.rawValue:
			guard let cell = containerTableView.dequeueReusableCell(withIdentifier:
																		String(describing: YouTubeTableViewCell.self),
																	for: indexPath) as? YouTubeTableViewCell else {
				return UITableViewCell()
			}
			cell.backgroundColor = LightPalette().color(.aqua)
			return cell
		case Section.monthagSection.rawValue:
			guard let cell = containerTableView.dequeueReusableCell(withIdentifier:
																		String(describing: CollapsibleTableViewCell.self), for: indexPath) as? CollapsibleTableViewCell else {
				return UITableViewCell()
			}
			let item: Item = sections[indexPath.section].items[indexPath.row]

			cell.typeLabel.text = item.name
			cell.detailLabel.text = item.detail

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

// MARK: - ProductModelTableViewCellDelegate

extension YouTubeViewController: ProductModelTableViewCellDelegate {
	func addTableViewCell() {}
}

// MARK: - CollapsibleTableViewHeaderDelegate


extension YouTubeViewController: CollapsibleTableViewHeaderDelegate {

	func toggleSection(_ header: CollapsibleTableViewHeader, section: Int) {
		let collapsed = !sections[section].collapsed
		// Toggle collapse
		sections[section].collapsed = collapsed
		header.setCollapsed(collapsed)

		containerTableView.reloadSections(NSIndexSet(index: section) as IndexSet, with: .automatic)
	}
	// https://github.com/jeantimex/ios-swift-collapsible-table-section

}

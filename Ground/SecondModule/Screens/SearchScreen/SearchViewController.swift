//
//  FirstScreenSMViewController.swift
//  Ground
//
//  Created by Vlad Zhokhov on 27.11.2020.
//  Copyright © 2020 Splash Fire. All rights reserved.
//

import UIKit

/// Интерфейс взаимодействия с вью-контроллером экрана FirstScreenSM.
protocol SearchViewControllable: UIViewController {}

protocol SearchPresentableListener {

	func didLoad(_ viewController: SearchViewControllable)

	func didTapOnButton()
}

// https://www.youtube.com/watch?v=4RyhnwIRjpA // пример с фильтрацией простого массива с эивотными
// https://stackoverflow.com/questions/57756260/how-can-i-use-a-searchbar-in-a-tableview-with-multiple-sections // фильтрация секций + код с github )

/// Экран поиска
final class SearchViewController: UIViewController, SearchViewControllable {

	private lazy var myTableView: UITableView = {
		let tableView = UITableView(frame: .zero, style: .plain)
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.delegate = self
		tableView.dataSource = self
		tableView.separatorStyle = .singleLine
		tableView.backgroundColor = UIColor.Pallete.lightBackground //.white
		tableView.showsVerticalScrollIndicator = false
		tableView.register(ProductListTableViewCell.self,
						   forCellReuseIdentifier: String(describing: ProductListTableViewCell.self))
		tableView.allowsSelection = false //  убрал выделение
		return tableView
	}()

	private lazy var searchBar: UISearchBar = {
		let searchBar = UISearchBar(frame: .zero)
		searchBar.delegate = self
		searchBar.sizeToFit()
		searchBar.searchBarStyle = .minimal
		searchBar.placeholder = "Search by model name"
		searchBar.tintColor = UIColor.lightGray
		searchBar.barTintColor = .white
		searchBar.isTranslucent = true
		return searchBar
	}()

	private let listener: SearchPresentableListener

	private var bushingArray = [CatalogModel.HighVoltageBushingModel]()
	private var currentBushingArray = [CatalogModel.HighVoltageBushingModel]()

	required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

	init(listener: SearchPresentableListener) {
		self.listener = listener
		super.init(nibName: nil, bundle: nil)
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		setUpAnimals()
		setupView()
		self.navigationController?.view.backgroundColor = .white
		hideKeyboardWhenTappedAround()
	}

	private func setUpAnimals() {
		bushingArray.append(
			CatalogModel.HighVoltageBushingModel(
				type: .transformer,
				voltageClassModels: [
					VoltageСlassModel(
						voltageName: "12kV",
						bushingModels: [
							FullBushingInfoModel(bushingName: "TCNSIV-90-12/1000 (0)",
												 drawing: "686381.279"),
							FullBushingInfoModel(bushingName: "TCNSIV-90-12/1000 (100)",
												 drawing: "686381.279-01"),
							FullBushingInfoModel(bushingName: "TCNSIV-90-12/1000 (200)",
												 drawing: "686381.279-02"),
							FullBushingInfoModel(bushingName: "TCNSIV-90-12/1000 (300)",
												 drawing: "686381.279-03"),
							FullBushingInfoModel(bushingName: "TCNSIV-90-12/1000 (400)",
												 drawing: "686381.279-04"),
							FullBushingInfoModel(bushingName: "TCNSIV-90-12/1000 (500)",
												 drawing: "686381.279-05"),
							FullBushingInfoModel(bushingName: "TCNSIV-90-12/1000 (600)",
												 drawing: "686381.279-06")
						]
					),
					VoltageСlassModel(
						voltageName: "24kV",
						bushingModels: [
							FullBushingInfoModel(bushingName: "TCNSIII-90-24/5000 (0)",
												 drawing: "686381.274"),
							FullBushingInfoModel(bushingName: "TCNSIII-90-24/5000 (100)",
												 drawing: "686381.274-01"),
							FullBushingInfoModel(bushingName: "TCNSIII-90-24/5000 (200)",
												 drawing: "686381.274-02"),
							FullBushingInfoModel(bushingName: "TCNSIII-90-24/5000 (300)",
												 drawing: "686381.274-03"),
							FullBushingInfoModel(bushingName: "TCNSIII-90-24/5000 (400)",
												 drawing: "686381.274-04")
						]
					),
					VoltageСlassModel(
						voltageName: "40,5kV",
						bushingModels: [
							FullBushingInfoModel(bushingName: "TCNPIII-60-40,5/3500",
												 drawing: "686381.154"),
							FullBushingInfoModel(bushingName: "TCNPIII-90-40,5/1000 (0)",
												 drawing: "686381.275"),
							FullBushingInfoModel(bushingName: "TCNPIII-90-40,5/1000 (200)",
												 drawing: "686381.275-01"),
							FullBushingInfoModel(bushingName: "TCNPIII-90-40,5/1000 (300)",
												 drawing: "686381.275-02"),
							FullBushingInfoModel(bushingName: "TCNPIII-90-40,5/1000 (400)",
												 drawing: "686381.275-03"),
							FullBushingInfoModel(bushingName: "TCNPIII-90-40,5/1000 (500)",
												 drawing: "686381.275-04"),
							FullBushingInfoModel(bushingName: "TCNPIII-90-40,5/1000 (600)",
												 drawing: "686381.275-05")
						]
					)
				]
			)
		)
		currentBushingArray = bushingArray
		}

	private func setupView() {
		self.view.backgroundColor = UIColor.white
//		title = "Каталог"
//		self.navigationController?.navigationBar.prefersLargeTitles = true

		let search = UISearchController(searchResultsController: nil)
//		self.navigationItem.searchController = search
		search.searchResultsUpdater = self

		view.addSubview(myTableView)
		myTableView.pinToSuperView()
		navigationItem.titleView = searchBar // search.searchBar//searchBar
	}
}

//MARK: - UITableViewDataSource, UITableViewDelegate

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 65
	}

	func numberOfSections(in tableView: UITableView) -> Int {
		return currentBushingArray[0].voltageClassModels.count
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return currentBushingArray[0].voltageClassModels[section].bushingModels.count
	}

	// Create a standard header that includes the returned text.
	func tableView(_ tableView: UITableView, titleForHeaderInSection
								section: Int) -> String? {
		if currentBushingArray[0].voltageClassModels[section].voltageName == "" {
			return "Найденные модели"
		} else {
			return "Класс напряжения \(currentBushingArray[0].voltageClassModels[section].voltageName)"
		}
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = myTableView.dequeueReusableCell(withIdentifier:
																	String(describing: ProductListTableViewCell.self), for: indexPath) as? ProductListTableViewCell else {
			return UITableViewCell()
		}
		cell.backgroundColor = .clear
		cell.detailLabel.text = currentBushingArray[0].voltageClassModels[indexPath.section].bushingModels[indexPath.row].drawing
		cell.typeLabel.text = currentBushingArray[0].voltageClassModels[indexPath.section].bushingModels[indexPath.row].bushingName
		return cell
	}

}

// MARK: - UISearchBarDelegate

// переделал этот поиск под свои структуры )
// https://stackoverflow.com/questions/57756260/how-can-i-use-a-searchbar-in-a-tableview-with-multiple-sections // фильтрация секций + код с github )
extension SearchViewController: UISearchBarDelegate {

	// Search Bar
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

		if searchText == "" {
			currentBushingArray = bushingArray
			self.myTableView.reloadData()
			return
		}

		// новый массив для отображения
		var filteredDataSource: [CatalogModel.HighVoltageBushingModel] = []
		// отфильтрованные поля с информацией о вводе
		var fullInfo: [FullBushingInfoModel] = []

		// фильтруем по наименование ввода: TCNSIV-90-12/1000 (0)
		for voltage in bushingArray[0].voltageClassModels {
			let bushingModel = voltage.bushingModels.filter { (item) -> Bool in
				// условие выбора по введенному названию
				item.bushingName.contains(searchText) ? true : false
			}
			fullInfo.append(contentsOf: bushingModel)
		}

		// собираю новый массив уже отфильтрованный
		// по сути теперь у нас одна секция VoltageСlassModel и отфильтрованный массив найденных моделей fullInfo
		filteredDataSource.append(
			CatalogModel.HighVoltageBushingModel(
				type: .transformer,
				voltageClassModels: [
					VoltageСlassModel(
						voltageName: "",
						bushingModels: fullInfo
					)
				]
			)
		)

		// обновляю контент
		self.currentBushingArray = filteredDataSource
		myTableView.reloadData()
	}

	func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
		bushingArray = currentBushingArray
		myTableView.reloadData()
	}
}

// MARK: - UISearchResultsUpdating // для search controller
extension SearchViewController: UISearchResultsUpdating {
	// https://pavelgnatyuk.medium.com/large-title-and-search-in-ios-11-514d5e020cee

	func updateSearchResults(for searchController: UISearchController) {
//		if let text = searchController.searchBar.text, !text.isEmpty {
//			self.filtered = self.countries.filter({ (country) -> Bool in
//				return country.lowercased().contains(text.lowercased())
//			})
//			self.filterring = true
//		}
//		else {
//			self.filterring = false
//			self.filtered = [String]()
//		}
//		self.table.reloadData()

		// новый массив для отображения
		var filteredDataSource: [CatalogModel.HighVoltageBushingModel] = []
		// отфильтрованные поля с информацией о вводе
		var fullInfo: [FullBushingInfoModel] = []

		if let searchText = searchController.searchBar.text, searchText.isEmpty {
			currentBushingArray = bushingArray
			self.myTableView.reloadData()
			return
		} else {
			// фильтруем по наименование ввода: TCNSIV-90-12/1000 (0)
			for voltage in bushingArray[0].voltageClassModels {
				let bushingModel = voltage.bushingModels.filter { (item) -> Bool in
					// условие выбора по введенному названию
					item.bushingName.contains(searchController.searchBar.text!) ? true : false
				}
				fullInfo.append(contentsOf: bushingModel)
			}

			// собираю новый массив уже отфильтрованный
			// по сути теперь у нас одна секция VoltageСlassModel и отфильтрованный массив найденных моделей fullInfo
			filteredDataSource.append(
				CatalogModel.HighVoltageBushingModel(
					type: .transformer,
					voltageClassModels: [
						VoltageСlassModel(
							voltageName: "",
							bushingModels: fullInfo
						)
					]
				)
			)
		}

		// обновляю контент
		self.currentBushingArray = filteredDataSource
		myTableView.reloadData()
	}

}


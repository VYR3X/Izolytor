//
//  PaginationCollectionView.swift
//  Izolyator
//
//  Created by Vladislav Zhokhov on 12.01.2021.
//  Copyright © 2021 Splash Fire. All rights reserved.
//

import UIKit

/// Кастомный коллектион вью с пагинацией
final class PaginationCollectionView: UIView {

	/// Делегат ячейки продуктов
	var delegate: ProductTableViewCellDelegate?

	//	private let cellWight = ( 3 / 4 ) * UIScreen.main.bounds.width
	//	private let spacing = ( 1 / 8 ) * UIScreen.main.bounds.width // отступы для layout
	//	private let cellSpacing = ( 1 / 16 ) * UIScreen.main.bounds.width // отступ между ячейками

	private let cellWight = UIScreen.main.bounds.width

	private var dataSource: [ProductServiceModel.MainScreenProductModel] = []

	private lazy var mainCollectionView: UICollectionView = {
		let layout = PagingCollectionViewLayout()
		// Версия со сдвигом layout
		//	layout.sectionInset = .init(top: 0, left: spacing, bottom: 0, right: spacing)
		//	layout.minimumLineSpacing = cellSpacing
		// Ячейка на весь экран
		layout.sectionInset = .init(top: 0, left: 0, bottom: 0, right: 0)
		layout.minimumLineSpacing = 0

		layout.itemSize = .init(width: cellWight, height: cellWight)
		layout.scrollDirection = .horizontal

		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		collectionView.showsHorizontalScrollIndicator = false
		collectionView.decelerationRate = .fast
		collectionView.dataSource = self
		collectionView.delegate = self
		collectionView.backgroundColor = .clear
		collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")

		return collectionView
	}()

	private lazy var bottomPageControl: UIPageControl = {
		let controll = UIPageControl()
		controll.translatesAutoresizingMaskIntoConstraints = false
		controll.backgroundColor = .clear //LightPalette().color(.aqua)
		controll.currentPageIndicatorTintColor = .blue//LightPalette().color(.darkBlue)
		controll.pageIndicatorTintColor = .systemBlue//LightPalette().color(.lightBlue)
//		controll.numberOfPages = dataSource.count
		controll.currentPage = 0
		return controll
	}()

	required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

	override init(frame: CGRect) {
		super.init(frame: .zero)
		self.translatesAutoresizingMaskIntoConstraints = false
		self.backgroundColor = .white //LightPalette().color(.lightBlue)
		setupConstraints()
	}

	func updateCollectionView(source: [ProductServiceModel.MainScreenProductModel]) {
		dataSource = source
		mainCollectionView.reloadData()
	}

	private func setupConstraints() {
		addSubviews(mainCollectionView, bottomPageControl)

		NSLayoutConstraint.activate([
			mainCollectionView.topAnchor.constraint(equalTo: topAnchor),
			mainCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
			mainCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
			mainCollectionView.bottomAnchor.constraint(equalTo: bottomPageControl.topAnchor, constant: -5),

			bottomPageControl.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
			bottomPageControl.centerXAnchor.constraint(equalTo: centerXAnchor)
		])
	}
}

// MARK: - UICollectionViewDataSource

extension PaginationCollectionView: UICollectionViewDataSource {

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		bottomPageControl.numberOfPages = dataSource.count
		let count = dataSource.count
		bottomPageControl.isHidden = !(count > 1)
		return count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)

		let imageView = UIImageView(frame: .init(x: 0, y: 0, width: cellWight, height: cellWight))
		imageView.image = UIImage(named: "bushingImage")
		imageView.contentMode = .scaleAspectFit

		cell.addSubview(imageView)
		cell.clipsToBounds = true

		return cell
	}
}

// MARK: - UICollectionViewDelegate

extension PaginationCollectionView: UICollectionViewDelegate {

	// https://stackoverflow.com/questions/40975302/how-to-add-pagecontrol-inside-uicollectionview-image-scrolling
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		let offSet = scrollView.contentOffset.x
		let width = scrollView.frame.width
		let horizontalCenter = width / 2
		let index = Int(offSet + horizontalCenter) / Int(width)

		bottomPageControl.currentPage = index
		delegate?.detectCurrentCellIndex(index)
	}

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		print("Выбрали Высоковольтный ввод под номером: \(indexPath.row + 1)")
	}
}

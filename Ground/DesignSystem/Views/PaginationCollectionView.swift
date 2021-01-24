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

	private var dataSource: [ProductServiceModel.MainScreenProductType] = []

	private lazy var mainCollectionView: UICollectionView = {
		let layout = PagingCollectionViewLayout()
		// версия со сдвигом layout
//		layout.sectionInset = .init(top: 0, left: spacing, bottom: 0, right: spacing)
//		layout.minimumLineSpacing = cellSpacing
		// ячейка на весь экран лайаут не двигается
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

	private let stackView: UIStackView = {
		let stackView = UIStackView()
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.spacing = 15
		stackView.distribution = .fill
		stackView.axis = .vertical
		return stackView
	}()

	override init(frame: CGRect) {
		super.init(frame: .zero)
		self.translatesAutoresizingMaskIntoConstraints = false
		self.backgroundColor = .white //LightPalette().color(.lightBlue)
		setupConstraints()
	}

	required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

	func updateCollectionView(source: [ProductServiceModel.MainScreenProductType]) {
		dataSource = source
		mainCollectionView.reloadData()
	}

	private func setupConstraints() {
//		stackView.addArrangedSubviews(mainCollectionView, bottomPageControl)
		addSubviews(mainCollectionView, bottomPageControl)

		NSLayoutConstraint.activate([
//			stackView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
//			stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
//			stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
//			stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)

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
		imageView.image = UIImage(named: "imageTest")
//		imageView.contentMode = .scaleAspectFit

		cell.addSubview(imageView)
		cell.clipsToBounds = true

		return cell
	}
	//	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
	//
	//		guard let cell = albumsCollectionView.dequeueReusableCell(withReuseIdentifier:
	//			String(describing: ProductCollectionViewCell.self), for: indexPath) as? ProductCollectionViewCell else {
	//				return UICollectionViewCell()
	//		}
	//
	//		//cell.trailerImageView.image = UIImage(named: albumsSongs[indexPath.row][0].imageName)
	//		cell.trailerImageView.image = UIImage(named: albumImageNames[indexPath.row])
	//
	//		cell.titleLabel.text = albumsSongs[indexPath.row][0].albumName
	//		cell.subtitleLabel.text = albumsSongs[indexPath.row][0].artistName
	//
	//		cell.layer.cornerRadius = 25
	//		return cell
	//	}
}

// MARK: - UICollectionViewDelegate

extension PaginationCollectionView: UICollectionViewDelegate {

	func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
		let index = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
		bottomPageControl.currentPage = index
		delegate?.detectCurrentCellIndex(index)
	}

	func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
		bottomPageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
	}

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		print("Выбрали Высоковольтный ввод под номером: \(indexPath.row + 1)")
		delegate?.didSelectAlbum(position: indexPath.row)
	}
}

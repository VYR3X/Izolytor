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
}


/// Главный экран приложения с каруселью продуктов
final class IzolyatorMainViewController: UIViewController, IzolyatorMainViewControllable {

//	private let cellWight = ( 3 / 4 ) * UIScreen.main.bounds.width
//	private let spacing = ( 1 / 8 ) * UIScreen.main.bounds.width
//	private let cellSpacing = ( 1 / 16 ) * UIScreen.main.bounds.width
	private let cellWight = UIScreen.main.bounds.width
    private let listener: IzolyatorMainPresentableListener
	private var datasource: [Int] = [1, 2, 3, 4, 5]

	private lazy var pageControl: UIPageControl = {
		let controll = UIPageControl()
		controll.translatesAutoresizingMaskIntoConstraints = false
		controll.numberOfPages = datasource.count
		controll.currentPage = 0
		return controll
	}()

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
		collectionView.backgroundColor = .systemIndigo
		collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")

		return collectionView
	}()

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
		listener.didLoad(self)
		view.backgroundColor = .red
		setupConstraints()
    }

	private func setupConstraints() {
		view.addSubviews(mainCollectionView, pageControl)

		NSLayoutConstraint.activate([
			mainCollectionView.heightAnchor.constraint(equalToConstant: cellWight),
			mainCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
			mainCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			mainCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

			pageControl.heightAnchor.constraint(equalToConstant: 15),
			pageControl.topAnchor.constraint(equalTo: mainCollectionView.bottomAnchor, constant: 15),
			pageControl.centerXAnchor.constraint(equalTo: mainCollectionView.centerXAnchor)
		])
	}

	/// Метод для воспроизведение следующей композиции
	@objc func didTapButton() {
		listener.didTapOnButton()
	}
}

// MARK: - UICollectionViewDelegate

extension IzolyatorMainViewController: UICollectionViewDelegate {

	func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
		pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
	}

	func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
		pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
	}
}

// MARK: - UICollectionViewDataSource

extension IzolyatorMainViewController: UICollectionViewDataSource {

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		let count = datasource.count
		pageControl.isHidden = !(count > 1)
		return count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
		cell.backgroundColor = .green

		let imageView = UIImageView(frame: .init(x: 0, y: 0, width: cellWight, height: cellWight))
		imageView.image = UIImage(named: "imageTest")
//		imageView.contentMode = .scaleAspectFit

		cell.addSubview(imageView)
		cell.clipsToBounds = true

		return cell
	}
}

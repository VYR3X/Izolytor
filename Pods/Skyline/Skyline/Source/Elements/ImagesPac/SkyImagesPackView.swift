//
//  SkyImagesPackView.swift
//  Skyline
//
//  Created by 17790204 on 10.05.2021.
//

import UIKit

/// Вьюха, отображающая набор картинок
//@objc(GCKImagesPackView)
public final class SkyImagesPackView: UIView {

	/// Когнфигурация
	public let sky: SkyImagesPackViewConfiguration<SkyImagesPackView>

	/// Лэйбл отображающий счетчик дополнительных картинок
	public private(set) lazy var counterLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textAlignment = .center
		label.textColor = .black
		return label
	}()

	/// Текущие имэйдж вьюхи
	private(set) var imageViews = [UIImageView]()

	/// Констрэйнты, обеспечивающие налезание картинок друг на друга
	private(set) var overlayConstraints = NSHashTable<NSLayoutConstraint>.weakObjects()

	/// Инициализатор
	///
	/// - Parameters:
	///   - style: стиль
	init() {
		sky = SkyImagesPackViewConfiguration()
		super.init(frame: .zero)
		sky.owner = self
		addCountertLabel()
	}

	@available(*, unavailable)
	required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
	@available(*, unavailable)
	public override init(frame: CGRect) { fatalError("init(frame:) has not been implemented") }

	/// Размер контента
	public override var intrinsicContentSize: CGSize {
		let overlaysNumber = CGFloat(sky.pictures.isEmpty ? 0 : sky.pictures.count - 1)
		let allImageViewsWidth = CGFloat(sky.pictures.count) * sky.imageSide
		let allOverlays = overlaysNumber * sky.imagesOverlay
		return CGSize(width: allImageViewsWidth - allOverlays, height: sky.imageSide)
	}

	/// Удалить имэйдж вьюхи
	///
	/// - Parameters:
	///   - count: количество вьюх для удаления
	func removeImageViews(count: Int) {
		removeSubviews(imageViews.suffix(count), animationOptions: .transitionCrossDissolve, completion: { _ in
			self.invalidateIntrinsicContentSize()
		})
		imageViews.removeLast(count)
	}

	/// Добавить имэйлж вьюхи
	///
	/// - Parameters:
	///   - count: количество вьюх для добавления
	func addNewImageViews(count: Int) {
		UIView.animate(withDuration: CATransaction.animationDuration()) {
			self.invalidateIntrinsicContentSize()
		}
		makeImageViews(count: count).forEach { imageView in
			self.addSubview(imageView, animationOptions: .transitionCrossDissolve)
			imageView.makeSquare(side: sky.imageSide)
			NSLayoutConstraint.activate([
				self.centerYAnchor.constraint(equalTo: imageView.centerYAnchor)
			])
			if let lastView = imageViews.last {
				let constraint = lastView.trailingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: sky.imagesOverlay)
				self.overlayConstraints.add(constraint)
				constraint.isActive = true
			} else {
				imageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
			}
			imageViews.append(imageView)
		}
	}

	/// Создание имэйдж вьюх
	///
	/// - Parameters:
	///   - count: количество вьюх для создания
	/// - Returns: массив имэйдж вьюх
	private func makeImageViews(count: Int) -> [UIImageView] {
		return (0..<count).map { _ in
			let imageView = UIImageView()
			imageView.layer.cornerRadius = 20
			imageView.contentMode = .scaleAspectFill
			return imageView
		}
	}

	/// Добавление надписи с счетчиком в иерархию
	private func addCountertLabel() {
		addSubview(counterLabel)
		NSLayoutConstraint.activate([
			counterLabel.heightAnchor.constraint(equalTo: heightAnchor),
			counterLabel.widthAnchor.constraint(equalTo: heightAnchor),
			counterLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
			counterLabel.trailingAnchor.constraint(equalTo: trailingAnchor)])
	}
}

/// Для создания извне
public extension SkyImagesPackView {}

extension UIView {

	/// Анимированное добавление сабвью
	func addSubview(_ subview: UIView, animationOptions: UIView.AnimationOptions, completion: ((Bool) -> Void)? = nil) {
		UIView.transition(with: self,
						  duration: CATransaction.animationDuration(),
						  options: animationOptions,
						  animations: {
			self.addSubview(subview) },
						  completion: completion)
	}

	/// Анимированное удаление сабвью
	func removeSubviews(_ subviews: [UIView], animationOptions: UIView.AnimationOptions, completion: ((Bool) -> Void)? = nil) {
		UIView.transition(with: self,
						  duration: CATransaction.animationDuration(),
						  options: animationOptions,
						  animations: {
			subviews.forEach { $0.removeFromSuperview() }},
						  completion: completion)
	}
}


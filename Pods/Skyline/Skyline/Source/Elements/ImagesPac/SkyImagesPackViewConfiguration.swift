//
//  SkyImagesPackViewConfiguration.swift
//  Skyline
//
//  Created by 17790204 on 10.05.2021.
//

import UIKit

/// Конфигурация вью с набором картинок
public final class SkyImagesPackViewConfiguration<Type: SkyImagesPackView>: SkyViewConfiguration<Type> {

	/// Константы значений по умалчанию
	private struct Constants {

		/// Высота по умалчанию
		static var defaultHeight: CGFloat { return 24 }
		/// Величина налезания картинок друг на друга
		static var defaultOverlay: CGFloat { return 8 }
	}

	/// Текущие картинки
	public var pictures: [UIImage] = [] {
		didSet {
			let diff = oldValue.count - pictures.count
			if diff > 0 {
				owner?.removeImageViews(count: diff)
			} else if diff < 0 {
				owner?.addNewImageViews(count: -diff)
			}
//			owner?.imageViews.enumerated().forEach { $0.element.g.picture = pictures[$0.offset] }
//			retrigger(self, \.plusCounterValue)
		}
	}

	/// Величина размера картинки
	public var imageSide: CGFloat = Constants.defaultHeight {
		didSet {
			let oldValue = pictures
			pictures = []
			pictures = oldValue
		}
	}

	/// Величина нелезания картинок друг на друга
	public var imagesOverlay: CGFloat = Constants.defaultOverlay {
		didSet {
			owner?.overlayConstraints.allObjects.forEach { $0.constant = imagesOverlay }
		}
	}

	/// Значение дополнительных, неотображенных картинок
	public var plusCounterValue: Int = 0 {
		didSet {
			if oldValue == plusCounterValue {
				return
			}
//			owner?.imageViews.forEach { $0.g.overlay.state = .inactive }
			owner?.counterLabel.isHidden = plusCounterValue == 0 && !pictures.isEmpty
			if plusCounterValue != 0 && !pictures.isEmpty, let label = owner?.counterLabel {
//				owner?.imageViews.last?.g.overlay.state = .aboveAll
				owner?.bringSubviewToFront(label)
				label.text = "+" + String(plusCounterValue)
			}
		}
	}
}


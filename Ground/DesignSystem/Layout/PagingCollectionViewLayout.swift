//
//  PagingCollectionViewLayout.swift
//  Izolyator
//
//  Created by Vladislav Zhokhov on 10.01.2021.
//  Copyright © 2021 Splash Fire. All rights reserved.
//
import UIKit

/// Лайаут для центрирования ячеек при скроллинге коллектион вью
final class PagingCollectionViewLayout: UICollectionViewFlowLayout {

	var theVelocityThresholdPerPage: CGFloat = 2
	var numOfItemsPerPage: CGFloat = 1

	override func targetContentOffset(
		forProposedContentOffset proposedContentOffset: CGPoint,
		withScrollingVelocity velocity: CGPoint
	) -> CGPoint {

		guard let collectionView = collectionView else { return proposedContentOffset }

		let pageLength: CGFloat
		let approxPage: CGFloat
		let currentPage: CGFloat
		let speed: CGFloat

		if scrollDirection == .horizontal {
			pageLength = (self.itemSize.width + self.minimumLineSpacing) * numOfItemsPerPage
			approxPage = collectionView.contentOffset.x / pageLength
			speed = velocity.x
		} else {
			pageLength = (self.itemSize.height + self.minimumLineSpacing) * numOfItemsPerPage
			approxPage = collectionView.contentOffset.y / pageLength
			speed = velocity.y
		}

		if speed < 0 {
			currentPage = ceil(approxPage)
		} else if speed > 0 {
			currentPage = floor(approxPage)
		} else {
			currentPage = round(approxPage)
		}

		guard speed != 0 else {
			if scrollDirection == .horizontal {
				return CGPoint(x: currentPage * pageLength, y: 0)
			} else {
				return CGPoint(x: 0, y: currentPage * pageLength)
			}
		}

		var nextPage: CGFloat = currentPage + (speed > 0 ? 1 : -1)

		let increment = speed / theVelocityThresholdPerPage
		nextPage += (speed < 0) ? ceil(increment) : floor(increment)

		if scrollDirection == .horizontal {
			return CGPoint(x: nextPage * pageLength, y: 0)
		} else {
			return CGPoint(x: 0, y: nextPage * pageLength)
		}
	}
}

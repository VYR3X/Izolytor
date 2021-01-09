//
//  NSLayoutAnchor+extensions.swift
//  Izolyator
//
//  Created by 17790204 on 03.01.2021.
//  Copyright © 2021 Splash Fire. All rights reserved.
//

import UIKit

/// Лэйаут
let defaultLayout = DefaultLayout()

// MARK: - Gap
public extension NSLayoutAnchor {
	@objc func constraint(equalTo anchor: NSLayoutAnchor<AnchorType>, gap: Gap) -> NSLayoutConstraint {
		constraint(equalTo: anchor, constant: value(from: gap))
	}

	@objc func constraint(greaterThanOrEqualTo anchor: NSLayoutAnchor<AnchorType>, gap: Gap) -> NSLayoutConstraint {
		constraint(greaterThanOrEqualTo: anchor, constant: value(from: gap))
	}

	@objc func constraint(lessThanOrEqualTo anchor: NSLayoutAnchor<AnchorType>, gap: Gap) -> NSLayoutConstraint {
		constraint(lessThanOrEqualTo: anchor, constant: value(from: gap))
	}
}

// MARK: - Padding
// MARK: Horizontal
public extension NSLayoutAnchor where AnchorType == NSLayoutXAxisAnchor {
	func constraint(equalTo anchor: NSLayoutAnchor, padding: Padding.Horizontal) -> NSLayoutConstraint {
		constraint(equalTo: anchor, constant: value(from: padding))
	}

	func constraint(greaterThanOrEqualTo anchor: NSLayoutAnchor, padding: Padding.Horizontal) -> NSLayoutConstraint {
		constraint(greaterThanOrEqualTo: anchor, constant: value(from: padding))
	}

	func constraint(lessThanOrEqualTo anchor: NSLayoutAnchor, padding: Padding.Horizontal) -> NSLayoutConstraint {
		constraint(lessThanOrEqualTo: anchor, constant: value(from: padding))
	}
}

// MARK: Vertical
public extension NSLayoutAnchor where AnchorType == NSLayoutYAxisAnchor {
	func constraint(equalTo anchor: NSLayoutAnchor, padding: Padding.Vertical) -> NSLayoutConstraint {
		constraint(equalTo: anchor, constant: value(from: padding))
	}

	func constraint(greaterThanOrEqualTo anchor: NSLayoutAnchor, padding: Padding.Vertical) -> NSLayoutConstraint {
		constraint(greaterThanOrEqualTo: anchor, constant: value(from: padding))
	}

	func constraint(lessThanOrEqualTo anchor: NSLayoutAnchor, padding: Padding.Vertical) -> NSLayoutConstraint {
		constraint(lessThanOrEqualTo: anchor, constant: value(from: padding))
	}
}

// MARK: - Margin
public extension NSLayoutAnchor {
	@objc func constraint(equalTo anchor: NSLayoutAnchor<AnchorType>, margin: Margin) -> NSLayoutConstraint {
		constraint(equalTo: anchor, constant: value(from: margin))
	}

	@objc func constraint(greaterThanOrEqualTo anchor: NSLayoutAnchor<AnchorType>, margin: Margin) -> NSLayoutConstraint {
		constraint(greaterThanOrEqualTo: anchor, constant: value(from: margin))
	}

	@objc func constraint(lessThanOrEqualTo anchor: NSLayoutAnchor<AnchorType>, margin: Margin) -> NSLayoutConstraint {
		constraint(lessThanOrEqualTo: anchor, constant: value(from: margin))
	}
}

// MARK: - Вспомогательная сущность
private extension NSObject {
	func value(from gap: Gap) -> CGFloat {
		defaultLayout.value(gap: gap)
	}

	func value(from padding: Padding.Horizontal) -> CGFloat {
		defaultLayout.value(horizontalPadding: padding)
	}

	func value(from padding: Padding.Vertical) -> CGFloat {
		defaultLayout.value(verticalPadding: padding)
	}

	func value(from margin: Margin) -> CGFloat {
		defaultLayout.value(margin: margin)
	}
}

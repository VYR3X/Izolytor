//
//  SkySeparatorView.swift
//  Skyline
//
//  Created by Vladislav Zhokhov on 04.05.2021.
//

import CoreGraphics
import UIKit

/// Разделитель
public final class SkySeparatorView: UIView {

	private enum Constants {
		static let height: CGFloat = 0.5
	}

//	init(style: GStyle) {
//		super.init(style: style)
//		setup()
//	}

	public init() {
		super.init(frame: .zero)
		translatesAutoresizingMaskIntoConstraints = false
		setup()
	}

	required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

	private func setup() {
		self.backgroundColor = .gray
//		self.backgroundColor = .lentaQuaternaryDark
		self.heightAnchor.constraint(equalToConstant: Constants.height).isActive = true
//		heightAnchor.constraint(equalToConstant: Constants.height).activate()
	}
}


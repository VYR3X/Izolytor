//
//  SkySwitchConfiguration.swift
//  Skyline
//
//  Created by 17790204 on 05.05.2021.
//

import UIKit

/// Конфигурация GSwitch
public class SkySwitchConfiguration<Type: SkySwitch>: SkyControlConfiguration<Type> {

	public var isOn: Bool = false {
		didSet {
			if owner?.isOn != isOn {
				owner?.isOn = isOn
			}
		}
	}

//	func setOn(_ isOn: Bool, animated: Bool) {
//		guard self.isOn != isOn else { return }
//		owner?.setOn(isOn, animated: animated)
//		self.isOn = isOn
//	}

	// MARK: - UI setup

	public var onTintColor: Color = .generalBrand {
		didSet {
			owner?.onTintColor = LightPalette().color(onTintColor) //palette.color(onTintColor)
		}
	}

	/// Цвет для круглового тумблера на переключателе 
	public var thumbTintColor: Color = .backgroundDefault {
		didSet {
			owner?.thumbTintColor = LightPalette().color(thumbTintColor)//palette.color(thumbTintColor)
		}
	}

	public var onPicture: UIImage? {
		didSet {
//			if let picture = onPicture {
//				switch picture {
//				case .logo: break
//				case .icon(_, let color):
//					tintColor = color
//				}
//			}
//			owner?.onImage = onPicture?.image
		}
	}

	public var offPicture: UIImage? {
		didSet {
//			if let picture = offPicture {
//				switch picture {
//				case .logo: break
//				case .icon(_, let color):
//					tintColor = color
//				}
//			}
//			owner?.onImage = offPicture?.image
		}
	}

//	override func configureOwner() {
//		super.configureOwner()
//
//		retrigger(self, \.onTintColor)
//		retrigger(self, \.thumbTintColor)
//		retrigger(self, \.onPicture)
//		retrigger(self, \.offPicture)
//
//		addHandler(for: .valueChanged) { [weak self] in
//			self?.isOn = self?.owner?.isOn ?? false
//		}
//	}
}


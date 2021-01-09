//
//  NSLayoutConstraint.swift
//  Izolyator
//
//  Created by 17790204 on 03.01.2021.
//  Copyright © 2021 Splash Fire. All rights reserved.
//

import UIKit

public extension NSLayoutConstraint {

	/// Констрэинт с константой, умноженнной на -1
	var reverse: NSLayoutConstraint {
		constant = -1 * constant
		return self
	}

	/// Констрэинт с удвоенной константой,
	var double: NSLayoutConstraint {
		constant = 2 * constant
		return self
	}
}

//
//  UIViewController.swift
//  Izolyator
//
//  Created by 17790204 on 31.01.2021.
//  Copyright © 2021 Splash Fire. All rights reserved.
//

import UIKit

// https://stackoverflow.com/questions/29925373/how-to-make-keyboard-dismiss-when-i-press-out-of-searchbar-on-swift

extension UIViewController {

	/// Метод для скрытия клавиатуры при нажатии на экран
	func hideKeyboardWhenTappedAround() {
		let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard(_:)))
		tap.cancelsTouchesInView = false
		view.addGestureRecognizer(tap)
	}

	@objc func dismissKeyboard(_ sender: UITapGestureRecognizer) {
		view.endEditing(true)

		if let nav = self.navigationController {
			nav.view.endEditing(true)
		}
	}
 }

//
//  SkyBaseButtonConfiguration.swift
//  Skyline
//
//  Created by 17790204 on 06.05.2021.
//

import UIKit

/// Размер кнопки
///
/// - large: большой
/// - medium: средний
public enum SkyButtonSize {
	case large
	case medium

	// Высота кнопки
	public var height: CGFloat {
		switch self {
		case .large: return 44
		case .medium: return 36
		}
	}
}

/// Базовая конфигурация кнопки
public class SkyBaseButtonConfiguration<Type: UIControl, FinalType: AnyObject>: SkyControlConfiguration<Type> {

	/// Режим работы кнопки
	///
	/// - spring: Режим пружинки. При touchDown состояние становится selected при touchUp - default
	/// - sticky: Липкий режим. Состояния меняются поочередно при touchDown.
	/// - custom: Внутренней смены состояний не происходит.
	public enum Mode {
		case spring
		case sticky
		case custom
	}

	/// Декоратор состояний
	public let stater: SkyStateDecorator<FinalType, SkyControlState>

	/// Режим кнопки
	public var mode: Mode = .spring

	/// Размер кнопки
	public var size: SkyButtonSize = .large

	public override var isEnabled: Bool {
		didSet {
			owner?.isEnabled = isEnabled
			if isEnabled, stater.state == .disabled {
				let isPreviousValid = stater.previousState != .disabled && stater.previousState != .pressed
				let target: SkyControlState = isPreviousValid ? stater.previousState : .default
				tryUpdate(to: target)
			}
			if !isEnabled, stater.state != .disabled {
				tryUpdate(to: .disabled)
			}
		}
	}

	public var canBecomeDeselectedHandler: (() -> Bool)?

	/// Конструктор
	/// - Parameters:
	///   - stater: декоратор состояний
	init(stater: SkyStateDecorator<FinalType, SkyControlState>) {
		self.stater = stater
		super.init()
	}

	override func configureOwner() {
		super.configureOwner()

		owner?.accessibilityTraits = .button

		addHandler(for: .touchDown, handler: { [weak self] in self?.buttonDidTouchDown() })
		addHandler(for: .touchUpInside, handler: { [weak self] in self?.buttonDidTouchUp() })
		addHandler(for: .touchUpOutside, .touchCancel, handler: { [weak self] in self?.buttonDidCancelTouch() })
	}

	private func buttonDidTouchDown() {
		let state: SkyControlState
		switch mode {
		case .spring, .sticky: state = .pressed
		case .custom: return
		}
		tryUpdate(to: state)
	}

	private func buttonDidTouchUp() {
		let state: SkyControlState
		switch mode {
		case .spring: state = .default
		case .sticky: state = stater.previousState == .default ? .selected : .default
		case .custom: return
		}
		tryUpdate(to: state)
	}

	private func buttonDidCancelTouch() {
		stater.revertToPreviousState()
	}

	private func tryUpdate(to state: SkyControlState) {
		let previous = stater.previousState
		let deselectDenied = !(canBecomeDeselectedHandler?() ?? true)
		if state == .default, previous == .selected, deselectDenied {
			stater.update(to: .selected)
			return
		}
		stater.update(to: state)
	}
}

//extension SkyBaseButtonConfiguration: SkyBlockItem {
//
//	public var isSelected: Bool {
//		return stater.state == .selected
//	}
//
//	public func put<ItemType>(in block: GBlock<ItemType>,
//							  type: ItemType) where ItemType: Equatable {
//		guard let owner = owner else { return }
//		block.g.addItem(self, element: owner, type: type)
//		addHandler(for: .touchUpInside) { [weak block] in
//			block?.g.didTapItem(with: type)
//		}
//	}
//
//	public func select() {
//		guard mode == .sticky else { return }
//		stater.update(to: .selected)
//	}
//
//	public func deselect() {
//		guard mode == .sticky else { return }
//		stater.update(to: .default)
//	}
//}


//
//  SkyControlConfiguration.swift
//  Skyline
//
//  Created by 17790204 on 05.05.2021.
//

import UIKit

/// Конфигурация SkyControl
public class SkyControlConfiguration<Type: UIControl>: SkyViewConfiguration<Type> {

	/// События, аналогично UIControl.Event
	public enum Event {

		case touchDown
		case touchDownRepeat

		case touchUpInside
		case touchUpOutside
		case touchCancel

		case touchDragInside
		case touchDragOutside
		case touchDragEnter
		case touchDragExit

		case valueChanged

		case editingDidBegin
		case editingChanged
		case editingDidEnd
		case editingDidEndOnExit
	}

	/// Позиция обработчика при добавлении
	public enum Position {

		/// Вставляется в начало, вызывается первым
		case first

		/// Втсавляется в конец, вызывается последним
		case last
	}

	/// Доступно ли взаимодействие с контролом
	public var isEnabled: Bool = true {
		didSet {
			owner?.isEnabled = isEnabled
		}
	}

	/// Тип Haptic Feedback при нажатии
//	public var haptic: GHapticImpactType?

	private var pairs = [Event: [() -> Void]]()

	override init() {
		super.init()
		isExclusiveTouch = true
	}

	/// Добавить хендлер для типа евента
	/// - Parameters:
	///   - event: тип евента
	///   - position: позиция для вызова обработчика
	///   - handler: обработчик
	public func addHandler(for event: Event, position: Position, handler: (() -> Void)?) {
		guard let handler = handler else { return }
		var actions = pairs[event] ?? []
		switch position {
		case .last:
			actions.append(handler)
		case .first:
			actions.insert(handler, at: 0)
		}

		pairs[event] = actions
	}

	/// Добавить хендлер для типа евента
	/// - Parameters:
	///   - event: тип евента
	///   - handler: обработчик
	public func addHandler(for event: Event, handler: (() -> Void)?) {
		addHandler(for: event, position: .last, handler: handler)
	}

	///  Добавить хендлер для типов евентов
	public func addHandler(for events: Event..., handler: (() -> Void)?) {
		guard let handler = handler else { return }
		for event in events {
			addHandler(for: event, handler: handler)
		}
	}

	///  Удалить все хендлеры для типа евента
	public func removeAllHandlers(for event: Event) {
		pairs[event]?.removeAll()
	}

	///  Удалить все хендлеры для типов евентов
	public func removeAllHandlers(for events: [Event]) {
		for event in events {
			removeAllHandlers(for: event)
		}
	}

	override func configureOwner() {
		super.configureOwner()

//		retrigger(self, \.isEnabled)

		owner?.addTarget(self, action: #selector(controlDidTouchDown), for: .touchDown)
		owner?.addTarget(self, action: #selector(controlDidTouchDownRepeat), for: .touchDownRepeat)

		owner?.addTarget(self, action: #selector(controlDidTouchUpInside), for: .touchUpInside)
		owner?.addTarget(self, action: #selector(controlDidTouchUpOutside), for: .touchUpOutside)
		owner?.addTarget(self, action: #selector(controlDidTouchCancel), for: .touchCancel)

		owner?.addTarget(self, action: #selector(controlDidTouchDragInside), for: .touchDragInside)
		owner?.addTarget(self, action: #selector(controlDidTouchDragOutside), for: .touchDragOutside)
		owner?.addTarget(self, action: #selector(controlDidTouchDragEnter), for: .touchDragEnter)
		owner?.addTarget(self, action: #selector(controlDidTouchDragExit), for: .touchDragExit)

		owner?.addTarget(self, action: #selector(controlValueChanged), for: .valueChanged)

		owner?.addTarget(self, action: #selector(controlEditingDidBegin), for: .editingDidBegin)
		owner?.addTarget(self, action: #selector(controlEditingChanged), for: .editingChanged)
		owner?.addTarget(self, action: #selector(controlEditingDidEnd), for: .editingDidEnd)
		owner?.addTarget(self, action: #selector(controlEditingDidEndOnExit), for: .editingDidEndOnExit)

		addHandler(for: .touchUpInside, handler: { [weak self] in self?.additionalTapActions() })
	}

	@objc private func controlDidTouchDown() { processEvent(.touchDown) }
	@objc private func controlDidTouchDownRepeat() { processEvent(.touchDownRepeat) }

	@objc private func controlDidTouchUpInside() { processEvent(.touchUpInside) }
	@objc private func controlDidTouchUpOutside() { processEvent(.touchUpOutside) }
	@objc private func controlDidTouchCancel() { processEvent(.touchCancel) }

	@objc private func controlDidTouchDragInside() { processEvent(.touchDragInside) }
	@objc private func controlDidTouchDragOutside() { processEvent(.touchDragOutside) }
	@objc private func controlDidTouchDragEnter() { processEvent(.touchDragEnter) }
	@objc private func controlDidTouchDragExit() { processEvent(.touchDragExit) }

	@objc private func controlValueChanged() { processEvent(.valueChanged) }

	@objc private func controlEditingDidBegin() { processEvent(.editingDidBegin) }
	@objc private func controlEditingChanged() { processEvent(.editingChanged) }
	@objc private func controlEditingDidEnd() { processEvent(.editingDidEnd) }
	@objc private func controlEditingDidEndOnExit() { processEvent(.editingDidEndOnExit) }

	private func additionalTapActions() {
//		if let hapticType = haptic {
//			GHaptic.tic(.impact(hapticType))
//		}
	}

	private func processEvent(_ event: Event) {
		guard let actions = pairs[event] else {
			return
		}
		for action in actions {
			action()
		}
	}
}


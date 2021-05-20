//
//  SkyPinPad.swift
//  Skyline
//
//  Created by 17790204 on 04.05.2021.
//

import UIKit
import AudioToolbox

/**
 Вью для ввода пинкода, по сути нумпад с двумя вспомогательными кнопками

 Пример использования:
 ~~~
 let pinPadView = GPinPad()

 pinPadView.g.digitColor = .brand
 pinPadView.g.digitFont = .footnote
 pinPadView.g.leftButtonInfo.picture = nil

 pinPadView.delegate = self

 // добавляем как сабвью, выставляем констрейнты
 ~~~

 - important: Пинпад сам себе выставляет констрейнт соотношения сторон!
 */

/// Системные звуки клавиатуры
enum SystemSound: UInt32 {

	case pressClick = 1123
	case pressDelete = 1155

	func play() {
		AudioServicesPlaySystemSound(self.rawValue)
	}
}

public final class SkyPinPad: UIView {

	private enum AccessoryButtonPosition {
		case left, right
	}

	private struct Const {
		static let aspectRatio: CGFloat = 1.0
		static let animationDuration: TimeInterval = 0.25
		static let pressedScale: CGFloat = 0.8
	}

	private lazy var stackView = makeColumnStackView(arrangedSubviews: [row1, row2, row3, row4])
	private lazy var row1 = makeRowStackView(arrangedSubviews: Array(digitButtons[1 ... 3]))
	private lazy var row2 = makeRowStackView(arrangedSubviews: Array(digitButtons[4 ... 6]))
	private lazy var row3 = makeRowStackView(arrangedSubviews: Array(digitButtons[7 ... 9]))
	private lazy var row4 = makeRowStackView(arrangedSubviews: [makeContainer(for: leftButton),
																digitButtons[0],
																makeContainer(for: rightButton)])

	private lazy var digitButtons: [SkyButton] = {
		var array = [SkyButton]()
		for index in 0 ..< 10 {
			let button = makeDigitButton()
			button.backgroundColor = .white
			button.sky.text = String(index)
			array.append(button)
		}
		return array
	}()

	private lazy var leftButton = makeAccessoryButton(position: .left)
	private lazy var rightButton = makeAccessoryButton(position: .right)

	///  Конфигурация пинпада
	public let sky: SkyPinPadConfiguration<SkyPinPad>

	///  Делегат пинпада
	public weak var delegate: SkyPinPadDelegate?

	/// Конструктор
	/// - Parameters:
	init() {
		sky = SkyPinPadConfiguration()
		super.init(frame: .zero)
		sky.owner = self
		self.translatesAutoresizingMaskIntoConstraints = false
		backgroundColor = .white
		setupViews()
	}

	@available(*, unavailable)
	required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
	@available(*, unavailable)
	public override init(frame: CGRect) { fatalError("init(coder:) has not been implemented") }

	private func setupViews() {
		addSubview(stackView)
		stackView.pinToSuperView()
		self.heightAnchor.constraint(equalTo: widthAnchor, multiplier: Const.aspectRatio).isActive = true
	}

	private func makeRowStackView(arrangedSubviews: [UIView]) -> UIStackView {
		let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.axis = .horizontal
		stackView.alignment = .fill
		stackView.distribution = .equalSpacing
		return stackView
	}

	private func makeColumnStackView(arrangedSubviews: [UIView]) -> UIStackView {
		let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.axis = .vertical
		stackView.alignment = .fill
		stackView.distribution = .fillEqually
		stackView.spacing = .zero
		return stackView
	}

	private func configureDigitButton(_ button: SkyButton) {
//		button.g.font = g.digitFont
		button.sky.textColor = sky.digitColor
	}

	private func makeDigitButton() -> SkyButton {
		let button = SkyButton(skytype: .base)
		configureDigitButton(button)
		addPressAnimation(to: button)
		button.makeSquare()
//		button.g.cornerRadius = .circle
		button.sky.addHandler(for: .touchUpInside) { [weak self] in
			guard let self = self, let text = button.sky.text else { return }
			SystemSound.pressClick.play()
			self.delegate?.pinPadView(self, didTapDigitButtonWith: text)
		}
		return button
	}

	private func configureAccessoryButton(_ button: SkyButton, info: String) {
		button.sky.text = info
//		button.isHidden = info.picture == nil
//		if let picture = info.picture {
//			button.g.picture = picture
//		}
	}

	private func makeAccessoryButton(position: AccessoryButtonPosition) -> SkyButton {
		let button = SkyButton(skytype: .base)
		addPressAnimation(to: button)
		// не делаем ее квадратной, потому что она лежит в квадратной вьюхе
		button.adjustsImageWhenHighlighted = false
//		button.g.cornerRadius = .circle
		switch position {
		case .left:
			print("ff")
			configureAccessoryButton(button, info: "!")
			button.sky.addHandler(for: .touchUpInside) { [weak self] in
				guard let self = self else { return }
				self.delegate?.pinPadViewDidTapLeftButton(self)
			}
		case .right:
			print("ff")
			configureAccessoryButton(button, info:	"?")
			button.sky.addHandler(for: .touchUpInside) { [weak self] in
				guard let self = self else { return }
				SystemSound.pressDelete.play()
				self.delegate?.pinPadViewDidTapRightButton(self)
			}
		}
		return button
	}

	private func addPressAnimation(to button: SkyButton) {
		button.sky.associate(states: .default) { g in
			g.backgroundColor = .clear
		}
		button.sky.associate(states: .pressed) { g in
			g.backgroundColor = .onBackgroundQuaternary
		}
	}

	private func makeContainer(for view: UIView) -> UIView {
		let containerView = UIView()
		containerView.makeSquare()
		containerView.addSubview(view)
		view.pinToSuperView()
		return containerView
	}

	///  Обновить кнопки с цифрами
	func updateDigitButtons() {
		digitButtons.forEach { configureDigitButton($0) }
	}

	///  Обновить вспомогательные кнопки
	func updateAccessoryButtons() {
		configureAccessoryButton(leftButton, info: "!")
		configureAccessoryButton(rightButton, info: "?")
	}

	///  Узнать предпочтительную высоту для конкретной ширины
	///
	/// - Parameter width:  желаемая ширина
	/// - Returns: предпочтительная высота
	public func preferredHeightWith(width: CGFloat) -> CGFloat {
		return width * Const.aspectRatio
	}

	/// Добавление возможности вводить значения на GPinPad с физической клавиатуры MAC
	#if targetEnvironment(simulator)
		/// Становится firstResponder, как только добавились на супервью
		public override func didMoveToSuperview() {
			super.didMoveToSuperview()
			becomeFirstResponder()
		}

		/// Может становиться firstResponder
		public override var canBecomeFirstResponder: Bool {
			return true
		}

		/// Массив комманд, на которые реагирует вью
		public override var keyCommands: [UIKeyCommand] {
			return (1 ... 9).map { UIKeyCommand(input: String($0),
												modifierFlags: [],
												action: #selector(handleKeyboardInput))
			}
		}

		/// Обработка нажатий с клавиатуры
		@objc private func handleKeyboardInput(with command: UIKeyCommand) {
//			if let input = command.input {
//				delegate?.pinPadView(self, didTapDigitButtonWith: input)
//			}
		}
	#endif
}

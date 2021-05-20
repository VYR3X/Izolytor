//
//  SkySwitch.swift
//  Skyline
//
//  Created by 17790204 on 05.05.2021.
//

import UIKit

/// Свич
public final class SkySwitch: UISwitch {

	/// Конфигурация атома
	public let sky: SkySwitchConfiguration<SkySwitch>

	/// Конструктор
	init() {
		sky = SkySwitchConfiguration()
		super.init(frame: .zero)
		sky.owner = self // пока хз зачем
	}

	@available(*, unavailable)
	required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
	@available(*, unavailable)
	public override init(frame: CGRect) { fatalError("init(coder:) has not been implemented") }
}

// MARK: - Публичные конструкторы
public extension SkySwitch {}


//
//  SkyConfiguration.swift
//  Skyline
//
//  Created by 17790204 on 05.05.2021.
//

/// Содержит в себе абстрактные проперти элемента дизайн-системы.
/// Должен автоматически обновлять их в случае смены стиля.
/// Не рекомендуется
public class SkyConfiguration<Type: AnyObject & Hashable> {

	/// owner - это вью которую будут изменять
	weak var owner: Type? {
		didSet {
			configureOwner()
		}
	}

	func configureOwner() {}
}

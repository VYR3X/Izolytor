//
//  GroundTabBarInteractor.swift
//  Ground
//
//  Created by 17790204 on 27.11.2020.
//  Copyright © 2020 Splash Fire. All rights reserved.
//

protocol StartInteractorProtocol {

    var presenter: GroundTabBarPresenter? { get set }
}

class GroundTabBarInteractor {

    weak var presenter: GroundTabBarPresenter?
}

extension GroundTabBarInteractor: StartInteractorProtocol {}

//
//  SecondService.swift
//  Ground
//
//  Created by 17790204 on 27.11.2020.
//  Copyright © 2020 Splash Fire. All rights reserved.
//

import Foundation

/// Интерфейс взаимодействия с интерактором экрана списка c песен в альбоме
protocol SecondServiceProtocol {

	//func getRequest(completion: @escaping (Result<PolyclinicModel, Error>) -> Void)
}

/// Интерактор для чарта песен ( новые песни на главном экране )
class SecondService: SecondServiceProtocol {

	func getRequest(completion: @escaping (Result<FirstModel, Error>) -> Void) {

		var url: URL? {
			var components = URLComponents()
			components.scheme = "http"
			components.host =  "localhost"
			components.port = 8080
			components.path = "/album"
			return components.url
		}

		// TO:DO - сделать норм url
		//let url = URL(string: "http://localhost:8080/album")

		let session = URLSession.shared

		session.dataTask(with: url!) { (data , responce, error) in

			if let responce = responce {
				print(responce)
			}

			guard let data = data else { return }

			print("\n\nwin1251String\n\n")
			let win1251String = String(data: data, encoding: .windowsCP1251)

			guard let win1251Data = win1251String!.data(using: .utf8, allowLossyConversion: true) else {
				print("could not convert data")
				return
			}

			do {
				let musicAlbum = try JSONDecoder().decode(FirstModel.self, from: win1251Data)
				completion(.success(musicAlbum))
			}
			catch let jsonError {
				print("could not convert data to win1251 format")
				completion(.failure(jsonError)) // вместо print
			}

		}.resume()
	}
}

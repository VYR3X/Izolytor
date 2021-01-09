//
//  FirstService.swift
//  Ground
//
//  Created by 17790204 on 27.11.2020.
//  Copyright © 2020 Splash Fire. All rights reserved.
//

import Foundation

/// Интерфейс взаимодействия с интерактором экрана списка c песен в альбоме
protocol FirstServiceProtocol {

	func getRequest(completion: @escaping (Result<[FirstModel], Error>) -> Void)
}

/// Интерактор списка песен музыкального альбома
class FirstService: FirstServiceProtocol {

	func getRequest(completion: @escaping (Result<[FirstModel], Error>) -> Void) {

		var url: URL? {
			var components = URLComponents()
			components.scheme = "http"
			components.host =  "localhost"
			components.port = 8080
			components.path = "/album"
			return components.url
		}

		//let url = URL(string: "http://localhost:8080/album")

		let session = URLSession.shared

		session.dataTask(with: url!) { (data , responce, error) in

			if let responce = responce {
				print(responce)
			}

			guard let data = data else { return }

			do {
				let musics = try JSONDecoder().decode([FirstModel].self, from: data)
				print("Какая музыка пришла:\n\(musics)")
				completion(.success(musics))
			} catch let error {
				print(error)
			}
		}.resume()
	}
}



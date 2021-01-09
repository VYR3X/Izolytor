//
//  FirstModel.swift
//  Ground
//
//  Created by 17790204 on 27.11.2020.
//  Copyright © 2020 Splash Fire. All rights reserved.
//

// MARK: - AlbumMusic
struct FirstModel: Codable {
    let songName, artistName, id: String

    enum CodingKeys: String, CodingKey {
        case songName = "songName"
        case artistName = "artistName"
        case id = "id"
    }
}

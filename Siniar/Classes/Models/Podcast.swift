//
//  Podcast.swift
//  Siniar
//
//  Created by Bayu Yasaputro on 13/08/22.
//

import Foundation

struct Podcast: Decodable {
    let collectionId: Int
    let collectionName: String
    let trackId: Int
    let trackName: String
    let artistName: String
    let artworkUrl30: String
    let artworkUrl60: String
    let artworkUrl100: String
    let artworkUrl600: String
    let genres: [String]
    let feedUrl: String
    
    enum CodingKeys: String, CodingKey {
        case collectionId
        case collectionName
        case trackId
        case trackName
        case artistName
        case artworkUrl30
        case artworkUrl60
        case artworkUrl100
        case artworkUrl600
        case genres
        case feedUrl
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        collectionId = try values.decodeIfPresent(Int.self, forKey: .collectionId) ?? 0
        collectionName = try values.decodeIfPresent(String.self, forKey: .collectionName) ?? ""
        trackId = try values.decodeIfPresent(Int.self, forKey: .trackId) ?? 0
        trackName = try values.decodeIfPresent(String.self, forKey: .trackName) ?? ""
        artistName = try values.decodeIfPresent(String.self, forKey: .artistName) ?? ""
        artworkUrl30 = try values.decodeIfPresent(String.self, forKey: .artworkUrl30) ?? ""
        artworkUrl60 = try values.decodeIfPresent(String.self, forKey: .artworkUrl60) ?? ""
        artworkUrl100 = try values.decodeIfPresent(String.self, forKey: .artworkUrl100) ?? ""
        artworkUrl600 = try values.decodeIfPresent(String.self, forKey: .artworkUrl600) ?? ""
        genres = try values.decodeIfPresent([String].self, forKey: .genres) ?? []
        feedUrl = try values.decodeIfPresent(String.self, forKey: .feedUrl) ?? ""
    }
}

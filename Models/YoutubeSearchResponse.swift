//
//  YoutubeSearchResponse.swift
//  MovieApp
//
//  Created by OGBODO on 26/02/2026.
//

import Foundation

struct YoutubeSearchResponse: Codable {
    let items: [ItempProperties]?
}

struct ItempProperties: Codable {
    let id: videoIdProperties?
}
struct videoIdProperties: Codable {
    let videoId: String?
}

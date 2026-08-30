//
//  YoutubeSearchResponse.swift
//  awesomemovie
//
//  Created by Danya on 24.08.2026.
//

import Foundation


struct YoutubeSearchResponse: Codable {
    let items: [ItemProperties]?
}

struct ItemProperties: Codable {
    let id: IdProperties?
}
struct IdProperties: Codable {
    let videoId: String?
}

//
//  YoutubeSearchResponse.swift
//  Netflix Clone
//
//  Created by Moamen on 11/04/2024.
//

import Foundation

struct YoutubeSearchResponse: Codable {
    let items: [VideoElement]
}


struct VideoElement: Codable {
    let id: IdVideoElement
}


struct IdVideoElement: Codable {
    let kind: String
    let videoId: String
}

//
//  Search.swift
//  SeSac_RecapAssignment
//
//  Created by youngjoo on 1/19/24.
//

import Foundation

// MARK: - Search
struct Search: Codable {
    let lastBuildDate: String
    let total, start, display: Int
    var items: [Item]
}

// MARK: - Item
struct Item: Codable {
    var title: String
    let link, image, lprice, mallName, productID: String

    enum CodingKeys: String, CodingKey {
        case title, link, image, lprice, mallName
        case productID = "productId"
    }
}

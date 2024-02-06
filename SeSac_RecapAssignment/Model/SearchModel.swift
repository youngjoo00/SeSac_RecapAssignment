//
//  Search.swift
//  SeSac_RecapAssignment
//
//  Created by youngjoo on 1/19/24.
//

import Foundation

// MARK: - Search
struct Search: Decodable {
    let lastBuildDate: String
    let total, start, display: Int
    var items: [Item]
}

// MARK: - Item
struct Item: Decodable {
    var title: String
    let link, image, lprice, mallName, productID: String

    enum CodingKeys: String, CodingKey {
        case title, link, image, lprice, mallName
        case productID = "productId"
    }
}

//
//  QuotesModel.swift
//  Random Quote
//
//  Created by Esar Tech on 6/26/20.
//  Copyright © 2020 Ahmed-Ateek. All rights reserved.
//

import Foundation
struct QuotesModelElement: Codable {
    let id, sr, en, author: String
    let rating: Double?
    let quotesModelID: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case sr, en, author, rating
        case quotesModelID = "id"
    }
}

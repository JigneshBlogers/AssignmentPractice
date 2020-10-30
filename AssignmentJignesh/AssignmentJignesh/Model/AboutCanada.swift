//
//  AboutCanada.swift
//  WyndhamAssignment
//
//  Created by Amol P on 15/05/19.
//  Copyright © 2019 pccs. All rights reserved.
//

import Foundation

struct AboutCanada: Codable {
    var title: String?
    var rows: [Rows] = []
}

struct Rows: Codable {
    let title: String?
    let description: String?
    let imageURL: String?
    
    enum CodingKeys : String, CodingKey {
        case title
        case description
        case imageURL = "imageHref"
    }
}

//
//  BanksModel.swift
//  CodeTestIOS
//
//  Created by Max DU on 25/9/2024.
//

import Foundation

struct BanksModel: Codable {
    let banks: [Bank]
}

struct Bank: Codable {
    let nameEn: String
    let descEn: String?
    let actions: Actions
    var isExpanded: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case nameEn
        case descEn
        case actions
        case isExpanded 
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        nameEn = try container.decode(String.self, forKey: .nameEn)
        descEn = try? container.decode(String.self, forKey: .descEn)
        actions = try container.decode(Actions.self, forKey: .actions)
        isExpanded = try container.decodeIfPresent(Bool.self, forKey: .isExpanded) ?? false // Default value
    }
}

struct Actions: Codable {
    let recommended: [Action]
    let more: [Action]
}

struct Action: Codable {
    let titleEn: String
    let type: String
    let urlEn: String
}


//
//  Models.swift
//  libraryFrontend
//
//  Created by Bechir Kefi on 8/7/2024.
//

import Foundation

struct VersionInfo: Codable, Identifiable {
    var id: String
    var version: String
    var mandatory: Bool

   
    enum CodingKeys: String, CodingKey {
        case id = "_id" // Map the JSON key "_id" to the property "id"
        case version
        case mandatory
    }
}

struct UpdateInfo: Codable {
    var versions: [VersionInfo]
}



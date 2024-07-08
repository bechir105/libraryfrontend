//
//  Models.swift
//  libraryFrontend
//
//  Created by Bechir Kefi on 8/7/2024.
//

import Foundation

public struct VersionInfo: Codable, Identifiable {
    public var id: String
    public var version: String
    public var mandatory: Bool

    public enum CodingKeys: String, CodingKey {
        case id = "_id"
        case version
        case mandatory
    }

    public init(id: String, version: String, mandatory: Bool) {
        self.id = id
        self.version = version
        self.mandatory = mandatory
    }
}

public struct UpdateInfo: Codable {
    public var versions: [VersionInfo]

    public init(versions: [VersionInfo]) {
        self.versions = versions
    }
}

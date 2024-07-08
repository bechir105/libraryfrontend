//
//  Bundle+Extensions.swift
//  libraryFrontend
//
//  Created by Bechir Kefi on 8/7/2024.
//

import Foundation

public extension Bundle {
    var currentVersion: String {
        return self.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown"
    }
}

//
//  ContentView.swift
//  libraryFrontend
//
//  Created by Bechir Kefi on 8/7/2024.
//

import SwiftUI

extension Bundle {
    var currentVersion: String {
        return self.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown"
    }
}

struct ContentView: View {
    @State private var updateInfo: UpdateInfo?
    @State private var showAlert = false
    @State private var mandatoryUpdate = false
    @State private var latestVersion = ""
    @State private var currentVersion: String = Bundle.main.currentVersion // Fetches the current app version

    var body: some View {
        VStack {
            if let updateInfo = updateInfo {
                Text("Current Version: \(currentVersion)")
                Text("Latest Version: \(latestVersion)")
                if mandatoryUpdate {
                    Text("This update is mandatory.").foregroundColor(.red)
                }
            } else {
                Text("Checking for updates...")
            }
            Button("Check Updates") {
                checkForUpdates()
            }
            .padding()
        }
        .onAppear {
            checkForUpdates()
        }
        .alert(isPresented: $showAlert) {
            if mandatoryUpdate {
                return Alert(
                    title: Text("Update Required"),
                    message: Text("A new version (\(latestVersion)) is available. Please update your app."),
                    dismissButton: .default(Text("Update"), action: handleUpdate)
                )
            } else {
                return Alert(
                    title: Text("Update Available"),
                    message: Text("A new version (\(latestVersion)) is available. Would you like to update?"),
                    primaryButton: .default(Text("Update"), action: handleUpdate),
                    secondaryButton: .cancel(Text("Skip"))
                )
            }
        }
    }

    func checkForUpdates() {
        guard let url = URL(string: "http://localhost:3000/checkForUpdates") else {
            print("Invalid URL")
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching data: \(error)")
                return
            }
            guard let data = data else {
                print("No data received")
                return
            }
            do {
                let updateInfo = try JSONDecoder().decode(UpdateInfo.self, from: data)
                DispatchQueue.main.async {
                    self.updateInfo = updateInfo
                    self.evaluateUpdateInfo(updateInfo.versions)
                }
            } catch {
                print("Error decoding data: \(error)")
            }
        }.resume()
    }

    func evaluateUpdateInfo(_ versions: [VersionInfo]) {
        guard let latestVersionInfo = versions.sorted(by: { $0.version > $1.version }).first else { return }
        latestVersion = latestVersionInfo.version
        mandatoryUpdate = latestVersionInfo.mandatory
        showAlert = latestVersion.compare(currentVersion, options: .numeric) == .orderedDescending
    }

    func handleUpdate() {
        currentVersion = latestVersion
        showAlert = false
        print("Version updated to \(latestVersion)")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}





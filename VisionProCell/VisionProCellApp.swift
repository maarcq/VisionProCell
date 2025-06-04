//
//  VisionProCellApp.swift
//  VisionProCell
//
//  Created by Marcelle Ribeiro Queiroz on 03/06/25.
//

import SwiftUI

@main
struct VisionProCellApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    SoundManager.playInstance.playBackground()
                }
        }
        .windowStyle(.volumetric)
        .defaultSize(width: 2, height: 2, depth: 2, in: .meters)
    }
}

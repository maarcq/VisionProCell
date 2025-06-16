//
//  ContentView.swift
//  VisionProCell
//
//  Created by Marcelle Ribeiro Queiroz on 03/06/25.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {

    @State var enlarge = false
    @State private var  scene: Entity?

    var body: some View {
        VStack {
            RealityView { content in
                // Add the initial RealityKit content
                if let scene = try? await Entity(named: "Cell", in: realityKitContentBundle) {
                    self.scene = scene
                    content.add(scene)
                }
            } update: { content in
                // Update the RealityKit content when SwiftUI state changes
                if let scene = content.entities.first {
                    let uniformScale: Float = enlarge ? 1 : 0.6
                    scene.transform.scale = [uniformScale, uniformScale, uniformScale]
                }
            }
            
            VStack {
                Button {
                    enlarge.toggle()
                } label: {
                    Text(enlarge ? "Reduzir conteúdo" : "Ampliar conteúdo")
                }
                .animation(.none, value: 0)
                .fontWeight(.semibold)
                .font(.title)
            }
            .padding()
            .glassBackgroundEffect()
        }
    }
}

#Preview(windowStyle: .volumetric) {
    ContentView()
}

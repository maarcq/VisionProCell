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

    var body: some View {
        VStack {
            RealityView { content in
                // Add the initial RealityKit content
                if let scene = try? await Entity(named: "Cell", in: realityKitContentBundle) {
                    let children = scene.children[0].children
                    
                    for child in children {
                        switch child.name {
                        case "nucleo":
                            child.components.set(HoverEffectComponent(.highlight(.init(color: .orange, strength: 3.0))))
                        case "complexoGolgi":
                            child.components.set(HoverEffectComponent(.highlight(.init(color: .orange, strength: 3.0))))
                        case "ribossomos":
                            child.components.set(HoverEffectComponent(.highlight(.init(color: .orange, strength: 3.0))))
                        case "reticuloLiso":
                            child.components.set(HoverEffectComponent(.highlight(.init(color: .orange, strength: 3.0))))
                        case "reticuloRugoso":
                            child.components.set(HoverEffectComponent(.highlight(.init(color: .orange, strength: 3.0))))
                        default: break
                        }
                    }
                    
                    content.add(scene)
                }
            } update: { content in
                // Update the RealityKit content when SwiftUI state changes
                if let scene = content.entities.first {
                    let uniformScale: Float = enlarge ? 1.4 : 1.0
                    scene.transform.scale = [uniformScale, uniformScale, uniformScale]
                }
            }
            .gesture(TapGesture().targetedToAnyEntity().onEnded { value in
                print(value.entity.name)
            })

            VStack {
                Button {
                    enlarge.toggle()
                } label: {
                    Text(enlarge ? "Reduce RealityView Content" : "Enlarge RealityView Content")
                }
                .animation(.none, value: 0)
                .fontWeight(.semibold)
            }
            .padding()
            .glassBackgroundEffect()
        }
    }
}

#Preview(windowStyle: .volumetric) {
    ContentView()
}

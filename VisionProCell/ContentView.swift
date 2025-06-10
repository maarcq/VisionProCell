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
                    
//                    // Percorre todos os filhos da cena para configurar animações em loop
//                    let children = scene.children[0].children
//                    for child in children {
//                        setupAnimationLoop(for: child)
//                    }

                    content.add(scene)
                }
            } update: { content in
                // Update the RealityKit content when SwiftUI state changes
                if let scene = content.entities.first {
                    let uniformScale: Float = enlarge ? 1 : 0.6
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
//    // Função para configurar animação em loop
//    private func setupAnimationLoop(for entity: Entity) {
//        // Verifica se a entidade tem animações
//        guard let animationResource = entity.availableAnimations.first else {
//            print("Não tem animação na entity: \(entity.name)")
//            return
//        }
//        // Cria uma ação de animação em loop
//        let loopAnimation = animationResource.repeat()
//        
//        entity.playAnimation(loopAnimation)
//    }
}

#Preview(windowStyle: .volumetric) {
    ContentView()
}

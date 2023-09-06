//
//  DObject.swift
//  MV-Project
//
//  Created by Daniel Coria on 28/08/23.
//

import SwiftUI
import RealityKit

struct DObject: View {
    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace
    
    @Environment(\.openWindow) private var openWindow
    @Environment(\.dismissWindow) private var dismissWindow
    var orientation: SIMD3<Double> = .zero
    var objectName: String = "Golden_Trophy"
    
    var body: some View {
        TimelineView(.animation) { context in
            Model3D(named: objectName) { model in
                model
                    .resizable()
                    .scaledToFit()
                    .rotation3DEffect(
                        Rotation3D(
                            angle: Angle2D(degrees: 50 * context.date.timeIntervalSinceReferenceDate), axis: .y
                        )
                    )
                
            } placeholder: {
                ProgressView()
            }
        }
        .onAppear {
            Task {
                await openImmersiveSpace(id: "ImmersiveSpace")
                openWindow (id: "StatsView")
                openWindow(id: "Carousel")
            }
        }
        .onDisappear {
            Task {
                await dismissImmersiveSpace()
                dismissWindow(id: "StatsView")
                dismissWindow(id: "Carousel")
            }
        }
    }
}

#Preview {
    DObject()
}

//
//  MV_ProjectApp.swift
//  MV-Project
//
//  Created by Daniel Coria on 01/08/23.
//

import SwiftUI

@main
struct MV_ProjectApp: App {
    
    var body: some Scene {
        
        WindowGroup {
            Container()
        }
        .windowResizability(.contentSize)
        
#if os(visionOS)
        // Defines an immersive space to present a destination in which to watch the video.
        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }
        // Set the immersion style to progressive, so the user can use the crown to dial in their experience.
        .immersionStyle(selection: .constant(.progressive), in: .progressive)
#endif
//        WindowGroup(id: "WebView") {
//            WebViewWindow()
//        }
        
        WindowGroup(id: "StatsView") {
            StatsView()
                .frame(alignment: .leading)
        }
        .windowResizability(.contentSize)
        .defaultSize(CGSize(width: 400, height: 800))
        
        WindowGroup(id: "Object") {
            DObject()
        }
        .windowStyle(.volumetric)
        .defaultSize(width: 0.9, height: 0.9, depth: 1, in: .meters)
        
        WindowGroup(id: "Carousel") {
            BottomCarousel()
        }
        .windowResizability(.contentSize)
        .defaultSize(CGSize(width: 1000, height: 300))
    }
}

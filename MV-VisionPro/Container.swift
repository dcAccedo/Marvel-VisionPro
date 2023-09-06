//
//  Container.swift
//  MV-VisionPro
//
//  Created by Daniel Coria on 29/08/23.
//

import SwiftUI

struct Container: View {
    @Environment(\.openWindow) private var openWindow
    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace
    
    @State private var showWebView = false
    @State private var immersiveSpaceIsShown = false
    @State private var showHome = true
    
    
    var body: some View {
        VStack {
            if !showWebView {
                Button {
                    showWebView.toggle()
                } label: {
                    Text("Start")
                }
                .padding(.vertical)
                .font(.headline)
                .hoverEffect()
                
            }
                
            if showWebView {
                WebViewWindow(loadHome: $showHome)
            }
        }
        .ornament(
            visibility: showWebView ? .visible : .hidden,
            attachmentAnchor: .scene(alignment: .trailing)
        ) {
            Button {
                showHome.toggle()
            } label: {
                Text(showHome ? "Show Basketball-WM" : "Show Start")
            }
        }
        
    }
}

#Preview {
    Container()
}

////
////  WindowModifier.swift
////  MV-VisionPro
////
////  Created by Daniel Coria on 31/08/23.
////
//
//import Foundation
//import SwiftUI
//
//struct HostingWindowFinder: NSViewRepresentable {
//    var callback: (NSWindow?) -> ()
//    
//    func makeNSView(context: Self.Context) -> NSView {
//        let view = NSView()
//        DispatchQueue.main.async { self.callback(view.window) }
//        return view
//    }
//    
//    func updateNSView(_ nsView: NSView, context: Context) {
//        DispatchQueue.main.async { self.callback(nsView.window) }
//    }
//}
//
//private struct WindowPositionModifier: ViewModifier {
//    
//    let position: NSWindow.Position
//    let screen: NSScreen?
//    
//    func body(content: Content) -> some View {
//        content.background(
//            HostingWindowFinder {
//                $0?.setPosition(position, in: screen)
//            }
//        )
//    }
//}

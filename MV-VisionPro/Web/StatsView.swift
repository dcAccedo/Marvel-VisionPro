//
//  StatsView.swift
//  MV-Project
//
//  Created by Daniel Coria on 25/08/23.
//

import SwiftUI
import WebKit

struct StatsView: UIViewRepresentable {
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let magentaWeb = URL(string: "https://www.fiba.basketball/basketballworldcup/2023/game/2508/Germany-Japan#tab=overview") else { return }
        uiView.scrollView.isScrollEnabled = true
        uiView.load(URLRequest(url: magentaWeb))
    }
    
    func makeUIView(context: Context) ->  WKWebView {
        let webview = WKWebView()
        
        let preferences = WKWebpagePreferences()
        preferences.allowsContentJavaScript = true
        preferences.preferredContentMode = .mobile
        
        webview.configuration.preferences.javaScriptCanOpenWindowsAutomatically = false
        webview.configuration.defaultWebpagePreferences = preferences
        
        return webview
    }
}

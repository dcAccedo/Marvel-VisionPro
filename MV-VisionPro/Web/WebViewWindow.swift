//
//  WebViewWindow.swift
//  MV-Project
//
//  Created by Daniel Coria on 25/08/23.
//

import SwiftUI
import WebKit

struct WebViewWindow: UIViewRepresentable {
        
    let webView = WKWebView()
    var baseMagenta = URL(string: "https://web.magentatv.de")
    var baseMagentaBasketball = URL(string:  "https://web.magentatv.de/url/tvhubs.t-online.de/v2/iptv2015acc/DocumentGroupRedirect/TVHS_DG_SG_Einstieg_FIBA-Basketball-WM-2023?whiteLabelId=webClient")

    @Binding var loadHome: Bool
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        loadRequest(in: uiView)
        uiView.scrollView.isScrollEnabled = true
    }
    
    func makeCoordinator() -> Coodinator {
        Coodinator(self)
    }
    
    func makeUIView(context: Context) ->  WKWebView {
        webView.uiDelegate = context.coordinator
        webView.navigationDelegate = context.coordinator
        
        let preferences = WKWebpagePreferences()
        preferences.allowsContentJavaScript = true
        preferences.preferredContentMode = .desktop
        
        webView.configuration.preferences.javaScriptCanOpenWindowsAutomatically = false
        webView.configuration.defaultWebpagePreferences = preferences
        context.coordinator.addWebViewObserver()
        
        return webView
    }
        
    fileprivate func loadRequest(in webView: WKWebView) {
        if loadHome {
            guard let url = baseMagenta else { return }
            webView.load(URLRequest(url: url))
        } else {
            guard let url = baseMagentaBasketball else { return }
            webView.load(URLRequest(url: url))
        }
    }
}

extension WebViewWindow {
    
    class Coodinator: NSObject, WKUIDelegate, WKNavigationDelegate {
        var parent: WebViewWindow
        
        @Environment(\.openWindow) private var openWindow
        @Environment(\.dismissWindow) private var dismissWindow
        
        let path = "https://web.magentatv.de/serie/fiba-basketball-wm-2023/staffel-00/DMM_SEASON_37585"
        
        init(_ parent: WebViewWindow) {
            self.parent = parent
        }
        
        // Observe WKWebview
        func addWebViewObserver() {
            parent.webView.addObserver(self, forKeyPath: "URL", options: .new, context: nil)
        }
    
        /// Using observer due to DT web page doesn't allow somehow to get the requested url
        override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
            if object as AnyObject? === parent.webView && keyPath == "URL" {
                if parent.webView.url?.absoluteString == path {
                    openWindow(id: "Object")
                } else if parent.webView.url?.absoluteString != path {
                    dismissWindow(id: "Object")
                }
            }
        }
        
        
        ///
        ///
        ///
        ///
        ///
        /// 
        func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
            
            if let response = navigationResponse.response as? HTTPURLResponse {
                if response.statusCode == 401 {
                    decisionHandler(.cancel)
                } else {
                    decisionHandler(.allow)
                }
            } else {
                decisionHandler(.cancel)
            }
        }
        
        /// If the web page allow to track the url requested, use this method
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            if navigationAction.navigationType == .linkActivated  {
                    decisionHandler(.cancel)
            } else {
                print("not a user click")
                if navigationAction.navigationType == .linkActivated {
                    if let _ = navigationAction.request.url {
                        decisionHandler(.allow)
                    }
                } else if navigationAction.navigationType == .other {
                    if let _ = navigationAction.request.url {
                        decisionHandler(.allow)
                    }
                } else {
                    decisionHandler(.cancel)
                }
            }
        }
        
        func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
            guard let url = webView.url else { return }
            DispatchQueue.main.async {
                webView.load(URLRequest(url: url))
            }
        }
        
        func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
            // Intercept target=_blank links
            guard
                navigationAction.targetFrame == nil,
                let url = navigationAction.request.url else {
                return nil
            }
            
            let request = URLRequest(url: url)
            webView.load(request)
            
            return nil
        }
        
        
    }
    
}

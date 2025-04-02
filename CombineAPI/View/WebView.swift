//
//  WebView.swift
//  CombineAPI
//
//  Created by Ahmed Hamza on 3/4/25.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: URL(string: "https://www.facebook.com")!)
        uiView.load(request)
    }
    
    typealias UIViewType = WKWebView
    
    
    
}

#Preview {
    WebView()
}

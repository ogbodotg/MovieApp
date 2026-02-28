//
//  YoutubePlayer.swift
//  MovieApp
//
//  Created by OGBODO on 24/02/2026.
//

import SwiftUI
import WebKit

struct YoutubePlayer: UIViewRepresentable {
    let videoId: String
//    let youtubeTrailerURL = APIConfig.shared?.youtubeTrailerURL
    
    func makeUIView(context: Context) -> WKWebView {
        let config = WKWebViewConfiguration()
        config.allowsInlineMediaPlayback = true
//        config.mediaTypesRequiringUserActionForPlayback = []
        
        let webView = WKWebView(frame: .zero, configuration: config)
        webView.scrollView.isScrollEnabled = false
        webView.isOpaque = false
        webView.backgroundColor = .clear
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context){
        let html = """
                <!doctype html>
                <html>
                  <head>
                    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0">
                    <style>
                      html, body { margin:0; padding:0; background-color: transparent; }
                      .video-container { position: fixed; top:0; left:0; right:0; bottom:0; }
                      iframe { width:100%; height:100%; border:0; }
                    </style>
                  </head>
                  <body>
                    <div class="video-container">
                      <iframe
                        src="https://www.youtube.com/embed/\(videoId)?playsinline=1&modestbranding=1&rel=0"
                        allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
                        allowfullscreen>
                      </iframe>
                    </div>
                  </body>
                </html>
                """
                webView.loadHTMLString(html, baseURL: nil)
    }
}

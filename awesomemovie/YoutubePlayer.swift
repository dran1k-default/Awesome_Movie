import SwiftUI
import WebKit

struct YoutubePlayer: UIViewRepresentable {
    let videoId: String
    let youtubeBaseURL = APIConfig.shared?.youtubeBaseURL
    
    func makeUIView(context: Context) -> WKWebView {
        let configuration = WKWebViewConfiguration()
        configuration.allowsInlineMediaPlayback = true
        
        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.navigationDelegate = context.coordinator
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let baseURLString = youtubeBaseURL,
              let baseURL = URL(string: baseURLString) else { return }
        
        let fullURL = baseURL.appending(path: videoId)
        let request = URLRequest(url: fullURL)
        
        uiView.load(request)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            if let url = navigationAction.request.url,
               url.host?.contains("youtube") == true,
               navigationAction.request.value(forHTTPHeaderField: "Referer") == nil {
                
                var newRequest = navigationAction.request
                let fakeDomain = "https://google.com"
                
                newRequest.setValue(fakeDomain, forHTTPHeaderField: "Referer")
                newRequest.setValue(fakeDomain, forHTTPHeaderField: "Origin")
                
                webView.load(newRequest)
                decisionHandler(.cancel)
                return
            }
            decisionHandler(.allow)
        }
        
        func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
            if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust {
                if let serverTrust = challenge.protectionSpace.serverTrust {
                    completionHandler(.useCredential, URLCredential(trust: serverTrust))
                    return
                }
            }
            completionHandler(.performDefaultHandling, nil)
        }
    }
}


//
//  LoginWebView.swift
//  ActivitiesSound
//
//  Created by Khanh Thieu on 13/11/2021.
//

import SwiftUI
import UIKit
import WebKit
import Combine

struct LoginWebView: View {
    @ObservedObject var model: LoginViewModel
    var body: some View {
        WebView(model: model, request: URLRequest(url: AuthManager.shared.signInURL!))
                .ignoresSafeArea()
        
    }
}
struct LoginWebView_Previews: PreviewProvider {
    static var previews: some View {
        LoginWebView(model: LoginViewModel())
    }
}
struct WebView: UIViewRepresentable{
    @ObservedObject var model : LoginViewModel
    let request: URLRequest
    let webView = WKWebView()
    func makeUIView(context: UIViewRepresentableContext<WebView>) -> WKWebView {
        webView.configuration.defaultWebpagePreferences.allowsContentJavaScript = true
        self.webView.navigationDelegate = context.coordinator
        self.webView.load(request)
        return self.webView
    }
    func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<WebView>) {
        return
    }
    class Coordinator: NSObject, WKNavigationDelegate{
        @ObservedObject var model : LoginViewModel
        init(_ model: LoginViewModel){
            self.model = model
        }
        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            guard let url = webView.url else { return}
            let component = URLComponents(string: url.absoluteString)
            guard let code = component?.queryItems?.first(where: {$0.name == "code"})?.value else {return}
            print("Code:\(code)")
            AuthManager.shared.exchangeCodeForToken(code: code){ [weak self] success in
                DispatchQueue.main.async {
                    print("Success")
                    self!.model.isloggedIn = true
                }
            }
        }
    }
    func makeCoordinator() -> WebView.Coordinator {
        Coordinator(model)
    }
}


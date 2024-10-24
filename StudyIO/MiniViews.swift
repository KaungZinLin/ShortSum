//
//  MiniViews.swift
//  StudyIO
//
//  Created by Kaung Zin Lin on 02/07/2024.
//

import SwiftUI
import WebKit

var websiteURL: String = ""

struct TopView: View {
    let title: LocalizedStringResource
    let description: LocalizedStringResource
    let sfSymbol: String
    
    var body: some View {
        VStack {
            VStack(alignment: .center) {
                Image(systemName: sfSymbol)
                    .foregroundColor(.accent)
                    .font(.system(size: 30))
                
                Text(title)
                    .font(.title2)
                    .bold()
                    .multilineTextAlignment(.center)
                Text(description)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.secondary)
            }
            .padding()
        }
        .frame(maxWidth: .infinity, alignment: .center)
    }
}

struct TranslatorView: View {
    let name: LocalizedStringResource
    let description: LocalizedStringResource

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                VStack(alignment: .leading) {
                    Text(name)
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                    
                    Text(description)
                        .foregroundColor(.secondary)
                }
            }
        }
    }
}


struct ExternalPackageView: View {
    let title: LocalizedStringResource
    let url: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
            }
            
            Spacer()
            
            Link(destination: URL(string: url)!) {
                Image(systemName: "arrow.up.right.square")
            }
        }
        .padding(.vertical, 4)
    }
}

struct WarningsView: View {
    let text: LocalizedStringResource
    let sfSymbol: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(LinearGradient(gradient: Gradient(colors: [Color.red.opacity(0.8), Color.orange]), startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(height: 100)
                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
            
            HStack {
                if #available(iOS 17.0, *) {
                    Image(systemName: sfSymbol)
                        .symbolEffect(.variableColor)
                        .foregroundStyle(.white)
                        .bold()
                    
                    Text(text)
                        .font(.headline)
                        .bold()
                        .foregroundStyle(.white)
                } else {
                    Image(systemName: sfSymbol)
                        .foregroundColor(.white)
                        .bold()
                    
                    Text(text)
                        .font(.headline)
                        .bold()
                        .foregroundColor(.white)
                }
            }
            .padding()
        }
        .padding(.horizontal)
    }
}

struct StyledButton: View {
    let title: LocalizedStringResource
    let action: () -> Void
    let gradientColors: [Color] // New property for custom gradient colors

    var body: some View {
        Button(action: action) {
            ZStack {
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .fill(LinearGradient(gradient: Gradient(colors: gradientColors), startPoint: .topLeading, endPoint: .bottomTrailing))
                    .frame(width: 200, height: 50)
                    .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
                
                Text(title)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}
struct WebView: UIViewRepresentable {
    let webView: WKWebView
    
    init() {
        webView = WKWebView(frame: .zero)
    }
    
    func makeUIView(context: Context) -> WKWebView {
        return webView
    }
    func updateUIView(_ uiView: WKWebView, context: Context) {
        webView.load(URLRequest(url: URL(string: "https://images.google.com/")!))
    }
}

struct ColorfulIconLabelStyle: LabelStyle {
    var color: Color
    
    func makeBody(configuration: Configuration) -> some View {
        Label {
            configuration.title
        } icon: {
            configuration.icon
                .font(.system(size: 13))
                .foregroundColor(.white)
                .background(RoundedRectangle(cornerRadius: 7).frame(width: 28, height: 28).foregroundColor(color))
        }
    }
}

struct CustomButton: View {
    let title: LocalizedStringResource
    let action: () -> Void
    let gradientColors: [Color]
    let cornerRadius: CGFloat
    let height: CGFloat
    let width: CGFloat

    var body: some View {
        Button(action: action) {
            ZStack {
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .fill(LinearGradient(gradient: Gradient(colors: gradientColors), startPoint: .topLeading, endPoint: .bottomTrailing))
                    .frame(width: width, height: height)
                    .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
                
                Text(title)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct ImageSearchView: View {
    @State var websiteURL: String = ""
    
    var body: some View {
        VStack {
            WebView()
        }
        .navigationTitle("Image Search")
        .navigationBarTitleDisplayMode(.inline)
    }
}

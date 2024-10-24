//
//  WebsiteSummarizer.swift
//  StudyIO
//
//  Created by Kaung Zin Lin on 26/07/2024.
//

import SwiftUI

struct WebsiteSummarizer: View {
    @StateObject var viewModel = UniversalAIViewModel()
    @State private var websiteURL: String = ""
    @State private var isShowingSheet: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                Spacer()
                
                VStack(alignment: .center) {
                    TextField("What's the article link?", text: $websiteURL)
                        .font(.custom("Baskerville-Bold", size: 25))
                        .padding()
                        .multilineTextAlignment(.center)
                }
                .frame(maxWidth: .infinity, alignment: .center)
                
                StyledButton(title: "Summarize", action: {
                    viewModel.checkTextFields(input: websiteURL)
                    
                    if viewModel.isInputEmpty {
                        viewModel.showAlerts(text: "Please fill in all the fields!", icon: "error", haptic: "error")
                    } else {
                        isShowingSheet = true
                    }
                }, gradientColors: [Color.purple.opacity(0.8), Color.accent])
                        
                Spacer()
                Spacer()
                
            }
            .navigationTitle("Article Summarizer")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $isShowingSheet) {
                SummarizedPageView(userURL: websiteURL)
                    .accentColor(.accent)
            }
            .toolbar {
                ToolbarItemGroup(placement: .primaryAction) {
                    Button {
                        hideInputKeyboard()
                    } label: {
                        Image(systemName: "keyboard.chevron.compact.down")
                    }
                }
            }
        }
    }
}

#Preview {
    WebsiteSummarizer()
}

#if canImport(UIKit)
extension View {
    func hideInputKeyboardTwo() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

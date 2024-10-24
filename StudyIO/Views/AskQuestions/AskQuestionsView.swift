//
//  AskQuestionsView.swift
//  StudyIO
//
//  Created by Kaung Zin Lin on 23/06/2024.
//

import SwiftUI
import AlertKit

struct AskQuestionsView: View {
    @StateObject var viewModel = UniversalAIViewModel()
    @State var question: String = ""
    @State var isShowingSheet = false
    
    var body: some View {
        VStack {
            Spacer()
            
            VStack(alignment: .center) {
                TextField("Ask AI", text: $question)
                    .font(.custom("Baskerville-Bold", size: 25))
                    .padding()
                    .multilineTextAlignment(.center)
            }
            .frame(maxWidth: .infinity, alignment: .center)
            
            StyledButton(title: "Ask", action: {
                viewModel.checkTextFields(input: question)
                if viewModel.isInputEmpty {
                    viewModel.showAlerts(text: "Please fill in all the fields!", icon: "error", haptic: "error")
                } else {
                    isShowingSheet = true
                }
            }, gradientColors: [Color.blue.opacity(0.8), Color.orange])
            
            Spacer()
        }
        .navigationTitle("Ask Questions")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $isShowingSheet, content: {
            ResultsView(yourQuestion: question)
                .accentColor(.accent)
        })
        .toolbar {
            ToolbarItemGroup(placement: .primaryAction) {
                Button {
                    hideKeyboard()
                } label: {
                    Image(systemName: "keyboard.chevron.compact.down")
                }
            }
        }
    }
}

#Preview {
    AskQuestionsView()
}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

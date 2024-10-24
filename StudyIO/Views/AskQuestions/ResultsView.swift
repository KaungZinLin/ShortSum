//  ResultsView.swift
//  StudyIO
//
//  Created by Kaung Zin Lin on 12/07/2024.
//

import SwiftUI

struct ResultsView: View {
    @State var yourQuestion: String = ""
    @StateObject var viewModel = UniversalAIViewModel()
    @State private var aboutToShareText: String = ""
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Section("Your Question") {
                        Text(yourQuestion)
                    }
                    
                    Section("Answer") {
                        ScrollView {
                            switch viewModel.state {
                            case .idle:
                                ProgressView()
                                
                            case .generate(let answer):
                                Text("\(answer)")
                                ShareLink(item: "\(answer)") {
                                    Text("Share")
                                }
                                
                            case .translated(let translatedText):
                                Text("\(translatedText)")
                                ShareLink(item: "\(translatedText)") {
                                    Text("Share")
                                }
                                
                            case .failed:
                                Text("Cannot generate your answer!")
                                    .foregroundColor(.red)
                            case .noAPI:
                                Text("No OpenAI API Key detected!")
                                    .foregroundColor(.red)
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Your Answer")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                        Button("Close") {
                            dismiss()
                        }
                    }
                
                ToolbarItem(placement: .automatic) {
                    Button(action: {
                        switch viewModel.state {
                        case .idle:
                            viewModel.speakOut(text: "")
                        case .generate(let answer):
                            viewModel.speakOut(text: answer)
                        case .translated(let translatedText):
                            viewModel.speakOut(text: translatedText)
                        case .failed:
                            viewModel.speakOut(text: "Cannot generate your answer!")
                        case .noAPI:
                            viewModel.speakOut(text: "No OpenAI API Key!")
                        }
                    }) {
                        Image(systemName: "speaker.wave.2.fill")
                    }
                }
            }
            .onAppear {
               Task {
                   await viewModel.generateOutput(inputPrompt: yourQuestion)
               }
               
               viewModel.checkTextFields(input: yourQuestion)
           }
        }
    }
}

#Preview {
    ResultsView()
}

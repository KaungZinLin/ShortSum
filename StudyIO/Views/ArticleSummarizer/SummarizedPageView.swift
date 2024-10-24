//
//  SummarizedPageView.swift
//  StudyIO
//
//  Created by Kaung Zin Lin on 26/07/2024.
//

import SwiftUI

struct SummarizedPageView: View {
    @StateObject var viewModel = UniversalAIViewModel()
    @State var userURL: String = ""
    @Environment(\.dismiss) var dismiss
    @State var aboutToShareText: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Section {
                        Button("Summarize") {
                            Task {
                                await viewModel.summarizeWebsite(extractedTextInput: "Can you summarize this website for me? \(viewModel.websiteText)")
                            }
                        }
                    }
                    
                    Section("Summary") {
                        ScrollView {
                            switch viewModel.state {
                            case .idle:
                                Text("Summarized Results will appear here.")
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
                                Text("Cannot Summarize!")
                                    .foregroundColor(.red)
                            case .noAPI:
                                Text("No OpenAI API Key Detected!")
                                    .foregroundColor(.red)
                            }
                        }
                        .padding()
                        
                    }
                    
                    Section("Original Website") {
                        Text(viewModel.websiteText)
                    }
                }
            }
            .navigationTitle("Ready to Summarize")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                viewModel.fetchHTML(from: userURL)
            }
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
        }
    }
}

#Preview {
    SummarizedPageView()
}

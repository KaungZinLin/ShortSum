//
//  ScanView.swift
//  StudyIO
//
//  Created by Kaung Zin Lin on 14/06/2024.
//

import SwiftUI

struct ScanView: View {
    @StateObject var viewModel = UniversalAIViewModel()
    @State private var qAndATextFromOCR: String = ""
    let scanTexts: [ScanData]
    @State private var aboutToShareText: String = ""
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Section("Summarized Results") {
                        ScrollView {
                            switch viewModel.state {
                            case .idle:
                                ProgressView()
                            case .generate(let summary):
                                Text("\(summary)")
                                ShareLink(item: "\(summary)")
                            case .translated(let translatedText):
                                Text("\(translatedText)")
                                ShareLink(item: "\(translatedText)")
                            case .failed:
                                Text("Cannot summarize")
                                    .foregroundColor(.red)
                                NavigationLink("Add an OpenAI API Key", destination: OpenAIAPIKeyManagement())
                            case .noAPI:
                                Text("No OpenAI API Key detected")
                                    .foregroundColor(.red)
                                NavigationLink("Add an OpenAI API Key", destination: OpenAIAPIKeyManagement())
                            }
                        }
                        .padding()
                    }
                }
                .navigationTitle("Scanned Results")
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
                    qAndATextFromOCR = scanTexts.map { $0.content }.joined(separator: "\n\n")
                    viewModel.checkTextFields(input: qAndATextFromOCR)
                    
                    if viewModel.isInputEmpty {
                        dismiss()
                        viewModel.showAlerts(text: "No text detected!", icon: "error", haptic: "error")
                    } else {
                        Task {
                            await viewModel.generateOutput(inputPrompt: "Summarize the following question and answer into bullet points that is easy to understand and simple. If the answer doesn't seem right, feel free to correct it with your knowledge. Also, please give me a short paragaph summary as well. Here is the question and answer: \(qAndATextFromOCR)"
                            )
                        }
                    }
                }
            }
        }
    }
}


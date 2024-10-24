//
//  HDScanView.swift
//  StudyIO
//
//  Created by Kaung Zin Lin on 20/06/2024.
//

import SwiftUI
import AlertKit

struct HDScanView: View {
    @StateObject var viewModel = UniversalAIViewModel()
    @State private var qAndATextFromOCR: String = ""
    let scanTexts: [ScanData]
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Section("Detected Results") {
                        ScrollView {
                            switch viewModel.state {
                            case .idle:
                                ProgressView()
                            case .generate(let detectedText):
                                Text("\(detectedText)")
                                ShareLink(item: "\(detectedText)")
                            case .translated(let translatedText):
                                Text("\(translatedText)")
                                ShareLink(item: "\(translatedText)")
                            case .failed:
                                Text("Cannot Detect!")
                                    .foregroundStyle(.red)
                            case .noAPI:
                                Text("No OpenAI API Key Detected!")
                                    .foregroundStyle(.red)
                                NavigationLink("Add OpenAI API Key", destination: OpenAIAPIKeyManagement())
                            }
                        }
                        .padding()
                    }
                }
                .navigationTitle("Detected Results")
                .onAppear {
                    qAndATextFromOCR = scanTexts.map { $0.content }.joined(separator: "\n\n")
                    
                    viewModel.checkTextFields(input: qAndATextFromOCR)
                    
                    if viewModel.isInputEmpty {
                        dismiss()
                        viewModel.showAlerts(text: "No text detected!", icon: "error", haptic: "error")
                    } else {
                        Task {
                            await viewModel.generateOutput(inputPrompt: "Can you please look at the following handwriting that is extracted from a badly-written page? Use your knowledge to see what the writer is writing about. Also, give summarized questions with the most important points and short paragaph summary as well.\(qAndATextFromOCR)"
                            )
                        }
                    }
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
}


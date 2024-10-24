//
//  PrimesView.swift
//  StudyIO
//
//  Created by Kaung Zin Lin on 04/08/2024.
//

import SwiftUI

struct PrimesView: View {
    @State private var startRange: String = ""
    @State private var endRange: String = ""
    @StateObject var viewModel = UniversalAIViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Section {
                        VStack(alignment: .leading) {
                            Text("Type in the starting range")
                                .fontDesign(.rounded)
                                .bold()
                            
                            TextField("100", text: $startRange)
                                .keyboardType(.numberPad)
                        }
                        
                        VStack(alignment: .leading) {
                            Text("Type in the ending range")
                                .fontDesign(.rounded)
                                .bold()
                            
                            TextField("200", text: $endRange)
                                .keyboardType(.numberPad)
                        }
                        
                        Button("Find Prime Numbers") {
                            if startRange.isEmpty || endRange.isEmpty {
                                viewModel.showAlerts(text: "Please fill in all the fields!", icon: "error", haptic: "error")
                            } else {
                                Task {
                                    await viewModel.generateOutput(inputPrompt: "Can you tell me the prime numbers between \(startRange) and \(endRange)? Please give me the answer in this format: The Prime Numbers between [startRange] and [endRange] are ...")
                                }
                            }
                        }
                        
                        Button("Find Non-Prime Numbers") {
                            if startRange.isEmpty || endRange.isEmpty {
                                viewModel.showAlerts(text: "Please fill in all the fields!", icon: "error", haptic: "error")
                            } else {
                                Task {
                                    await viewModel.generateOutput(inputPrompt: "Can you tell me the non-prime numbers between \(startRange) and \(endRange)? Please give me the answer in this format: The Prime Numbers between [startRange] and [endRange] are ...")
                                }
                            }
                        }
                    }
                    
                    Section(header: Text("Results")) {
                        switch viewModel.state {
                        case .idle:
                            Text("Results will appear here.")
                        case .generate(let detectedText):
                            if detectedText == "Hello! How can I assist you today?" {
                                Text("Failed! Retry.")
                            } else {
                                Text(detectedText)
                            }
                            
                            ShareLink(item: "\(detectedText)")
                        case .translated(let translatedText):
                           Text(translatedText)
                            ShareLink(item: "\(translatedText)")
                        case .failed:
                            Text("Cannot Generate!")
                                .foregroundStyle(.red)
                        case .noAPI:
                            Text("No OpenAI API Key Detected!")
                                .foregroundStyle(.red)
                            NavigationLink("Add OpenAI API Key", destination: OpenAIAPIKeyManagement())
                        }
                    }
                }
            }
            .navigationTitle("Find Primes")
            .navigationBarTitleDisplayMode(.inline)
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
}

#Preview {
    PrimesView()
}

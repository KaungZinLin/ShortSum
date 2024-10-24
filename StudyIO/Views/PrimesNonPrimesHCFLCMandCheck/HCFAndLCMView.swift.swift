//
//  HCFAndLCMView.swift
//  StudyIO
//
//  Created by Kaung Zin Lin on 04/08/2024.
//

import SwiftUI

struct HCFAndLCMView: View {
    @StateObject var viewModel = UniversalAIViewModel()
    @State private var numberInput: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Section {
                        VStack(alignment: .leading) {
                            Text("Type in two or more numbers")
                                .fontDesign(.rounded)
                                .bold()
                            
                            TextField("25, 6, 2", text: $numberInput)
                                .keyboardType(.numbersAndPunctuation)
                        }
                        
                        Button("Check Prime") {
                            if numberInput.isEmpty {
                                viewModel.showAlerts(text: "Please fill in all the fields!", icon: "error", haptic: "error")
                            } else {
                                Task {
                                    await viewModel.generateOutput(inputPrompt: "Is \(numberInput) a Prime Number or not?")
                                }
                            }
                        }
                        
                        Button("Find the Highest Common Factors") {
                            if numberInput.isEmpty {
                                viewModel.showAlerts(text: "Please fill in all the fields!", icon: "error", haptic: "error")
                            } else {
                                Task {
                                    await viewModel.generateOutput(inputPrompt: "Can you tell me the HCF of \(numberInput)? Please give me the answer in this format: The Highest Common Factors of [numbers] are ...")
                                }
                            }
                        }
                        
                        Button("Find the Lowest Common Multiple") {
                            if numberInput.isEmpty {
                                viewModel.showAlerts(text: "Please fill in all the fields!", icon: "error", haptic: "error")
                            } else {
                                Task {
                                    await viewModel.generateOutput(inputPrompt: "Can you tell me the LCM of \(numberInput)? Please give me the answer in this format: The Highest Common Factors of [numbers] are ...")
                                }
                            }
                        }
                    }
                    
                    Section(header: Text("Results"))  {
                        switch viewModel.state {
                        case .idle:
                            Text("Results will appear here.")
                        case .generate(let detectedText):
                            Text(detectedText)
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
            .navigationTitle("Check and HCF/LCM")
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
    HCFAndLCMView()
}

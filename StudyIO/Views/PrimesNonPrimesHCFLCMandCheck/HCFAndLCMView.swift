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
    @State var aIPromptToPass: String = ""
    @State private var isShowingSheet: Bool = false
    
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
                                aIPromptToPass = "Is \(numberInput) a Prime Number or not?"
                                
                                isShowingSheet = true
                            }
                        }
                        
                        Button("Find the Highest Common Factors") {
                            if numberInput.isEmpty {
                                viewModel.showAlerts(text: "Please fill in all the fields!", icon: "error", haptic: "error")
                            } else {
                                aIPromptToPass = "Can you tell me the HCF of \(numberInput)? Please give me the answer in this format: The Highest Common Factors of [numbers] are ..."
                                
                                isShowingSheet = true
                            }
                        }
                        
                        Button("Find the Lowest Common Multiple") {
                            if numberInput.isEmpty {
                                viewModel.showAlerts(text: "Please fill in all the fields!", icon: "error", haptic: "error")
                            } else {
                                aIPromptToPass = "Can you tell me the LCM of \(numberInput)? Please give me the answer in this format: The Highest Common Factors of [numbers] are ..."
                                
                                isShowingSheet = true
                            }
                        }
                    }
                }
            }
            .navigationTitle("Check and HCF/LCM")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $isShowingSheet, content: {
                PrimesResultsView(aIPrompt: aIPromptToPass)
                    .accentColor(.accent)
                    .presentationDetents([.height(400)])
            })
        }
    }
}

#Preview {
    HCFAndLCMView()
}

//
//  RecheckResultsView.swift
//  StudyIO
//
//  Created by Kaung Zin Lin on 03/08/2024.
//

import SwiftUI

struct RecheckResultsView: View {
    @StateObject var viewModel = UniversalAIViewModel()
    @Environment(\.dismiss) var dismiss
    @State var questionToCheck: String = ""
    @State var answerToCheck: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Section {
                        VStack(alignment: .leading) {
                            Text("YOU GOT ")
                                .font(.headline)
                                .foregroundStyle(.secondary)
                            switch viewModel.state {
                            case .idle:
                                ProgressView()
                            case .generate(let summary):
                                Text("\(summary)")
                                    .font(.largeTitle)
                                    .fontDesign(.rounded)
                                    .bold()
                                if summary == "10/10" {
                                    Text("Excellent! You're absolutely ready for the exams. Keep up the great work!")
                                } else if summary == "9/10" {
                                    Text("Great job! You're almost there. A bit more polish and you'll be perfect!")
                                } else if summary == "8/10" {
                                    Text("Very good effort! You're doing well, just a few minor improvements needed.")
                                } else if summary == "7/10" {
                                    Text("Good work! With a little more focus on the details, you'll be in great shape.")
                                } else if summary == "6/10" {
                                    Text("Nice attempt! You're on the right track, but there's room for some fine-tuning.")
                                } else if summary == "5/10" {
                                    Text("Decent effort! You're halfway there. Some more practice will help you improve.")
                                } else if summary == "4/10" {
                                    Text("Not bad, but there's definitely room for improvement. Keep working on it!")
                                } else if summary == "3/10" {
                                    Text("You've made a start, but there's quite a bit to work on. Don't give up, keep practicing!")
                                } else if summary == "2/10" {
                                    Text("There's a lot to work on here. Keep studying and practicing, you can do it!")
                                } else if summary == "1/10" {
                                    Text("It's clear you're struggling with this. Let's go over the material again and try to identify where you're having difficulties.")
                                }
                                
                            case .translated(let translatedText):
                                Text("\(translatedText)")
                                    .font(.largeTitle)
                                    .fontDesign(.rounded)
                                    .bold()
                                if translatedText == "10/10" {
                                    Text("Excellent! You're absolutely ready for the exams. Keep up the great work!")
                                } else if translatedText == "9/10" {
                                    Text("Great job! You're almost there. A bit more polish and you'll be perfect!")
                                } else if translatedText == "8/10" {
                                    Text("Very good effort! You're doing well, just a few minor improvements needed.")
                                } else if translatedText == "7/10" {
                                    Text("Good work! With a little more focus on the details, you'll be in great shape.")
                                } else if translatedText == "6/10" {
                                    Text("Nice attempt! You're on the right track, but there's room for some fine-tuning.")
                                } else if translatedText == "5/10" {
                                    Text("Decent effort! You're halfway there. Some more practice will help you improve.")
                                } else if translatedText == "4/10" {
                                    Text("Not bad, but there's definitely room for improvement. Keep working on it!")
                                } else if translatedText == "3/10" {
                                    Text("You've made a start, but there's quite a bit to work on. Don't give up, keep practicing!")
                                } else if translatedText == "2/10" {
                                    Text("There's a lot to work on here. Keep studying and practicing, you can do it!")
                                } else if translatedText == "1/10" {
                                    Text("It's clear you're struggling with this. Let's go over the material again and try to identify where you're having difficulties.")
                                }
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
                    }
                }
            }
            .navigationTitle("Your Results")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                        Button("Close") {
                            dismiss()
                        }
                    }
            }
            .onAppear {
                if questionToCheck.isEmpty || answerToCheck.isEmpty {
                    dismiss()
                    viewModel.showAlerts(text: "Please fill in the all the textfields on the previous view!", icon: "error", haptic: "error")
                } else {
                    Task {
                        await viewModel.generateOutput(inputPrompt: "Here is the original question: \(questionToCheck) and here is my answer: \(answerToCheck). Can you please check it so that the answer is suitable for the question and give me a score out of 10 to make sure that I am really ready for the exams? NOTE: Just give me the rating like 3/10 and no explanation please.")
                    }
                }
            }
        }
    }
}

#Preview {
    RecheckResultsView()
}

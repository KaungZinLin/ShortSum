//
//  RecheckView.swift
//  StudyIO
//
//  Created by Kaung Zin Lin on 03/08/2024.
//

import SwiftUI
import UIKit

struct RecheckView: View {
    @State private var originalQuestion: String = ""
    @State private var yourAnswer: String = ""
    @State private var isShowingSheet: Bool = false
    
    var body: some View {
        VStack {
            Form {
                Section(footer: Text("Please note: This score is just for checking your understanding right now. To achieve good grades in your exams, you need to answer everything correctly. Keep practicing and studying to ensure you're fully prepared!")) {
                    VStack(alignment: .leading) {
                        Text("Original Question:")
                            .fontDesign(.rounded)
                            .bold()
                        
                        TextField("Why did the Soviet Union fail?", text: $originalQuestion)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Your Answer:")
                            .fontDesign(.rounded)
                            .bold()
                        
                        TextField("The Soviet Union failed...", text: $yourAnswer)
                            .frame(height: 100)
                    }
                    
                    Button("Check") {
                        isShowingSheet = true
                    }
                }
            }
            .navigationTitle("Recheck")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $isShowingSheet, content: {
                RecheckResultsView(questionToCheck: originalQuestion, answerToCheck: yourAnswer)
                    .accentColor(.accent)
                    .presentationDetents([.height(400)])
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
}

#Preview {
    RecheckView()
}

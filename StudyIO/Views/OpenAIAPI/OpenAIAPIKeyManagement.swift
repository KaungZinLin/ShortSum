//
//  OpenAIAPIKeyManagement.swift
//  StudyIO
//
//  Created by Kaung Zin Lin on 13/06/2024.
//

import SwiftUI
import AlertKit

struct OpenAIAPIKeyManagement: View {
    @State var apiKey = ""
    @State private var showAlert = false
    
    var body: some View {
        VStack {
            Form {
                Section(footer: Text("Your OpenAI API Key is stored locally on your iPhone and only used when an AI feature is running.\n\nIf you would like to remove your OpenAI API Key, please type in random letters in the text field and it will override the existing key.")) {
                    
                    VStack(alignment: .leading) {
                        Text("OpenAI API Key:")
                            .fontDesign(.rounded)
                            .bold()
                        TextField("sk-test-12345A...", text: $apiKey)
                    }
                    
                    
                    Button("Save") {
                        if apiKey.isEmpty {
                            AlertKitAPI.present(
                                title: NSLocalizedString("Please fill in all the fields", comment: ""),
                                icon: .error,
                                style: .iOS16AppleMusic,
                                haptic: .error
                            )
                        } else {
                            UserDefaults.standard.setValue(apiKey, forKey: "openAIAPIKey")
                            showAlert = true
                        }
                    }
                }
            }

            .navigationTitle("OpenAI API Key")
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text(NSLocalizedString("Changes to the OpenAI API Key Detected", comment: "")),
                    message: Text(NSLocalizedString("Please restart the app to apply changes across the app", comment: "")),
                    primaryButton: .default(Text(NSLocalizedString("Restart Now", comment: "")), action: {
                        fatalError()
                    }),
                    secondaryButton: .cancel()
                )
            }
            .toolbar {
               ToolbarItemGroup(placement: .primaryAction) {
                   Button {
                       hideInputKeyboard()
                   } label: {
                       Image(systemName: "keyboard.chevron.compact.down")
                   }
               }
           }
        }
    }
}

#Preview {
    OpenAIAPIKeyManagement()
}

#if canImport(UIKit)
extension View {
    func hideInputKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

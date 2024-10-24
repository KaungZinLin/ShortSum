//
//  ChangeLanguageView.swift
//  StudyIO
//
//  Created by Kaung Zin Lin on 06/07/2024.
//

import SwiftUI

struct ChangeLanguageView: View {
    @StateObject private var viewModel = LanguageSettingsViewModel()
    @State private var showAlert = false
    
    var body: some View {
        VStack {
            Form {
                Section {
                    HStack {
                        Text("Translations powered by ") +
                        Text("G")
                            .foregroundColor(.blue) +
                        Text("o")
                            .foregroundColor(.red) +
                        Text("o")
                            .foregroundColor(.yellow) +
                        Text("g")
                            .foregroundColor(.blue) +
                        Text("l")
                            .foregroundColor(.green) +
                        Text("e")
                            .foregroundColor(.red)
                    }
                }
                
                Section("Language Selection") {
                    List(viewModel.languageMapping.keys.sorted(), id: \.self) { key in
                        HStack {
                            Text(key)
                            Spacer()
                            if viewModel.languageMapping[key] == viewModel.selectedLanguage {
                                Image(systemName: "checkmark")
                                    .foregroundStyle(.accent)
                                    .bold()
                            }
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            viewModel.selectedLanguage = viewModel.languageMapping[key]
                            showAlert = true
                        }
                    }
                }
            }
            .navigationTitle("Language Selection")
            .navigationBarTitleDisplayMode(.inline)
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text(NSLocalizedString("Changes to the Language Selection Detected", comment: "")),
                    message: Text(NSLocalizedString("Please restart the app to apply changes", comment: "")),
                    primaryButton: .default(Text(NSLocalizedString("Restart Now", comment: "")), action: {
                        fatalError()
                    }),
                    secondaryButton: .cancel()
                )
            }
        }
    }
}

#Preview {
    ChangeLanguageView()
}


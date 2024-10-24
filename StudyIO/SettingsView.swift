//
//  SettingsView.swift
//  StudyIO
//
//  Created by Kaung Zin Lin on 31/05/2024.
//

import SwiftUI

enum Theme: String, CaseIterable, Identifiable {
    case light = "Light"
    case dark = "Dark"
    case system = "System"

    var id: String { self.rawValue }
}

struct SettingsView: View {
    @State var alertTitle: String = ""
    @State var alertDescription: String = ""
    @State private var showAlert: Bool = false
    @State var apiKey: String = ""
    @StateObject var viewModel = HomeViewModel()
    @Environment(\.dismiss) var dismiss
    @AppStorage("selectedTheme") private var selectedTheme: Theme = .system
    let aiModelOptions: [String] = ["GPT-3.5 Turbo", "GPT-4", "GPT-4o"]
    @State private var selectedModel: AIModel = .gpt35Turbo
    private let userDefaultsKey = "selectedAIModel"
    let selectedLanguageModel = UserDefaults.standard.string(forKey: "selectedAIModel") ?? "GPT 3.5 Turbo"
    @State private var selectedLanguage = "Auto-Detect"
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    if viewModel.isAPIKeySaved {
                        
                    } else {
                        Section("Warning(s)") {
                            VStack(alignment: .leading) {
                                Text("No OpenAI API Key detected!")
                                    .font(.headline)
                                    .foregroundStyle(.red)
                                NavigationLink("Add an OpenAI API Key", destination: OpenAIAPIKeyManagement())
                            }
                        }
                    }

                    Section(header: Text("Artificial intelligence"), footer: Text("GPT-3.5 Turbo is ideal for general use. GPT-4 is the most advanced and costly model, while GPT-4o offers a more affordable alternative with greater capabilities than GPT-3.5 Turbo.")) {
                        NavigationLink(destination: OpenAIAPIKeyManagement()) {
                            Label("OpenAI API Key", systemImage: "key.fill")
                                .labelStyle(ColorfulIconLabelStyle(color: .green))
                        }
                        
                        Picker(selection: $selectedModel, label: VStack {
                            Label("AI Model", systemImage: "brain.fill")
                                .labelStyle(ColorfulIconLabelStyle(color: .red))
                        }) {
                            ForEach(AIModel.allCases) { model in
                                Text(model.rawValue).tag(model)
                            }
                        }
                        .onChange(of: selectedModel) { newValue in
                            saveSelectedModel()
                            showAlert = true
                        }
                    }
                    
                    Section(header: Text("Text-to-Speech"), footer: Text("ShortSum will detect the text-to-speech language and accent that needs to be used automatically depending on what language the AI generated. ")) {
                        Picker(selection: $selectedLanguage, label:
                            VStack {
                            Label("Language", systemImage: "speaker.3")
                                .labelStyle(ColorfulIconLabelStyle(color: .cyan))
                        }) {
                            Text("Auto-Detect")
                        }
                    }
                    
                    Section(header: Text("Language, Region, and Translations"), footer: Text("For unsupported languages, we use Google Translate to convert your input to English for the AI, then back to your language for the response. You can change the language that you would like for the AI to input/output from this button.")) {
                        Button(action: {
                            if let url = URL(string: UIApplication.openSettingsURLString) {
                                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                            }
                        }) {
                            Label("Change Interface Language", systemImage: "globe")
                                .labelStyle(ColorfulIconLabelStyle(color: .blue))
                        }
                        NavigationLink(destination: ChangeLanguageView()) {
                            Label("Choose Translation Language", systemImage: "bubble.left.and.text.bubble.right")
                                .labelStyle(ColorfulIconLabelStyle(color: .yellow))
                        }
                    }
                    
                    Section("Appearance") {
                        Picker(selection: $selectedTheme, label: VStack {
                            Label("Theme", systemImage: "paintbrush.fill")
                                .labelStyle(ColorfulIconLabelStyle(color: .purple))
                        }) {
                            ForEach(Theme.allCases) { theme in
                                Text(theme.rawValue)
                                    .tag(theme)
                            }
                        }
                    }
                    
                    Section("Other Information") {
                        NavigationLink(destination: OurTeamView()) {
                            Label("About", systemImage: "info.circle.fill")
                                .labelStyle(ColorfulIconLabelStyle(color: .orange))
                        }
                    }
                }
            }
            .navigationTitle("Settings")
            
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text(alertTitle),
                    message: Text(alertDescription),
                    dismissButton: .default(Text("OK"))
                )
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                        Button("Close") {
                            dismiss()
                        }
                    }
            }
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                loadSelectedModel()
                applyTheme(selectedTheme)
            }
            .onChange(of: selectedTheme) { newTheme in
                applyTheme(newTheme)
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text(NSLocalizedString("Updates to the AI Language Model Detected!", comment: "")),
                    message: Text(NSLocalizedString("Please Restart the App to Apply the Changes", comment: "")),
                    primaryButton: .default(Text(NSLocalizedString("Restart Now", comment: "")), action: {
                        fatalError()
                    }),
                    secondaryButton: .cancel()
                )
            }
        }
    }
    
    private func saveSelectedModel() {
            UserDefaults.standard.set(selectedModel.rawValue, forKey: userDefaultsKey)
        }
        
    private func loadSelectedModel() {
        if let savedModelName = UserDefaults.standard.string(forKey: userDefaultsKey),
           let savedModel = AIModel(rawValue: savedModelName) {
            selectedModel = savedModel
        }
    }
    
    private func applyTheme(_ theme: Theme) {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else {
            return
        }

        switch theme {
        case .light:
            window.overrideUserInterfaceStyle = .light
        case .dark:
            window.overrideUserInterfaceStyle = .dark
        case .system:
            window.overrideUserInterfaceStyle = .unspecified
        }
    }
}

#Preview {
    SettingsView()
}

enum AIModel: String, CaseIterable, Identifiable {
    case gpt35Turbo = "GPT-3.5 Turbo"
    case gpt4 = "GPT-4"
    case gpt4o = "GPT-4o"
    
    var id: String { self.rawValue }
}

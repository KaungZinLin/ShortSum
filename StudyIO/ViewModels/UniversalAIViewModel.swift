//
//  UniversalAIViewModel.swift
//  StudyIO
//
//  Created by Kaung Zin Lin on 02/07/2024.
//

import Foundation
import OpenAI
import SwiftyTranslate
import AlertKit
import AVFoundation
import SwiftSoup
import AVKit
import NaturalLanguage

@MainActor
class UniversalAIViewModel: ObservableObject {
    @Published var state: PromptState = .idle
    @Published var translatedOutput: String = ""
    @Published var texts:[ScanData] = []
    @Published var pdfData: Data?
    @Published var showScannerSheet = false
    @Published var isInputEmpty: Bool = false
    @Published var translatedInput: String = ""
    @Published var aboutToShareText: String = ""
    private let openAI: OpenAI
    let selectedOutputLanguage = UserDefaults.standard.string(forKey: "selectedLanguage") ?? "en"
    let selectedLanguageModel = UserDefaults.standard.string(forKey: "selectedAIModel") ?? "GPT 3.5 Turbo"
    var isFeatureUnlocked: Bool {
        if let regionCode = Locale.current.region?.identifier {
            return regionCode == "MM"
        }
        return false
    }
    @Published var websiteText: String = "Loading..."
    let recognizer = NLLanguageRecognizer()
    let speechSynthesizer = AVSpeechSynthesizer()
    
    init() {
        if let savedApiKey = UserDefaults.standard.string(forKey: "openAIAPIKey") {
            self.openAI = OpenAI(apiToken: savedApiKey)
        } else {
            state = .noAPI
            self.openAI = OpenAI(apiToken: "")
        }
    }
    
    func generateOutput(inputPrompt: String) async {
        if selectedLanguageModel == "GPT-3.5 Turbo" {
            if selectedOutputLanguage.lowercased() == "en" {
                state = .generate("")
                
                let chatQuery = ChatQuery(messages: [.init(role: .user, content: "\(inputPrompt)")!], model: .gpt3_5Turbo)
                
                do {
                    for try await result in openAI.chatsStream(query: chatQuery) {
                        if case let .generate(content) = state, let newText = result.choices.first?.delta.content {
                            state = .generate(content + newText)
                        }
                    }
                    
                    if selectedOutputLanguage.lowercased() != "en" {
                        if case let .generate(summary) = state {
                            await translate(textInput: summary, fromLanguage: "en", toLanguage: selectedOutputLanguage)
                        }
                    }
                } catch {
                    state = .failed
                }
            } else {
                state = .generate("")
                await translateInput(textInput: inputPrompt, fromLanguage: selectedOutputLanguage, toLanguage: "en")
                
                let chatQuery = ChatQuery(messages: [.init(role: .user, content: "\(translatedInput)")!], model: .gpt3_5Turbo)
                
                do {
                    for try await result in openAI.chatsStream(query: chatQuery) {
                        if case let .generate(content) = state, let newText = result.choices.first?.delta.content {
                            state = .generate(content + newText)
                        }
                    }
                    
                    if selectedOutputLanguage.lowercased() != "en" {
                        if case let .generate(summary) = state {
                            await translate(textInput: summary, fromLanguage: "en", toLanguage: selectedOutputLanguage)
                        }
                    }
                } catch {
                    state = .failed
                }
            }
        } else if selectedLanguageModel == "GPT-4" {
            if selectedOutputLanguage.lowercased() == "en" {
                state = .generate("")
                
                let chatQuery = ChatQuery(messages: [.init(role: .user, content: "\(inputPrompt)")!], model: .gpt4)
                
                do {
                    for try await result in openAI.chatsStream(query: chatQuery) {
                        if case let .generate(content) = state, let newText = result.choices.first?.delta.content {
                            state = .generate(content + newText)
                        }
                    }
                    
                    if selectedOutputLanguage.lowercased() != "en" {
                        if case let .generate(summary) = state {
                            await translate(textInput: summary, fromLanguage: "en", toLanguage: selectedOutputLanguage)
                        }
                    }
                } catch {
                    state = .failed
                }
            } else {
                state = .generate("")
                await translateInput(textInput: inputPrompt, fromLanguage: selectedOutputLanguage, toLanguage: "en")
                
                let chatQuery = ChatQuery(messages: [.init(role: .user, content: "\(translatedInput)")!], model: .gpt4)
                
                do {
                    for try await result in openAI.chatsStream(query: chatQuery) {
                        if case let .generate(content) = state, let newText = result.choices.first?.delta.content {
                            state = .generate(content + newText)
                        }
                    }
                    
                    if selectedOutputLanguage.lowercased() != "en" {
                        if case let .generate(summary) = state {
                            await translate(textInput: summary, fromLanguage: "en", toLanguage: selectedOutputLanguage)
                        }
                    }
                } catch {
                    state = .failed
                }
            }
        } else if selectedLanguageModel == "GPT-4o" {
            if selectedOutputLanguage.lowercased() == "en" {
                state = .generate("")
                
                let chatQuery = ChatQuery(messages: [.init(role: .user, content: "\(inputPrompt)")!], model: .gpt4_o)
                
                do {
                    for try await result in openAI.chatsStream(query: chatQuery) {
                        if case let .generate(content) = state, let newText = result.choices.first?.delta.content {
                            state = .generate(content + newText)
                        }
                    }
                    
                    if selectedOutputLanguage.lowercased() != "en" {
                        if case let .generate(summary) = state {
                            await translate(textInput: summary, fromLanguage: "en", toLanguage: selectedOutputLanguage)
                        }
                    }
                } catch {
                    state = .failed
                }
            } else {
                state = .generate("")
                await translateInput(textInput: inputPrompt, fromLanguage: selectedOutputLanguage, toLanguage: "en")
                
                let chatQuery = ChatQuery(messages: [.init(role: .user, content: "\(translatedInput)")!], model: .gpt4_o)
                
                do {
                    for try await result in openAI.chatsStream(query: chatQuery) {
                        if case let .generate(content) = state, let newText = result.choices.first?.delta.content {
                            state = .generate(content + newText)
                        }
                    }
                    
                    if selectedOutputLanguage.lowercased() != "en" {
                        if case let .generate(summary) = state {
                            await translate(textInput: summary, fromLanguage: "en", toLanguage: selectedOutputLanguage)
                        }
                    }
                } catch {
                    state = .failed
                }
            }
        }
        
    }
    
    func translateInput(textInput: String, fromLanguage: String, toLanguage: String) async {
        do {
            let translation = try await withCheckedThrowingContinuation { continuation in
                SwiftyTranslate.translate(text: textInput, from: fromLanguage, to: toLanguage) { result in
                    switch result {
                    case .success(let translation):
                        continuation.resume(returning: translation)
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
            }
            translatedInput = translation.translated
        } catch {
            translatedInput = "Error Translating!"
        }
    }

    func translate(textInput: String, fromLanguage: String, toLanguage: String) async {
        do {
            let translation = try await withCheckedThrowingContinuation { continuation in
                SwiftyTranslate.translate(text: textInput, from: fromLanguage, to: toLanguage) { result in
                    switch result {
                    case .success(let translation):
                        continuation.resume(returning: translation)
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
            }
            translatedOutput = translation.translated
            state = .translated(translatedOutput)
        } catch {
            translatedOutput = "Error Translating!"
            state = .failed
        }
    }
    
    func checkTextFields(input: String) {
        if input.isEmpty {
            isInputEmpty = true
        } else {
            isInputEmpty = false
        }
    }
    
    func showAlerts(text: String, icon: String, haptic: String) {
        if icon == "error" && haptic == "error" {
            AlertKitAPI.present(
                title: NSLocalizedString(text, comment: ""),
                icon: .error,
                style: .iOS16AppleMusic,
                haptic: .error
            )
        } else if icon == "done" && haptic == "success" {
            AlertKitAPI.present(
                title: NSLocalizedString(text, comment: ""),
                icon: .done,
                style: .iOS16AppleMusic,
                haptic: .success
            )
        }
    }
    
    func summarizeWebsite(extractedTextInput: String) async {
        state = .generate("")
        
        let chatQuery = ChatQuery(messages: [.init(role: .user, content: "\(extractedTextInput)")!], model: .gpt3_5Turbo)
        
        do {
            for try await result in openAI.chatsStream(query: chatQuery) {
                if case let .generate(content) = state, let newText = result.choices.first?.delta.content {
                    state = .generate(content + newText)
                }
            }
            
            if selectedOutputLanguage.lowercased() != "en" {
                if case let .generate(summary) = state {
                    await translate(textInput: summary, fromLanguage: "en", toLanguage: selectedOutputLanguage)
                }
            }
        } catch {
            state = .failed
        }
    }
    
    func speakOut(text: String) {
        recognizer.processString(text)
        let lang = recognizer.dominantLanguage!.rawValue
        
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: lang)
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print(error.localizedDescription)
        }
        
        speechSynthesizer.speak(utterance)
    }
    
    func fetchHTML(from urlString: String) {
        guard let url = URL(string: urlString) else {
            self.websiteText = "Invalid URL"
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                Task { @MainActor in
                    self.websiteText = "Failed to load content"
                }
                return
            }
            
            if let htmlContent = String(data: data, encoding: .utf8) {
                Task { @MainActor in
                    self.parseHTML(htmlContent)
                }
            } else {
                Task { @MainActor in
                    self.websiteText = "Failed to decode content"
                }
            }
        }.resume()
    }
        
    @MainActor
    private func parseHTML(_ html: String) {
        do {
            let doc = try SwiftSoup.parse(html)
            let bodyText = try doc.body()?.text() ?? "No content"
            self.websiteText = bodyText
        } catch {
            self.websiteText = "Error parsing HTML"
        }
    }
}

enum PromptState {
    case idle
    case generate(String)
    case translated(String)
    case failed
    case noAPI
}

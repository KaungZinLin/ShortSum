//
//  SettingsViewModel.swift
//  StudyIO
//
//  Created by Kaung Zin Lin on 06/07/2024.
//

import Foundation
import AVFoundation

class LanguageSettingsViewModel: ObservableObject {
    @Published var selectedLanguage: String? {
        didSet {
            UserDefaults.standard.set(selectedLanguage, forKey: "selectedLanguage")
        }
    }

    let languageMapping: [String: String] = [
        "🇦🇪 Català (Catalan)": "ca",
        "🇸🇦 العربية (Arabic)": "ar",
        "🇮🇩 Bahasa Indonesia (Indonesian)": "id",
        "🇲🇾 Bahasa Melayu (Malay)": "ms",
        "🇲🇲 ဗမာစာ (Burmese)": "my",
        "🇨🇿 Čeština (Czech)": "cs",
        "🇩🇰 Dansk (Danish)": "da",
        "🇳🇱 Nederlands (Dutch)": "nl",
        "🇬🇷 Ελληνικά (Greek)": "el",
        "🇺🇸 English": "en",
        "🇪🇸 Español (Spanish)": "es",
        "🇫🇮 Suomi (Finnish)": "fi",
        "🇫🇷 Français (French)": "fr",
        "🇩🇪 Deutsch (German)": "de",
        "🇮🇳 हिंदी (Hindi)": "hi",
        "🇭🇺 Magyar (Hungarian)": "hu",
        "🇮🇱 עברית (Hebrew)": "he",
        "🇭🇷 Hrvatski (Croatian)": "hr",
        "🇮🇹 Italiano (Italian)": "it",
        "🇯🇵 日本語 (Japanese)": "ja",
        "🇰🇷 한국어 (Korean)": "ko",
        "🇨🇳 中文 (Mandarin Chinese)": "zh",
        "🇳🇴 Norsk (Norwegian)": "no",
        "🇵🇱 Polski (Polish)": "pl",
        "🇵🇹 Português (Portuguese)": "pt",
        "🇷🇴 Română (Romanian)": "ro",
        "🇷🇺 Русский (Russian)": "ru",
        "🇸🇰 Slovenčina (Slovak)": "sk",
        "🇸🇪 Svenska (Swedish)": "sv",
        "🇹🇭 ไทย (Thai)": "th",
        "🇹🇷 Türkçe (Turkish)": "tr",
        "🇺🇦 Українська (Ukrainian)": "uk",
        "🇻🇳 Tiếng Việt (Vietnamese)": "vi",
        "🇹🇼 中文 (Traditional Chinese)": "zh-Hant",
        "🇨🇳 中文 (Simplified Chinese)": "zh-Hans"
    ]
    
    
    init() {
        self.selectedLanguage = UserDefaults.standard.string(forKey: "selectedLanguage") ?? "en"
    }
}

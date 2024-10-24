//
//  OurTeamView.swift
//  StudyIO
//
//  Created by Kaung Zin Lin on 03/06/2024.
//

import SwiftUI

struct OurTeamView: View {
    var body: some View {
        VStack {
            Form {
                Section {
                    VStack(alignment: .center) {
                        Text("ShortSum")
                            .font(.title)
                            .fontDesign(.rounded)
                            .bold()
                            .multilineTextAlignment(.center)
                        
                        Text("Version 1.0 (Stable)")
                            .fontDesign(.monospaced)
                            .fontWeight(.thin)
                            .multilineTextAlignment(.center)
                        
                        Text("By Kaung Zin Lin, Thura Ye Yint and Thuta Htet")
                            .multilineTextAlignment(.center)
                            .font(.caption)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                }
                
                Section("Translations") {
                    TranslatorView(
                        name: "Kaung Zin Lin",
                        description: "🇲🇲 Translated to Burmese"
                    )
                    
                    TranslatorView(
                        name: "Khant Si Aung",
                        description: "🇨🇳 Translated to Chinese (Simplified)"
                    )
                    
                    TranslatorView(
                        name: "Myat Min Thu",
                        description: "🇰🇷 Translated to Korean"
                    )

//                    TranslatorView(
//                        name: "DeepL",
//                        description: "🇹🇼 Translated to Chinese (Traditional)",
//                        title: "Machine Translation not Verified yet!",
//                        message: "Helped with Translation Prompts by Kaung Zin Lin"
//                    )
//                    
//                    TranslatorView(
//                        name: "DeepL",
//                        description: "🇫🇷 Translated to French",
//                        title: "Machine Translation not Verified yet!",
//                        message: "Helped with Translation Prompts by Thuta Htet"
//                    )
//                    
//                    TranslatorView(
//                        name: "DeepL",
//                        description: "🇩🇪 Translated to German",
//                        title: "Machine Translation not Verified yet!",
//                        message: "Helped with Translation Prompts by Kaung Zin Lin"
//                    )
//                    
//                    TranslatorView(
//                        name: "DeepL",
//                        description: "🇯🇵 Translated to Japanese",
//                        title: "Machine Translation not Verified yet!",
//                        message: "Helped with Translation Prompts by Thuta Htet"
//                    )
//                    
//                    TranslatorView(
//                        name: "DeepL",
//                        description: "🇪🇸 Translated to Spanish",
//                        title: "Machine Translation not Verified yet!",
//                        message: "Helped with Translation Prompts by Thuta Htet"
//                    )
//                    
//                    TranslatorView(
//                        name: "DeepL",
//                        description: "🇺🇦 Translated to Ukrainian",
//                        title: "Machine Translation not Verified yet!",
//                        message: "Helped with Translation Prompts by Kaung Zin Lin"
//                    )
                }
                
                Section("Included Libraries") {
                    ExternalPackageView(
                        title: "OpenAI",
                        url: "https://github.com/MacPaw/OpenAI/"
                    )
                    ExternalPackageView(
                        title: "SwiftSoup",
                        url: "https://github.com/scinfu/SwiftSoup"
                    )
                    ExternalPackageView(
                        title: "SwiftyTranslate",
                        url: "https://github.com/cpageler93/SwiftyTranslate"
                    )
                    ExternalPackageView(
                        title: "AlertKit",
                        url: "https://github.com/sparrowcode/AlertKit"
                    )
                }
                
                Section {
                    Text("Made with ❤️ and 🍀 in Burma 🇲🇲")
                }
            }
            .navigationTitle("About")
        }
    }
}




#Preview {
    OurTeamView()
}

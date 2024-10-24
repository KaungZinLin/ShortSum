//
//  StudySummarizerView.swift
//  StudyIO
//
//  Created by Kaung Zin Lin on 04/06/2024.
//

import SwiftUI
import AlertKit

struct StudySummarizerView: View {
    @StateObject var viewModel = UniversalAIViewModel()
    @State var questionAndAnswer = ""
    @State private var questionInput: String = ""
    @State private var answerInput: String = ""
    @State private var showScannerSheet = false
    @State private var texts: [ScanData] = []
    @State var isSheetPresented: Bool = false
    @State private var isShowingSheet: Bool = false
    
    var body: some View {
        VStack {
            Spacer()
            Spacer()
            
            if texts.count > 0 {
                TopView(title: "Ready to Summarize", description: "", sfSymbol: "doc.plaintext")
                
                StyledButton(title: "Summarize", action: {
                    isShowingSheet = true
                }, gradientColors: [Color.blue.opacity(0.8), Color.cyan])
                
                Spacer()
            } else {
                VStack(alignment: .center) {
                    TopView(title: "No Scans", description: "Scan a paper that contains the paragraph", sfSymbol: "doc.plaintext")
                }
                .frame(maxWidth: .infinity, alignment: .center)
                
                StyledButton(title: "Scan", action: {
                   showScannerSheet = true
                }, gradientColors: [Color.blue.opacity(0.8), Color.cyan])
                
                Spacer()
            }
            
            Spacer()
        }
        .sheet(isPresented: $showScannerSheet, content: {
            self.makeScannerView()
        })
        .sheet(isPresented: $isShowingSheet) {
            ScanView(scanTexts: texts)
                .accentColor(.accent)
        }
        
    }
    
    private func makeScannerView() -> ScannerView {
        ScannerView(completion: { textPerPage in
            if let outputText = textPerPage?.joined(separator: "\n").trimmingCharacters(in: .whitespacesAndNewlines) {
                let newScanData = ScanData(content: outputText)
                self.texts.append(newScanData)
            }
            self.showScannerSheet = false
        })
    }
}

#Preview {
    StudySummarizerView()
}

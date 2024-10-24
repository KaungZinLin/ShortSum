//
//  HandwritingDetectorView.swift
//  StudyIO
//
//  Created by Kaung Zin Lin on 20/06/2024.
//

import SwiftUI

struct HandwritingDetectorView: View {
    @StateObject var viewModel = UniversalAIViewModel()
    @State private var showScannerSheet = false
    @State private var texts: [ScanData] = []
    @State private var isShowingSheet = false
    
    var body: some View {
        VStack {
            Spacer()
            Spacer()
            
            if texts.count > 0 {
                TopView(title: "Ready to Detect", description: "", sfSymbol: "doc.plaintext")

                StyledButton(title: "Detect", action: {
                    self.isShowingSheet = true
                }, gradientColors: [Color.cyan.opacity(0.8), Color.teal])
                
                Spacer()
            } else {
                VStack(alignment: .center) {
                    TopView(title: "No Scans", description: "Scan a paper that is badly-written", sfSymbol: "doc.plaintext")
                }
                .frame(maxWidth: .infinity, alignment: .center)
                
                StyledButton(title: "Scan", action: {
                    self.showScannerSheet = true
                }, gradientColors: [Color.cyan.opacity(0.8), Color.teal])
                
                Spacer()
            }
            
            Spacer()
        }
        .navigationTitle("Bad Handwriting Detector")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showScannerSheet, content: {
            self.makeScannerView()
        })
        .sheet(isPresented: $isShowingSheet) {
            HDScanView(scanTexts: texts)
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
    HandwritingDetectorView()
}

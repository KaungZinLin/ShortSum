//
//  SplashScreenView.swift
//  StudyIO
//
//  Created by Kaung Zin Lin on 10/06/2024.
//

import SwiftUI

struct SplashScreenView: View {
    @State var isActive : Bool = false
    @State private var size = 0.8
    @State private var opacity = 0.5

    var body: some View {
        if isActive {
            HomeView()
        } else {
            VStack {
                VStack {
                    ProgressView("\(randomMottoSelection())")
                        .progressViewStyle(CircularProgressViewStyle(tint: .accent))
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear {
                    withAnimation(.easeIn(duration: 1.2)) {
                        self.size = 0.9
                        self.opacity = 1.00
                    }
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }
    }
}

func randomMottoSelection() -> String {
    let motto = [
        "One click pass all the tests!",
        "From Notes to Knowledge in Seconds",
        "Transform Your Handwritten Notes into Study Gold",
        "Effortless Exam Prep with AI-Powered Summaries",
        "Turn Your Scribbles into Study Guides",
        "Smart Scans for Smarter Studying",
        "Scan. Summarize. Succeed"
    ]
    
    let randomMotto = motto.randomElement()
    return randomMotto!
}

#Preview {
    SplashScreenView()
}

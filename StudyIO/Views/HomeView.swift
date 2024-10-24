//
//  ContentView.swift
//  StudyIO
//
//  Created by Kaung Zin Lin on 31/05/2024.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    @State var isShowingSettingsView: Bool = false
    @State var isShowingTodayView: Bool = false

    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.isActive {
                    Divider()
                    ScrollView {
                        VStack(alignment: .center) {
                            Text("Study Smarter with AI")
                                .font(.title2)
                                .fontWeight(.medium)
                                .fontDesign(.monospaced)
                            NavigationLink(destination: StudySummarizerView().accentColor(.accent)) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                                        .fill(LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.8), Color.cyan]), startPoint: .topLeading, endPoint: .bottomTrailing))
                                        .frame(width: 350, height: 100)
                                        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
                                    
                                    Text("Image Summarizer")
                                        .font(.headline)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.white)
                                        .fontDesign(.rounded)
                                }
                            }
                            .buttonStyle(PlainButtonStyle())
                            
                            NavigationLink(destination: AskQuestionsView().accentColor(.accent)) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                                        .fill(LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.8), Color.orange]), startPoint: .topLeading, endPoint: .bottomTrailing))
                                        .frame(width: 350, height: 100)
                                        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
                                    
                                    Text("Ask Questions")
                                        .font(.headline)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.white)
                                        .fontDesign(.rounded)
                                }
                            }
                            .buttonStyle(PlainButtonStyle())
                            
                            NavigationLink(destination: HandwritingDetectorView().accentColor(.accent)) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                                        .fill(LinearGradient(gradient: Gradient(colors: [Color.cyan.opacity(0.8), Color.teal]), startPoint: .topLeading, endPoint: .bottomTrailing))
                                        .frame(width: 350, height: 100)
                                        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
                                    
                                    Text("Bad Handwriting Detector")
                                        .font(.headline)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.white)
                                        .fontDesign(.rounded)
                                }
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
   
                        VStack(alignment: .center) {
                            Text("Exam Prep")
                                .font(.title2)
                                .fontWeight(.medium)
                                .fontDesign(.monospaced)
                            
                            NavigationLink(destination: RecheckView().accentColor(.accent)) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                                        .fill(LinearGradient(gradient: Gradient(colors: [Color.yellow.opacity(0.8), Color.orange]), startPoint: .topLeading, endPoint: .bottomTrailing))
                                        .frame(width: 350, height: 100)
                                        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
                                    
                                    Text("Recheck")
                                        .font(.headline)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.white)
                                        .fontDesign(.rounded)
                                }
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                        
                        VStack(alignment: .center) {
                            Text("Math")
                                .font(.title2)
                                .fontWeight(.medium)
                                .fontDesign(.monospaced)
                            
                            NavigationLink(destination: PrimesView().accentColor(.accent)) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                                        .fill(LinearGradient(gradient: Gradient(colors: [Color.green.opacity(0.8), Color.secondary]), startPoint: .topLeading, endPoint: .bottomTrailing))
                                        .frame(width: 350, height: 100)
                                        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
                                    
                                    Text("Find Primes/Non-Primes")
                                        .font(.headline)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.white)
                                        .fontDesign(.rounded)
                                }
                            }
                            .buttonStyle(PlainButtonStyle())
                            
                            NavigationLink(destination: HCFAndLCMView().accentColor(.accent)) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                                        .fill(LinearGradient(gradient: Gradient(colors: [Color.gray.opacity(0.8), Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing))
                                        .frame(width: 350, height: 100)
                                        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
                                    
                                    Text("Check and Find HCF/LCM")
                                        .font(.headline)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.white)
                                        .fontDesign(.rounded)
                                }
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                        
                        VStack(alignment: .center) {
                            Text("Quick Info & Visuals")
                                .font(.title2)
                                .fontWeight(.medium)
                                .fontDesign(.monospaced)
                            
                            NavigationLink(destination: WebsiteSummarizer().accentColor(.accent)) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                                        .fill(LinearGradient(gradient: Gradient(colors: [Color.purple.opacity(0.8), Color.accent]), startPoint: .topLeading, endPoint: .bottomTrailing))
                                        .frame(width: 350, height: 100)
                                        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
                                    
                                    Text("Article Summarizer (Beta)")
                                        .font(.headline)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.white)
                                        .fontDesign(.rounded)
                                }
                            }
                            .buttonStyle(PlainButtonStyle())
                            
                            NavigationLink(destination: ImageSearchView().accentColor(.accent)) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                                        .fill(LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.8), Color.red]), startPoint: .topLeading, endPoint: .bottomTrailing))
                                        .frame(width: 350, height: 100)
                                        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
                                    
                                    Text("Image Search")
                                        .font(.headline)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.white)
                                        .fontDesign(.rounded)
                                }
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                        
                        VStack(alignment: .center) {
                            Text("ShortSum relies on OpenAI's ChatGPT. ChatGPT can make mistakes. See important info.")
                                .font(.caption)
                                .fontWeight(.light)
                                .fontDesign(.rounded)
                                .multilineTextAlignment(.center)
                        }
                        .padding()
                    }
                } else {
                    VStack(alignment: .center) {
                        if #available(iOS 17.0, *) {
                            Image(systemName: "wifi.slash")
                                .font(.system(size: 80))
                                .cornerRadius(50)
                                .symbolEffect(.variableColor)
                                .foregroundStyle(.red)
                                .bold()
                                .padding()
                        } else {
                            Image(systemName: "wifi.slash")
                                .font(.system(size: 80))
                                .cornerRadius(50)
                                .foregroundStyle(.red)
                                .bold()
                                .padding()
                        }
                        
                        Text("You're Offline")
                            .font(.headline)
                            
                        Text("You're not connected to the internet!")
                    }
                }
            }
            .navigationTitle("ShortSum")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        isShowingSettingsView = true
                    }) {
                        Image(systemName: "gearshape")
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        isShowingTodayView = true
                    }) {
                        Image(systemName: "doc.text.image")
                    }
                }
            }
            .sheet(isPresented: $isShowingSettingsView) {
                SettingsView()
                    .tint(.accent)
            }
            .sheet(isPresented: $isShowingTodayView) {
                OfTheDayView()
                    .tint(.accent)
            }
            
        }
    }
}

#Preview {
    HomeView()
}

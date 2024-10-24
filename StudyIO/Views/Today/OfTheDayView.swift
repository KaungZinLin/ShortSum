//
//  OfTheDayView.swift
//  StudyIO
//
//  Created by Kaung Zin Lin on 03/08/2024.
//

import SwiftUI

struct OfTheDayView: View {
    @State private var viewModel = OfTheDayViewModel()
    @Environment(\.dismiss) var dismiss
    @State private var randomQuote: OfTheDayViewModel.Quote?
    @State private var randomJoke: OfTheDayViewModel.Joke?
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 10) {
                Form {
                    Section("Quote of the Day") {
                        if let quote = randomQuote {
                            VStack {
                                if quote.picture == "Unknown" {
                                    VStack(alignment: .leading) {
                                        Text(quote.text)
                                            .font(.headline)
                                            .fontDesign(.rounded)
                                        Text("- \(quote.author)")
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                    }
                                    .padding()
                                } else {
                                    Image(quote.picture)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(maxWidth: .infinity, maxHeight: 600)
                                        .clipped()
                                        .cornerRadius(30)
                                        .padding()
                                    
                                    VStack(alignment: .leading) {
                                        Text(quote.text)
                                            .font(.headline)
                                            .fontDesign(.rounded)
                                        Text("- \(quote.author)")
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                    }
                                    .padding()
                                }
                            }
                        } else {
                            Text("Loading...")
                        }
                    }
                    
                    Section("Joke of the Day (by GoodHouseKeeping)") {
                        if let joke = randomJoke {
                            Text(joke.text)
                        }
                    }
                }
                .navigationTitle("Today")
                .navigationBarTitleDisplayMode(.inline)
                .onAppear {
                    randomQuote = viewModel.randomQuote
                    randomJoke = viewModel.randomJoke
                }
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Close") {
                            dismiss()
                        }
                    }
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {
                            randomQuote = viewModel.randomQuote
                            randomJoke = viewModel.randomJoke
                        }) {
                            Image(systemName: "arrow.clockwise")
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    OfTheDayView()
}

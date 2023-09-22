//
//  VerseListView.swift
//  QuranMajeed
//
//  Created by Takasur Azeem on 18/09/2023.
//

import SwiftUI

struct VerseListView: View {
    @State private var searchText = ""
    var selectedSuraVerses: [Verse] = []
    @State private var selection = Set<Verse>()
    
    var searchResults: [Verse] {
        if searchText.isEmpty {
            return selectedSuraVerses
        }
        return selectedSuraVerses
            .filter { "\($0.ayaNumber)".contains(searchText) }
    }
    
    var body: some View {
        List(searchResults, id: \.self, selection: $selection) { verse in
            HStack {
                Text(("\(verse.ayaNumber)"))
                Text(verse.text)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .multilineTextAlignment(.trailing)
            }
        }
        .searchable(text: $searchText)
        .navigationTitle("Ayah Selection")
        .toolbar { EditButton() }
    }
}

#Preview {
    ContentPreview()
}

fileprivate struct ContentPreview: View {
    @State var allVerses: [Verse] = []
    var body: some View {
        NavigationStack {
            VerseListView(selectedSuraVerses: allVerses)
                .task {
                    let repo = try! AppDependencyContainer
                        .shared
                        .theQuranDependencyContainer
                        .makeQuranRepository()
                    if let verses = try? await repo.getTranslatedVerses(verses: repo.getFirstSura().verses).verses {
                        self.allVerses = verses.enumerated().map { Verse(ayaNumber: $0 + 1, text: $1.arabicText, translation: "") }
                    }
                }
        }
    }
}

//
//  VerseListView.swift
//  QuranMajeed
//
//  Created by Takasur Azeem on 18/09/2023.
//

import SwiftUI

struct VerseListView: View {
    @Environment(\.editMode) private var editMode
    @State private var searchText = ""
    @State private var selection = Set<Verse>()
    
    var allVerses: [Verse] = []
    @Binding var selectedVerses: [Verse]
    
    private var searchResults: [Verse] {
        if searchText.isEmpty {
            return allVerses
        }
        return allVerses
            .filter { "\($0.ayaNumber)".contains(searchText) }
    }
    
    var body: some View {
        List(
            searchResults,
            id: \.self,
            selection: $selection
        ) { verse in
            HStack {
                Text(("\(verse.ayaNumber)"))
                Text(verse.text)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .multilineTextAlignment(.trailing)
            }
        }
        .navigationTitle(Text("Verses Selection", comment: "Verse is a noun, but can be translated in Urdu and Arabic and in some other languages as well."))
        .environment(\.editMode, .constant(.active))
        .onAppear {
            selection = Set(selectedVerses)
        }
        .onChange(of: selection) { _ in
            if !selection.isEmpty {
                selectedVerses = Array(selection).sorted()
            }
        }
        .searchable(text: $searchText)
    }
}

@available(iOS 16.0, *)
struct VerseListView_Previews: PreviewProvider {
    static var previews: some View {
        ContentPreview()
            .environment(\.locale, .init(identifier: "ur"))
    }
}

@available(iOS 16.0, *)
fileprivate struct ContentPreview: View {
    @State var allVerses: [Verse] = []
    var body: some View {
        NavigationStack {
            VerseListView(
                allVerses: allVerses,
                selectedVerses: .constant([])
            )
            .task {
                guard let repo = try? AppDependencyContainer
                    .shared
                    .theQuranDependencyContainer
                    .makeQuranRepository()
                else { return }
                if let verses = try? await repo.getTranslatedVerses(verses: repo.getFirstSura().verses).verses {
                    self.allVerses = verses.enumerated().map { Verse(ayaNumber: $0 + 1, text: $1.arabicText, translation: "") }
                }
            }
        }
    }
}

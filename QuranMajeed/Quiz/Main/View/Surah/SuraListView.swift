//
//  SuraListView.swift
//  QuranMajeed
//
//  Created by Takasur Azeem on 18/09/2023.
//

import SwiftUI
import QuranKit

struct SuraListView: View {
    let suras: [Sura]
    @Binding var selectedSura: Sura
    @State private var searchText = ""
    @Environment(\.presentationMode) var presentationMode
    
    var searchResults: [Sura] {
        if searchText.isEmpty {
            return suras
        }
        return suras.filter { $0.localizedName(withNumber: true, language: .english).contains(searchText) || $0.localizedName(withNumber: true, language: .arabic).contains(searchText) }
    }
    
    var body: some View {
        List(searchResults) { sura in
            VStack {
                SuraNameView(for: sura)
            }
            .onTapGesture {
                selectedSura = sura
                presentationMode.wrappedValue.dismiss()
            }
        }
        .navigationTitle(Text("Select Surah", comment: "Sura is a noun, but can be translated in Urdu and Arabic and in some other languages as well."))
        .searchable(text: $searchText)
    }
}

@available(iOS 16.0, *)
struct SuraListView_Previews: PreviewProvider {
    static let suras = Quran.hafsMadani1440.suras
    static var previews: some View {
        NavigationStack {
            SuraListView(
                suras: suras,
                selectedSura: .constant(suras[0])
            )
        }
    }
}

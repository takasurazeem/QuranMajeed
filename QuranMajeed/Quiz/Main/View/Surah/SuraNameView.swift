//
//  SuraNameView.swift
//  QuranMajeed
//
//  Created by Takasur Azeem on 18/09/2023.
//

import SwiftUI
import QuranKit

struct SuraNameView: View {
    let sura: Sura

    init(for sura: Sura) {
        self.sura = sura
    }

    var body: some View {
        VStack {
            Text(sura.localizedName(withNumber: true, language: .arabic))
                .frame(maxWidth: .infinity, alignment: .trailing)
            Text(sura.localizedName(withNumber: true, language: .english))
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .contentShape(Rectangle())
    }
}

struct SuraNameView_Previews: PreviewProvider {
    static var previews: some View {
        SuraNameView(for: Quran.hafsMadani1440.suras[0])
            .padding()
    }
}

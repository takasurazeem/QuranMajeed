//
//  ChipModel.swift
//  CustomChipView
//
//  Created by Vasim Khan on 2/20/23.
//

import Foundation
import SwiftUI

struct ChipModel: Identifiable {
    @State var isSelected: Bool = false
    var id = UUID()
    var titleKey: String { word.word }
    let word: WordForWordsMeaning
    
    init(word: WordForWordsMeaning) {
        self.word = word
    }
}

class ChipsViewModel: ObservableObject {
    
    init(chipArray: [ChipModel]) {
        self.chipArray = chipArray
    }
    
    @Published var chipArray: [ChipModel]
}

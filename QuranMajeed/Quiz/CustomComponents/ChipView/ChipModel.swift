//
//  ChipModel.swift
//  CustomChipView
//
//  Created by Vasim Khan on 2/20/23.
//

import Foundation
import SwiftUI

struct ChipModel: Identifiable {
    @State var isSelected: Bool
    let id = UUID()
    var titleKey: String
    let word: WordForWordsMeaning
}

class ChipsViewModel: ObservableObject {
//    @Published var dataObject: [ChipModel] = [ChipModel.init(isSelected: false, systemImage: "pencil.circle", titleKey: "Pencil Circle")]
    @Published var chipArray: [ChipModel] = []
    
//    func addChip() {
//        dataObject.append(ChipModel.init(isSelected: false, systemImage: "pencil.circle", titleKey: "Pencil"))
//    }
//
//    func removeLast() {
//        guard dataObject.count != 0 else {
//            return
//        }
//        dataObject.removeLast()
//    }
}



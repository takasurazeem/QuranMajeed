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
    let titleKey: LocalizedStringKey
//    let verse: Verse
}

class ChipsViewModel: ObservableObject {
//    @Published var dataObject: [ChipModel] = [ChipModel.init(isSelected: false, systemImage: "pencil.circle", titleKey: "Pencil Circle")]
    @Published var chipArray: [ChipModel] = [
        ChipModel(isSelected: false, titleKey: "Heart"),
        ChipModel(isSelected: false, titleKey: "Folder"),
        ChipModel(isSelected: false, titleKey: "Pen"),
        ChipModel(isSelected: false, titleKey: "Book"),
        ChipModel(isSelected: false, titleKey: "Paper Plain"),
        ChipModel(isSelected: false, titleKey: "Documents"),
        ChipModel(isSelected: false, titleKey: "Heart"),
        ChipModel(isSelected: false, titleKey: "Folder"),
        ChipModel(isSelected: false, titleKey: "Pen"),
        ChipModel(isSelected: false, titleKey: "Book"),
        ChipModel(isSelected: false, titleKey: "Paper Plain"),
        ChipModel(isSelected: false, titleKey: "Documents"),
        ChipModel(isSelected: false, titleKey: "Folder"),
        ChipModel(isSelected: false, titleKey: "Pen"),
        ChipModel(isSelected: false, titleKey: "Book"),
        ChipModel(isSelected: false, titleKey: "Paper Plain"),
        ChipModel(isSelected: false, titleKey: "Documents"),
        ChipModel(isSelected: false, titleKey: "Heart"),
        ChipModel(isSelected: false, titleKey: "Folder"),
        ChipModel(isSelected: false, titleKey: "Pen"),
        ChipModel(isSelected: false, titleKey: "Book"),
        ChipModel(isSelected: false, titleKey: "Paper Plain"),
        ChipModel(isSelected: false, titleKey: "Documents")
    ]
    
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



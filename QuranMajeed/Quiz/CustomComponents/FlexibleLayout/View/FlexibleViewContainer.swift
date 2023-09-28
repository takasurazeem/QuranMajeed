//

import SwiftUI

struct FlexibleViewContainer: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        ScrollView {
            FlexibleView(
                data: viewModel.originalItems,
                spacing: viewModel.spacing,
                alignment: viewModel.alignment
            ) { item in
                Text(verbatim: item.word)
                    .padding(8)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(item.isSelected ? Color.blue : Color.gray.opacity(0.8))
                    )
                    .onTapGesture {
                        if let index = viewModel.originalItems.firstIndex(where: { $0 == item }) {
                            viewModel.originalItems[index].isSelected = !viewModel.originalItems[index].isSelected
                        }
                    }
            }
            .padding(.horizontal, viewModel.padding)
        }
//        .overlay(FlexibleViewContainerSettings(model: viewModel), alignment: .bottom)
    }
}

struct FlexibleViewContainer_Previews: PreviewProvider {
    static let words = """
آمَنَ الرَّسُولُ بِمَا أُنزِلَ إِلَيْهِ مِن رَّبِّهِ وَالْمُؤْمِنُونَ ۚ كُلٌّ آمَنَ بِاللَّهِ وَمَلَائِكَتِهِ وَكُتُبِهِ وَرُسُلِهِ لَا نُفَرِّقُ بَيْنَ أَحَدٍ مِّن رُّسُلِهِ ۚ وَقَالُوا سَمِعْنَا وَأَطَعْنَا ۖ غُفْرَانَكَ رَبَّنَا وَإِلَيْكَ الْمَصِيرُ(۲۸۵) لَا يُكَلِّفُ اللَّهُ نَفْسًا إِلَّا وُسْعَهَا ۚ لَهَا مَا كَسَبَتْ وَعَلَيْهَا مَا اكْتَسَبَتْ ۗ رَبَّنَا لَا تُؤَاخِذْنَا إِن نَّسِينَا أَوْ أَخْطَأْنَا ۚ رَبَّنَا وَلَا تَحْمِلْ عَلَيْنَا إِصْرًا كَمَا حَمَلْتَهُ عَلَى الَّذِينَ مِن قَبْلِنَا ۚ رَبَّنَا وَلَا تُحَمِّلْنَا مَا لَا طَاقَةَ لَنَا بِهِ ۖ وَاعْفُ عَنَّا وقفہ وَاغْفِرْ لَنَا وقفہ وَارْحَمْنَا وقفہ ۚ أَنتَ مَوْلَانَا فَانصُرْنَا عَلَى الْقَوْمِ الْكَافِرِينَ(۲۸۶)
""".split(separator: " ")
        .enumerated()
        .map { WordForWordsMeaning(id: Double($0), word: String($1)) }
    static var previews: some View {
        FlexibleViewContainer(
            viewModel: FlexibleViewContainer.ViewModel(originalItems: words)
        )
    }
}

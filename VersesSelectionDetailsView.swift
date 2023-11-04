//
//  VersesSelectionDetailsView.swift
//  Al-Tanzeel
//
//  Created by Takasur Azeem on 28/10/2023.
//  Copyright © 2023 Islam. All rights reserved.
//

import SwiftUI

struct VersesSelectionDetailsView: View {
    @ObservedObject var viewModel: QuizView.ViewModel
    var selectedVersesForTranslationText: LocalizedStringKey {
        "You selected \(viewModel.selectedVersesForTranslation.count) verses for translation."
    }
    
    var body: some View {
        ScrollView {
            NavigationLink {
                VerseListView(
                    allVerses: viewModel.versesOfSelectedSura,
                    selectedVerses: $viewModel.selectedVersesForTranslation
                )
            } label: {
                VStack(alignment: .leading) {
                    HStack {
                        VStack(alignment: .leading, spacing: AppStyle.Spacing.space12) {
                            Text("Please tap on the row to select verses.")
                                .font(.caption)
                        }
                        Spacer(minLength: AppStyle.Spacing.space16)
                        ChevronView()
                    }
                    .padding(.top, AppStyle.Spacing.space8)
                }
            }
            .roundedCornersView()
            if !viewModel.selectedVersesForTranslation.isEmpty {
                VStack(alignment: .leading) {
                    Text(selectedVersesForTranslationText)
                        .multilineTextAlignment(.leading)
                        .font(.footnote)
                        .foregroundStyle(Color.accentColor.opacity(0.9))
                    VStack(alignment: .leading) {
                        ForEach(viewModel.selectedVersesForTranslation.indices, id:\.self) { index in
                            VStack(spacing: AppStyle.Spacing.space12) {
                                HStack {
                                    Text(viewModel.selectedVersesForTranslation[index].text)
                                        .multilineTextAlignment(.leading)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(.vertical, AppStyle.Spacing.space4)
                                        .padding(.horizontal, AppStyle.Spacing.space8)
                                }
                                Divider()
                            }
                            .onDelete {
                                viewModel.deleteTranslationVerse(at: IndexSet(integer: index))
                            }
                        }
                        //                        .onDelete(perform: viewModel.deleteTranslationVerse(at:))
                    }
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 8.0, style: .continuous))
                }
                .roundedCornersView()
                .padding(.top, AppStyle.Spacing.space8)
            }
        }
        .navigationTitle("Select Words")
    }
}

#Preview {
    ApplicationMainView()
        .environment(\.locale, Locale(identifier: "ur_Arab_PK"))
        .environment(\.layoutDirection, .rightToLeft)
}

struct Delete: ViewModifier {

    let action: () -> Void
    
    @State var offset: CGSize = .zero
    @State var initialOffset: CGSize = .zero
    @State var contentWidth: CGFloat = 0.0
    @State var willDeleteIfReleased = false
   
    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { geometry in
                    ZStack {
                        Rectangle()
//                            .cornerRadius(radius: 7, corners: [.topRight, .bottomRight])
                            .foregroundColor(charcoalColor)
                            .frame(maxHeight: .infinity)
                        Image(systemName: "book.closed")
                            .foregroundColor(.white)
                            .font(.title2.bold())
                            .layoutPriority(-1)
                    }
                    .frame(width: -offset.width)
                    .clipShape(Rectangle() )
                    .offset(x: geometry.size.width)
                    .onAppear {
                        contentWidth = geometry.size.width
                    }
                    .gesture(
                        TapGesture()
                            .onEnded {
                                delete()
                            }
                    )
                }
            )
            .offset(x: offset.width, y: 0)
            .gesture (
                DragGesture()
                    .onChanged { gesture in
                        if gesture.translation.width + initialOffset.width <= 0 {
                            self.offset.width = gesture.translation.width + initialOffset.width
                        }
                        if self.offset.width < -deletionDistance && !willDeleteIfReleased {
                            hapticFeedback()
                            willDeleteIfReleased.toggle()
                        } else if offset.width > -deletionDistance && willDeleteIfReleased {
                            hapticFeedback()
                            willDeleteIfReleased.toggle()
                        }
                    }
                    .onEnded { _ in
                        if offset.width < -deletionDistance {
                            delete()
                        } else if offset.width < -halfDeletionDistance {
                            offset.width = -tappableDeletionWidth
                            initialOffset.width = -tappableDeletionWidth
                        } else {
                            offset = .zero
                            initialOffset = .zero
                        }
                    }
            )
            .animation(.interactiveSpring, value: offset)
    }
    
    private func delete() {
        //offset.width = -contentWidth
        
        offset = .zero
        initialOffset = .zero
        action()
    }
    
    private func hapticFeedback() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
    
    //MARK: Constants
    
    let deletionDistance = CGFloat(200)
    let halfDeletionDistance = CGFloat(50)
    let tappableDeletionWidth = CGFloat(100)
    
    
}

extension View {
    
    func onDelete(perform action: @escaping () -> Void) -> some View {
        self.modifier(Delete(action: action))
    }
    func cornerRadius(radius: CGFloat, corners: UIRectCorner) -> some View {
        ModifiedContent(content: self, modifier: CornerRadiusStyle(radius: radius, corners: corners))
    }
}

struct CornerRadiusShape: Shape {
   var radius = CGFloat.infinity
   var corners = UIRectCorner.allCorners

   func path(in rect: CGRect) -> Path {
     let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
    return Path(path.cgPath)
   }
}

struct CornerRadiusStyle: ViewModifier {
   var radius: CGFloat
   var corners: UIRectCorner

   func body(content: Content) -> some View {
     content
        .clipShape(CornerRadiusShape(radius: radius, corners: corners))
  }
}
extension Color {
    init(hex: UInt) {
        self.init(
            red: Double((hex >> 16) & 0xFF) / 255.0,
            green: Double((hex >> 8) & 0xFF) / 255.0,
            blue: Double(hex & 0xFF) / 255.0
        )
    }
}

// Define a charcoal color using a hexadecimal value (e.g., #555555)
let charcoalColor = Color(hex: 0x555555)

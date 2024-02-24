//
//  QuizSettingsView.swift
//  Al-Tanzeel
//
//  Created by Takasur Azeem on 16/02/2024.
//  Copyright © 2024 Islam. All rights reserved.
//

import SwiftUI

struct QuizClassSettingsView: View {
    private let masjidNameLabel: String = "Masjid Name"
    private let classNameLabel: String = "Class Name"
    @State private var showingAddClassSheet = false
    @StateObject private var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack {
            if !viewModel.classes.isEmpty {
                List {
                    Section("Classes") {
                        ForEach(viewModel.classes) { quizClass in
                            HStack {
                                Text(quizClass.masjidName)
                                Spacer()
                                Text(quizClass.className)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal)
                        }
                    }
                }
            } else {
                Text("Tap here or on the plus icon to add class.")
                    .font(.callout)
                    .onTapGesture {
                        showingAddClassSheet = true
                    }
            }
        }
        .toolbar {
            ToolbarItemGroup {
                Button {
                    showingAddClassSheet = true
                } label: {
                    Image(systemName: "pencil.tip.crop.circle.badge.plus")
                }
            }
        }
        .sheet(isPresented: $showingAddClassSheet) {
            NavigationStack {
                AddClassView(
                    masjidName: "",
                    className: "",
                    buttonTitle: "Save",
                    viewModel: viewModel,
                    dismiss: $showingAddClassSheet
                )
                .navigationTitle("Class Details")
            }
        }
    }
}

#Preview {
    NavigationStack {
        QuizClassSettingsView(
            viewModel: QuizClassSettingsView.ViewModel(
                quizPreferencesRepository: AppDependencyContainer.shared.quizPreferenncesDependencyContainer.makePreferencesRepository()
            )
        )
        .navigationTitle("Classes")
    }
}

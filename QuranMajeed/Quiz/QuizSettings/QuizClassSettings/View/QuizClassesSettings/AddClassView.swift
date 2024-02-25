//
//  AddClassView.swift
//  Al-Tanzeel
//
//  Created by Takasur A. on 19/02/2024.
//  Copyright © 2024 Islam. All rights reserved.
//

import SwiftUI

struct AddClassView: View {
    @Binding var dismiss: Bool
    @State var masjidName: String = ""
    @State var className: String = ""
    private let buttonTitle: String
    @ObservedObject var viewModel: QuizClassSettingsView.ViewModel
    
    init(
        masjidName: String,
        className: String,
        buttonTitle: String,
        viewModel: QuizClassSettingsView.ViewModel,
        dismiss: Binding<Bool>
    ) {
        self.masjidName = masjidName
        self.className = className
        self.buttonTitle = buttonTitle
        self.viewModel = viewModel
        self._dismiss = dismiss
    }
    
    var body: some View {
        VStack {
            TextField("🕌 Masjid Name", text: $masjidName)
                .customStyle()
            TextField("🎓 Class Name", text: $className)
                .customStyle()
            Button(buttonTitle) {
                viewModel.addClass(
                    className: className,
                    masjidName: masjidName
                )
                dismiss.toggle()
            }
            .buttonStyle(CustomButtonStyle())
            Spacer()
        }
        .padding()
    }
}

#Preview {
    AddClassView(
        masjidName: "",
        className: "",
        buttonTitle: "Save",
        viewModel: QuizClassSettingsView.ViewModel(
            quizPreferencesRepository: AppDependencyContainer.shared.quizPreferenncesDependencyContainer.makePreferencesRepository()
        ), 
        dismiss: .constant(false)
    )
}

struct CustomTextFieldStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color.white)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray.opacity(0.2), lineWidth: 1) // Adjust opacity for a very light border color
            )
            .padding([.leading, .trailing], 10)
    }
}

extension TextField {
    func customStyle() -> some View {
        self.modifier(CustomTextFieldStyle())
    }
}

struct CustomButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .padding(10)
            .foregroundColor(.white)
            .background(Color.blue)
            .cornerRadius(8)
            .padding([.leading, .trailing], 10)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0) // Add a scaling effect when pressed
    }
}

extension Button {
    func customStyle() -> some View {
        self.buttonStyle(CustomButtonStyle())
    }
}

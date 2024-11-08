//
//  GiftMemoSection.swift
//  DoBday
//
//  Created by 이소현 on 11/8/24.
//
import SwiftUI

// MARK: - GiftMemoSection
struct GiftMemoSection: View {
    @Binding var memo: String?
    var isFocused: FocusState<Bool>.Binding
    
    var body: some View {
        Text("메모")
            .font(.bday_bodyEmphasized)
        TextEditor(text: Binding(
            get: { memo ?? "" },
            set: { memo = $0.isEmpty ? nil : $0 }
        ))
        .focused(isFocused)
        .scrollContentBackground(.hidden)
        .padding()
        .background(.gray.opacity(0.2))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

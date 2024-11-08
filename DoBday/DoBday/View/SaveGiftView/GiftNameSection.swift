//
//  GiftNameSection.swift
//  DoBday
//
//  Created by 이소현 on 11/8/24.
//
import SwiftUI

// MARK: - GiftNameSection
struct GiftNameSection: View {
    @Binding var giftName: String
    var isFocused: FocusState<Bool>.Binding
    
    var body: some View {
        LabeledTextField(text: "선물 이름", textField: $giftName)
            .focused(isFocused)
            .padding(.bottom, 16)

    }
}

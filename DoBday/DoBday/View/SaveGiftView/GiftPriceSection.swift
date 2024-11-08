//
//  GiftPriceSection.swift
//  DoBday
//
//  Created by 이소현 on 11/8/24.
//
import SwiftUI

// MARK: - GiftPriceSection
struct GiftPriceSection: View {
    
    @Binding var giftPrice: String?
    var isFocused: FocusState<Bool>.Binding
    
    var body: some View {
        LabeledTextField(text: "가격", textField: Binding(
            get: { giftPrice ?? "" },
            set: { giftPrice = $0.isEmpty ? nil : $0 }
        ))
        .focused(isFocused)
        .padding(.bottom, 16)

    }
}

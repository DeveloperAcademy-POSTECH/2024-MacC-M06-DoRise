//
//  GiftStatusSelectionSection.swift
//  DoBday
//
//  Created by 이소현 on 11/8/24.
//
import SwiftUI

// MARK: - GiftStatusSelectionSection
struct GiftStatusSelectionSection: View {
    
    @Binding var giftStatus: GiftStatusType
    
    var body: some View {
        HStack {
            GiftStatusButton(text: "받은 선물", status: .receivedGift, currentStatus: $giftStatus)
            GiftStatusButton(text: "준 선물", status: .given, currentStatus: $giftStatus)
        }
        .padding(.bottom)

    }
    
}

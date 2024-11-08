//
//  GiveOrTakeTag.swift
//  DoBday
//
//  Created by 이소현 on 11/8/24.
//
import SwiftUI

// MARK: - GiveOrTakeTag
struct GiveOrTakeTag: View {
    var sampleGift: BdayGift
    
    var body: some View {
        HStack {
            Text(sampleGift.isToBeGiven ? "내가 준" : "받은")
                .giveOrTakeTagTextViewModifier(sampleGift.isToBeGiven ? .green : .blue)
        }
    }
}

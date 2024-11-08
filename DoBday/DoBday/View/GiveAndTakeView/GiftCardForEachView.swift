//
//  GiftCardForEachView.swift
//  DoBday
//
//  Created by 이소현 on 11/8/24.
//
import SwiftUI

// MARK: - GiftCardForEachView
struct GiftCardForEachView: View {
    var bdayGifts: [BdayGift]
    @Binding var selectedGifts: Set<UUID>
    
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(bdayGifts, id: \.id) { gift in
                HStack {
                    // 개별 선택 체크박스
                    Button(action: {
                        selectedGifts.toggleSelection(for: gift.id)
                    }) {
                        CustomCheckBox(isChecked: selectedGifts.contains(gift.id), color: gift.isToBeGiven ? .green : .blue)
                        
                    }.padding(.leading, 3)
                    // 선물 카드 뷰
                    GiftCardView(sampleGift: gift).padding(.horizontal, 8)
                }
            }
        }
    }
}

//
//  GiftCardView.swift
//  DoBday
//
//  Created by 이소현 on 11/8/24.
//

import SwiftUI

// MARK: - GiftCardView
struct GiftCardView: View {
    var sampleGift: BdayGift
    
    var body: some View {
        ZStack {
            // 선물 카드의 배경 및 테두리 (선물 타입에 따라 색상이 달라짐)
            RoundedRectangle(cornerRadius: 12)
                .stroke(sampleGift.isToBeGiven ? Color.green : Color.blue, lineWidth: 3)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.white)
                )
                .frame(width: 300, height: 100)
            
            HStack{
                VStack(alignment: .leading, spacing: 2) {
                    // 선물의 태그 (내가 준 선물인지 받은 선물인지)
                    GiveOrTakeTag(sampleGift: sampleGift)
                        .padding(.bottom, 6)
                    // 선물 이름 표시
                    Text(sampleGift.giftName)
                        .font(.bday_headEmphasized)
                    
                    
                    // 선물 가격 표시 (있을 경우에만 나타나게)
                    if let giftPrice = sampleGift.giftPrice {
                        Text("가격 \(giftPrice)원")
                            .font(.bday_footRegular)
                            .foregroundColor(.secondary)
                    }
                }
                .padding(.leading, 30)
                
                Spacer()
                
                PhotoRoundedRect(imageData: sampleGift.giftImage, alternativeImage: "starrynight", width: 64, height: 64)
                
                // 오른쪽 화살표 아이콘
                Image(systemName: "chevron.right")
                    .padding(.trailing, 35)
                    .font(.system(size: 16))
                    .foregroundColor(sampleGift.isToBeGiven ? Color.green : Color.blue)
            }
        }
    }
}

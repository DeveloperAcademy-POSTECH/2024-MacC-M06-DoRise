//
//  GiveAndTakeView.swift
//  DoBday
//
//  Created by 이소현 on 11/4/24.
//

import SwiftUI
import SwiftData

struct GiveAndTakeView: View {
    
    @Environment(\.modelContext) var context
    @Query var bdayGifts: [BdayGift]
    
    var body: some View {
        VStack {
            ForEach(sampleGifts, id: \.self) {sampleGift in
                giftCardView(sampleGift: sampleGift)
            }
            Spacer()
        }
        .padding(.horizontal)
        .navigationTitle("마일스와의 선물기록")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink {
                    EmptyView()
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        
    }
}


struct giftCardView: View {
    
    var sampleGift: BdayGift
    
    var body: some View {
        HStack(alignment: .top, spacing: 15) {
            Circle()
                .frame(width: 10, height: 10)
                .padding(4)
                .background(
                    .white.shadow(.drop(color: .black.opacity(0.1), radius: 3)), in: .circle
                )
            
            VStack(alignment: .leading) {
                HStack {
                    if let imageData = sampleGift.giftImage, let uiImage = UIImage(data: imageData) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                            .clipShape(.rect(cornerRadius: 20))
                        
                    } else {
                        Image("starrynight") // 기본 이미지 이름
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 80)
                            .clipShape(.rect(cornerRadius: 20))
                    }
                    
                    VStack(alignment: .leading) {
                        Text(sampleGift.giftName)
                            .font(.bday_t3Emphasized)
                        
                        if sampleGift.isToBeGiven {
                            if let giftPrice = sampleGift.giftPrice {
                                Text("가격 \(giftPrice)")
                            }
                        } else {
                            Text("만족도 ⭐️⭐️⭐️⭐️⭐️")
                        }
                    }
                    
                    Spacer()
                }
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(.gray.opacity(0.2))
            .clipShape(.rect(cornerRadius: 20))
        }
        
    }
}

#Preview {
    NavigationStack {
        GiveAndTakeView()
    }
    .modelContainer(for: BdayGift.self)
}


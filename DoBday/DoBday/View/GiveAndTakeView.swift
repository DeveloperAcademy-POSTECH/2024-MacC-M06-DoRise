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
        ZStack {
            HStack {
                Rectangle()
                    .frame(width: 2)
                    .frame(maxHeight: .infinity)
                    .padding(.leading, 12)
                Spacer()
            }
            VStack(alignment: .leading) {
                Text("2024")
                    .font(.bday_t2Emphasized)
                    .padding(.leading, 32)
                
                ForEach(sampleGifts, id: \.self) {sampleGift in
                    ZStack {
                        HStack {
                            GiveOrTakeTag(sampleGift: sampleGift)
                            Spacer()
                        }
                        GiftCardView(sampleGift: sampleGift)
                    }
                }
                Spacer()
            }
        }
        .padding()
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

// MARK: - GiftCardView
struct GiftCardView: View {
    var sampleGift: BdayGift
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .foregroundStyle(.gray.opacity(0.2))
                .frame(maxWidth: .infinity)
                .frame(height: 100)
                .padding(.leading, 32)
            
            VStack {
                HStack {
                    if let imageData = sampleGift.giftImage, let uiImage = UIImage(data: imageData) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 80)
                            .clipShape(.rect(cornerRadius: 20))
                        
                    } else {
                        Image("starrynight")
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
            .padding(.leading, 44)
        }
    }
}


// MARK: - GiveOrTakeTag
struct GiveOrTakeTag: View {
    var sampleGift: BdayGift
    
    var body: some View {
        if sampleGift.isToBeGiven {
            
            Text("받은")
                .font(.bday_c2Regular)
                .foregroundStyle(.white)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .multilineTextAlignment(.center)
                .background(.blue)
                .clipShape(.capsule)
            
        } else {
            
            Text("준")
                .font(.bday_c2Regular)
                .foregroundStyle(.blue)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(Color.init(hex: "C6E7FF"))
                .clipShape(.capsule)
            
        }
        

    }
}


#Preview {
    NavigationStack {
        GiveAndTakeView()
    }
    .modelContainer(for: BdayGift.self)
}


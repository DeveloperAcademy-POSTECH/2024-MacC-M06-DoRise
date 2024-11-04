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
        ZStack{
            
            RoundedRectangle(cornerRadius: 12)
                .foregroundStyle(.gray.opacity(0.2))
                .frame(maxWidth: .infinity)
                .frame(height: 100)
                .padding(.leading, 16)
            
            HStack {
                if sampleGift.isToBeGiven {
                    
                    Text("받은")
                        .font(.bday_c2Regular)
                        .foregroundStyle(.white)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .multilineTextAlignment(.center)
                        .background(.blue)
                        .padding(0)
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
                
                VStack(alignment: .leading) {
                    HStack {
                        if let imageData = sampleGift.giftImage, let uiImage = UIImage(data: imageData) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 80)
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
            }
        }
    }
}

#Preview {
    NavigationStack {
        GiveAndTakeView()
    }
    .modelContainer(for: BdayGift.self)
}


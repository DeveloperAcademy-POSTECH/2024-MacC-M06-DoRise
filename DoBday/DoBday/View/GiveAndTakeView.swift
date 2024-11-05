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
        NavigationStack {   // 나중에 지워야 함
            ZStack {
                HStack {
                    Rectangle()
                        .frame(width: 1)
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
                        SaveGiftView()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }   // NaviStack 나중에 지우세요
    }
}


// MARK: - GiftCardView
struct GiftCardView: View {
    var sampleGift: BdayGift
    
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                RoundedRectangle(cornerRadius: 12)
                    .foregroundStyle(.gray.opacity(0.2))
                    .frame(maxWidth: .infinity)
                    .frame(height: max(geometry.size.height, 100))
                    .padding(.leading, 32)
            }
            
            VStack {
                HStack {
                    if let imageData = sampleGift.giftImage, let uiImage = UIImage(data: imageData) {
                        Image(uiImage: uiImage)
                            .giftCardViewImgViewModifier()
                        
                    } else {
                        Image("starrynight")
                            .giftCardViewImgViewModifier()
                    }
                    
                    VStack(alignment: .leading) {
                        Text(sampleGift.giftName)
                            .font(.bday_t3Emphasized)
                        
                        if sampleGift.isToBeGiven {
                            if let giftPrice = sampleGift.giftPrice {
                                Text("가격 \(giftPrice)")
                            }
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
                .giveOrTakeTagTextViewModifier(.blue)
        } else {
            
            Text("내가 준")
                .giveOrTakeTagTextViewModifier(.green)
            
        }
        

    }
}


// MARK: - ViewModifier extension
extension View {
        
    /// GiveOrTakeTag의 Text에 쓰이는 ViewModifier 입니다.
    func giveOrTakeTagTextViewModifier(_ color: Color) -> some View { self
        .font(.bday_c2Regular)
        .foregroundStyle(.white)
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(color)
        .clipShape(.capsule)
    }
}

extension Image {
    /// GiftCardView에서 Img에 쓰이는 ViewModifier입니다.
    func giftCardViewImgViewModifier() -> some View { self
            .resizable()
            .scaledToFit()
            .frame(width: 100, height: 80)
            .clipShape(.rect(cornerRadius: 20))
    }
}



#Preview {
    NavigationStack {
        GiveAndTakeView()
    }
    .modelContainer(for: BdayGift.self)
}


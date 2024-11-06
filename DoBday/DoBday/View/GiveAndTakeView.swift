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
    @State private var selectedGifts: Set<UUID> = [] // 선택된 선물의 UUID를 저장하는 Set임.
    
    
    var body: some View {
            // 선택 및 삭제 버튼 영역.
            VStack {
                HStack {
                    // 전체 선택/해제 버튼
                    Button(action: toggleSelectAll) {
                        HStack {
                            Image(systemName: selectedGifts.count == bdayGifts.count ? "checkmark.circle.fill" : "circle")
                                .foregroundColor(.gray)
                            Text("전체선택(\(selectedGifts.count)/\(bdayGifts.count))")
                                .font(.bday_footEmphasized)
                                .foregroundColor(.gray)
                        }
                    }
                    Spacer()
                    // 선택된 항목 삭제 버튼
                    Button(action: deleteSelectedGifts) {
                        Text(selectedGifts.count == bdayGifts.count ? "전체삭제" : "선택삭제") // 모든 항목 선택 시 텍스트가 '전체삭제'로 변경됨.
                            .font(.bday_footEmphasized)
                            .font(.bday_footEmphasized)
                            .foregroundColor(selectedGifts.count == 0 ? .gray : .black)
                    }
                }
                .padding(.horizontal)
                .padding(.top, 8)
                
                Divider()
                    .padding(.horizontal)
            }
            
            ScrollView{
                ZStack {
                    // 타임라인 효과를 위한 세로 선
                    HStack {
                        Rectangle()
                            .frame(width: 1)
                            .frame(maxHeight: .infinity)
                            .padding(.leading, 12)
                            .foregroundColor(.gray)
                        Spacer()
                    }
                    VStack(alignment: .leading) {
                        Text("2024") // 연도는 일단 2024만
                            .font(.bday_t1Emphasized)
                            .padding(.leading, 32)
                        
                        VStack(alignment: .leading) {
                            ForEach(bdayGifts, id: \.id) { gift in
                                HStack {
                                    // 개별 선택 체크박스
                                    Button(action: {
                                        toggleSelection(for: gift.id)
                                    }) {
                                        CustomCheckBox(isChecked: selectedGifts.contains(gift.id), color: gift.isToBeGiven ? .green : .blue)
                                        
                                    }.padding(.leading, 3)
                                    // 선물 카드 뷰
                                    GiftCardView(sampleGift: gift).padding(.horizontal, 8)
                                }
                            }
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
        }
    }   // NaviStack 나중에 지우세요


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
                
                // 선물 이미지 (이미지가 없으면 기본 이미지 표시)
                if let imageData = sampleGift.giftImage, let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 64, height: 64)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .padding(8)
                } else {
                    Image("starrynight")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 64, height: 64)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .padding(8)
                }
                
                // 오른쪽 화살표 아이콘
                Image(systemName: "chevron.right")
                    .padding(.trailing, 35)
                    .font(.system(size: 16))
                    .foregroundColor(sampleGift.isToBeGiven ? Color.green : Color.blue)
            }
        }
    }
}

// MARK: - CustomCheckBox
struct CustomCheckBox: View {
    var isChecked: Bool
    var color: Color
    
    var body: some View {
        ZStack {
            Circle()
                .strokeBorder(color, lineWidth: 2)
                .background(Circle().fill(Color.white))
                .frame(width: 20, height: 20)
            
            if isChecked {
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.white)
                    .background(Circle().fill(color)) // `color` 값을 사용해 조건부 색상 설정.
            }
        }
    }
}



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


// MARK: - ViewModifier extension
extension View {
    
    /// GiveOrTakeTag의 Text에 쓰이는 ViewModifier 입니다.
    func giveOrTakeTagTextViewModifier(_ color: Color) -> some View { self
        .font(.bday_c2Emphasized)
        .foregroundStyle(.white)
        .padding(.horizontal, 10)
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

// MARK: - 삭제기능 extension
extension GiveAndTakeView {
    /// 전체 선택/해제 기능
    func toggleSelectAll() {
        if selectedGifts.count == bdayGifts.count {
            selectedGifts.removeAll()
        } else {
            selectedGifts = Set(bdayGifts.map { $0.id })
        }
    }
    
    /// 개별 선택/해제 기능
    func toggleSelection(for id: UUID) {
        if selectedGifts.contains(id) {
            selectedGifts.remove(id)
        } else {
            selectedGifts.insert(id)
        }
    }
    
    /// 선택된 항목 삭제 기능
    func deleteSelectedGifts() {
        for id in selectedGifts {
            if let gift = bdayGifts.first(where: { $0.id == id }) {
                context.delete(gift)
            }
        }
        selectedGifts.removeAll()
        try? context.save() // 삭제 후 변경사항 저장
    }
}



#Preview {
    NavigationStack {
        GiveAndTakeView()
    }
    .modelContainer(for: BdayGift.self)
}


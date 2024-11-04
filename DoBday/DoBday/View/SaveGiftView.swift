//
//  SaveGiftView.swift
//  DoBday
//
//  Created by 이소현 on 11/4/24.
//

import SwiftUI
import SwiftData
import PhotosUI

struct SaveGiftView: View {
    
    // MARK: - Property
    @Environment(\.modelContext) var context
//    @Bindable var bdayGift: BdayGift
//    @Query var bdayGift: BdayGift
    
//    var bdayGift: BdayGift
    
    @State var giftName: String = ""
    @State var giftPrice: String = ""
    @State var memo: String = ""
    @State private var selectedItem: PhotosPickerItem?
    
    
    var body: some View {
        VStack {
            PhotosPicker(selection: $selectedItem, matching: .images) {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .frame(width: 140, height: 160)
                        .foregroundStyle(.gray.opacity(0.2))
                    
                    Image(systemName: "photo.badge.plus")
                        .font(.largeTitle)
                        .foregroundStyle(.gray)
                }
            }
            .padding(.bottom, 8)
            
            HStack {
                makeIsToBeGivenButton(text: "받은 선물")
                makeIsToBeGivenButton(text: "준 선물")
            }
            .padding(.bottom)
            
            
            VStack(alignment: .leading) {
                makeTextAndField(text: "선물 이름", textField: $giftName)
                    .padding(.bottom, 16)
                makeTextAndField(text: "가격", textField: $giftPrice)
                    .padding(.bottom, 16)
                
                Text("메모")
                    .font(.bday_bodyEmphasized)
                TextEditor(text: $memo)
                    .scrollContentBackground(.hidden)
                    .padding()
                    .background(.gray.opacity(0.2))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            
        }
        .padding()
        .navigationTitle("주고 싶은 선물")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    
                } label: {
                    Text("추가")
                }

            }
        }
    }
}


// MARK: - extension SaveGiftView
extension SaveGiftView {
    /// Text와 TextField를 생성하는 함수입니다.
    func makeTextAndField(text: String, textField: Binding<String>) -> some View {
        VStack(alignment: .leading) {
            Text(text)
                .font(.bday_bodyEmphasized)
            TextField("", text: textField)
                .padding()
                .background(.gray.opacity(0.2))
                .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }
    
    func makeIsToBeGivenButton(text: String) -> some View {
        Text(text)
            .font(.bday_callRegular)
            .foregroundStyle(.blue)
            .padding(.vertical, 8)
            .frame(width: 80)
            .background(.blue.opacity(0.2))
            .clipShape(.capsule)
    }
}

//#Preview {
//    NavigationStack {
//        SaveGiftView(bdayGift: sampleGifts.first ?? BdayGift(
//            id: UUID(),
//            isToBeGiven: true,
//            giftName: "꽃다발",
//            giftPrice: "₩30,000",
//            giftImage: nil,
//            memo: "생일에 맞춰 전달 예정",
//            giftURL: "https://flowershop.com/bouquet"
//        ))
//    }
//    .modelContainer(for: BdayGift.self)
//}

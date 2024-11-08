//
 //  GiveAndTakeView.swift
 //  DoBday
 //
 //  Created by 이소현 on 11/4/24.
 //

 import SwiftUI
 import SwiftData

 struct GiveAndTakeView: View {

     var name: String

     @Environment(\.modelContext) var context
     @Query var bdayGifts: [BdayGift]
     @State private var selectedGifts: Set<UUID> = [] // 선택된 선물의 UUID를 저장하는 Set임.


     var body: some View {
         // 선택 및 삭제 버튼 영역.
         VStack {

             GiftDeleteSection(bdayGifts: bdayGifts, selectedGifts: $selectedGifts)

             Divider()
                 .padding(.horizontal)
         }

         ScrollView{
             ZStack {
                 GiftTimeLineSection()

                 VStack(alignment: .leading) {
                     // TODO: 선물을 받는 일자에 따라 연도가 달라지게 수정해야 함
                     Text("2024")
                         .font(.bday_t1Emphasized)
                         .padding(.leading, 32)

                     GiftCardForEachView(bdayGifts: bdayGifts, selectedGifts: $selectedGifts)

                 }
                 Spacer()
             }

         }
         .padding()
         .navigationTitle("\(name)와의 선물기록")
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
 }



 #Preview {
     NavigationStack {
         GiveAndTakeView(name: "마일스")
     }
     .modelContainer(for: BdayGift.self)
 }

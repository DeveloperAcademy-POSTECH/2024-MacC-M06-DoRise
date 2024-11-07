//
//  CardListView.swift
//  DoBday
//
//  Created by 이소현 on 11/7/24.
//
import SwiftUI

// MARK: - CardListView
struct CardListView: View {
    @Environment(\.modelContext) var context
    
    @State private var showingAlert = false
    @State var selectedBday: Bday?
    
    var bdays: [Bday]
    @Binding var clickedBdays: [Bday]
    
    // TODO: 새로운 tag 모델로 갈아끼우면 삭제할 것
    let relationshipDictionary: [String : Color] = ["#가족": Color.init(hex: "FFA1A1"), "#친구": Color.init(hex: "FFEBA1"), "#지인": Color.init(hex: "C9F69C"), "#비지니스": Color.init(hex: "A1ACFF")]
    
    var body: some View {

        VStack(alignment: .leading) {
            List {
                ForEach(clickedBdays, id: \.id) { bday in
                    NavigationLink {
                        PersonDetailView(bday: bday)
                    } label: {
                        HStack {
                            if let profileImage = bday.profileImage, let uiImage = UIImage(data: profileImage) {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .frame(width: 80, height: 80)
                                    .clipShape(Circle())
                                    .padding(.trailing, 10)
                            } else {
                                Image("basicprofile")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 80, height: 80)
                                    .clipShape(Circle())
                                    .padding(.trailing, 10)
                            }
                            
                                VStack(alignment: .leading) {
                                Text(bday.name)
                                    .padding(.horizontal, 8)
//                                Text(bday.relationshipTag)
//                                    .padding(.horizontal, 8)
//                                    .padding(.vertical, 4)
//                                    .background(
//                                        // TODO: 새로운 relationshipTag 모델로 갈아끼워야 함
//                                        relationshipDictionary[bday.relationshipTag]?.opacity(0.5) ?? .gray.opacity(0.2)
//                                    )
//                                    .clipShape(.capsule)
                            }
                            .foregroundStyle(.primary)
                        }
                    }
                }
                .onDelete(perform: showAlertBeforeDelete)
                .listRowSeparator(.hidden)
                .listRowBackground(
                    RoundedRectangle(cornerRadius: 12)
                        .background(.clear)
                        .foregroundStyle(.gray.opacity(0.2))
                        .padding(
                            EdgeInsets(
                                top: 2,
                                leading: 10,
                                bottom: 2,
                                trailing: 10
                            )
                        )
                )
            }
            .listRowInsets(.none)
            .listStyle(.plain)
            .alert("생일 기록을 삭제하시겠습니까?", isPresented: $showingAlert) {
                Button("취소", role: .cancel) {
                    showingAlert = false
                }
                Button("삭제", role: .destructive) {
                    
                    if let bdayToRemove = selectedBday {
                        context.delete(bdayToRemove)
                        clickedBdays.removeAll { $0.id == bdayToRemove.id }
                    }
                }
            }
        }
    }
    
    // MARK: - CardListView Method
    /// 삭제 경고창을 띄우기 전 호출되는 함수입니다.
    func showAlertBeforeDelete(at offsets: IndexSet) {
        if let index = offsets.first {
            selectedBday = clickedBdays[index]
            showingAlert = true
        }
    }
}

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
    
    
    var body: some View {
        
        VStack(alignment: .leading) {
            List {
                ForEach(clickedBdays, id: \.id) { bday in
                    NavigationLink {
                        PersonDetailView(bday: bday)
                    } label: {
                        HStack {
                            
                            PhotoPickerCircle(profileImage: bday.profileImage, alternativeImage: "basicprofile")
                            
                            VStack(alignment: .leading) {
                                Text(bday.name)
                                    .padding(.horizontal, 8)
                                
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

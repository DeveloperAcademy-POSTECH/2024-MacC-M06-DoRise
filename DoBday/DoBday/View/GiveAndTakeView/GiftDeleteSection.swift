//
//  GiftDeleteSection.swift
//  DoBday
//
//  Created by 이소현 on 11/8/24.
//
import SwiftUI

// MARK: - GiftDeleteSection
struct GiftDeleteSection: View {
    @Environment(\.modelContext) var context
    var bdayGifts: [BdayGift]
    @Binding var selectedGifts: Set<UUID>
    
    var body: some View {
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
        
    }
}


// MARK: - 삭제기능 extension
extension GiftDeleteSection {
    
    /// 전체 선택/해제 기능
    func toggleSelectAll() {
        if selectedGifts.count == bdayGifts.count {
            selectedGifts.removeAll()
        } else {
            selectedGifts = Set(bdayGifts.map { $0.id })
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


// Set에 대한 extension으로 toggleSelection 메서드 추가
extension Set where Element: Equatable {
    /// 주어진 요소가 포함되어 있으면 제거하고, 포함되어 있지 않으면 추가하는 기능
    mutating func toggleSelection(for element: Element) {
        if self.contains(element) {
            self.remove(element)
        } else {
            self.insert(element)
        }
    }
}


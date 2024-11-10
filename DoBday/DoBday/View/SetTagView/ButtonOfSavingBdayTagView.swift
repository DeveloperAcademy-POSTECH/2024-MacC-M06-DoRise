//
//  ButtonOfSavingBdayTagView.swift
//  DoBday
//
//  Created by Hajin on 11/7/24.
//
import SwiftUI

struct ButtonOfSavingBdayTagView: View {
    @Environment(\.modelContext) var contextForBdayTag

    @Binding var tagName: String
    @Binding var tagColor: String
    @Binding var isshowingSheetForCreatingTag: Bool

    var body: some View {
        VStack {
            Button {
                saveBdayTag()
                isshowingSheetForCreatingTag.toggle()

            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.black)
                        .frame(width: 340, height: 60)
                    Text("추가")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                }
            }
        }
    }
}

extension ButtonOfSavingBdayTagView {
    func saveBdayTag() {
        let newBdayTag = BdayTag(id: UUID(), tagName: tagName, tagColor: tagColor)
        contextForBdayTag.insert(newBdayTag)
    }
}

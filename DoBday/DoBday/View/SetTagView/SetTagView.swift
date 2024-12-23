//
//  SetTagView.swift
//  DoBday
//
//  Created by Hajin on 11/5/24.
//

import SwiftUI

struct SetTagView: View {

    var bdayTags: BdayTag?

    @State private var tagName = ""
    @State private var tagColor = "F0F0F0"

    @Binding var isshowingSheetForCreatingTag: Bool

    var body: some View {
        VStack {

            HStack(alignment: .bottom) {
                Text("태그 생성")
                    .font(.system(size: 30, weight: .bold))

                Spacer()
            }.padding(.init(top: 5, leading: 0, bottom: 20, trailing: 0))


            TextFieldForTagView(tagName: $tagName)
            ChoosingColorOfTagView(tagColor: $tagColor)

            Spacer()

            ButtonOfSavingBdayTagView(tagName: $tagName, tagColor: $tagColor, isshowingSheetForCreatingTag: $isshowingSheetForCreatingTag)
        }
        .padding(.init(top: 40, leading: 20, bottom: 0, trailing: 20))
    }
}









//#Preview {
//    SetTagView()
//}

//
//  SetTagView.swift
//  DoBday
//
//  Created by Hajin on 11/5/24.
//

import SwiftUI

struct SetTagView: View {
    @Environment(\.modelContext) var contextForBdayTag

    @Binding var isshowingSheetForCreatingTag: Bool

    var bdayTags: BdayTag?

    @State private var tagName = ""
    @State private var tagColor = "F0F0F0"

    let colors: [String] = ["2364AA", "3DA5D9", "73BFB9", "FEC601", "EA7317", "FFC97F", "EB7777", "EB8291", "F0BBCD", "C9E7DB"]

    let columns: [GridItem] = [
            GridItem(.fixed(50), spacing: nil, alignment: nil),
            GridItem(.fixed(50), spacing: nil, alignment: nil),
            GridItem(.fixed(50), spacing: nil, alignment: nil),
            GridItem(.fixed(50), spacing: nil, alignment: nil),
            GridItem(.fixed(50), spacing: nil, alignment: nil)
        ]

    var body: some View {
        VStack {

            HStack(alignment: .bottom) {
                Text("태그 생성")
                    .font(.system(size: 30, weight: .bold))

                Spacer()
            }.padding(.init(top: 5, leading: 0, bottom: 20, trailing: 0))

            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.init(hex: "F0F0F0"))
                    .frame(width: 324, height: 48)

                TextField("입력한 내용을 태그 목록에 추가됩니다.", text: $tagName)
                    .textFieldStyle(.plain)
                    .padding(.init(top: 0, leading: 25, bottom: 0, trailing: 25))
            }.padding(.init(top: 0, leading: 25, bottom: 20, trailing: 25))

            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.init(hex: "F0F0F0"))
                    .frame(width: 324, height: 103)

                LazyVGrid(columns: columns) {
                    ForEach(colors, id: \.self) { color in
                        Button {
                            tagColor = color
                        } label: {
                            ZStack {
                                Circle()
                                    .fill(Color.init(hex: color))
                                    .frame(width: 30)
                                if tagColor == color {
                                    Circle()
                                        .fill(.black)
                                        .opacity(0.2)
                                        .frame(width: 30)
                                    Image(systemName: "checkmark")
                                        .font(.system(size: 20, weight: .bold))
                                        .foregroundColor(.white)
                                }
                            }
                        }
                    }
                }
            }

            Spacer()

            Button {
                SaveBdayTag()
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
        .padding(.init(top: 40, leading: 20, bottom: 0, trailing: 20))
    }

    func SaveBdayTag() {
        let newBdayTag = BdayTag(id: UUID(), tagName: tagName, tagColor: tagColor)
        contextForBdayTag.insert(newBdayTag)
    }
}

//#Preview {
//    SetTagView()
//}

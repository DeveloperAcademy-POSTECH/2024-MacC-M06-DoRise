//
//  ShowingTasteCollageView.swift
//  DoBday
//
//  Created by Hajin on 11/7/24.
//
import SwiftUI

struct ShowingTasteCollageView: View {

    @Binding var name: String

    var body: some View {
        //MARK: 취향 콜라주
        HStack {
            Text("취향 콜라보")
                .font(.system(size: 18, weight: .semibold))

            Spacer()

            Image(systemName: "chevron.right")
                .foregroundColor(.blue)
        }
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.init(hex: "F0F0F0"))
                .frame(width: 353, height: 159)

            Text("아직 \(name)님의 취향을 담지 않았아요!")
                .font(.system(size: 14, weight: .semibold))
        }
        .padding(.init(top: 0, leading: 0, bottom: 11, trailing: 0))

    }
}

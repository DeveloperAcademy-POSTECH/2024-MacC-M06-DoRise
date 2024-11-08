//
//  ShowingPresentForGivingToYouView.swift
//  DoBday
//
//  Created by Hajin on 11/7/24.
//
import SwiftUI


struct ShowingPresentForGivingToYouView: View {

    var body: some View {
        //MARK: 주고 싶은 선물
        HStack {
            Text("주고 싶은 선물")
                .font(.system(size: 18, weight: .semibold))

            Spacer()

            Image(systemName: "chevron.right")
                .foregroundColor(.blue)
        }
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ZStack(alignment: .top) {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.init(hex: "F0F0F0"))
                        .frame(width: 132, height: 159)

                    VStack {
                        Image("basicprofile")
                            .scaledToFit()
                            .frame(width: 131, height: 103)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .padding(.init(top: 0, leading: 0, bottom: 9, trailing: 0))

                        Text("반 고흐 명화 레고")
                            .font(.system(size: 12, weight: .medium))

                    }
                }
            }
        }
        .padding(.init(top: 0, leading: 0, bottom: 11, trailing: 0))

    }
}

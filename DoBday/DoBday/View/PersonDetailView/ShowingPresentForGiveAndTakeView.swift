//
//  ShowingPresentForGiveAndTakeView.swift
//  DoBday
//
//  Created by Hajin on 11/7/24.
//
import SwiftUI

struct ShowingPresentForGiveAndTakeView: View {
    
    @Binding var name: String

    var body: some View {
        //MARK: 주고받은 선물 리스트
        NavigationLink {
            // TODO: bday.name 확인하고 구현하기 
            GiveAndTakeView(name: name)
        } label: {
            HStack {
                Text("주고받은 선물 리스트")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.black)


                Spacer()

                Image(systemName: "chevron.right")
                    .foregroundColor(.blue)
            }
        }
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ZStack(alignment: .top) {
                    Image("basicprofile")
                        .scaledToFit()
                        .frame(width: 128, height: 128)
                        .clipShape(RoundedRectangle(cornerRadius: 20))

                    ZStack {
                        RoundedRectangle(cornerRadius: 40)
                            .fill(.blue)
                            .frame(width: 91, height: 34)

                        Text("받은 선물")
                            .font(.system(size: 15, weight: .regular))
                            .foregroundColor(.white)
                    }.offset(y: -15)

                }.padding(.init(top: 15, leading: 0, bottom: 0, trailing: 0))
            }
        }
    }
}

//
//  ShowingProfileOfPersonView.swift
//  DoBday
//
//  Created by Hajin on 11/7/24.
//
import SwiftUI

struct ShowingProfileOfPersonView: View {

    var bday: Bday?
    @Binding var name: String
    @Binding var dateOfBday: Date

    var body: some View {
        //MARK: 본인 프로필
        NavigationLink {
            SaveBdayView(bday: bday)
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.init(hex: "F0F0F0"))
                    .frame(width: 353, height: 127)
                HStack {
                    if let profileImage = bday?.profileImage, let uiImage = UIImage(data: profileImage) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            .padding(.init(top: 0, leading: 35, bottom: 0, trailing: 0))
                    } else {
                        Image("basicprofile")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            .padding(.init(top: 0, leading: 35, bottom: 0, trailing: 0))
                    }

                    VStack(alignment: .leading) {
                        HStack(alignment: .bottom) {
                            Text(name)
                                .foregroundColor(.black)
                                .font(.system(size: 18, weight: .bold))
//                                Text(relationshipTag)
//                                    .foregroundColor(.black)
//                                    .font(.system(size: 12, weight: .regular))
                        }
                        Text("\(dateOfBday, formatter: SaveBdayView.dateFormat)")
                            .foregroundColor(.black)
                            .font(.system(size: 18, weight: .regular))
                    }.padding(.init(top: 0, leading:47, bottom: 0, trailing: 0))

                    Spacer()
                }
                VStack {
                    HStack {
                        Spacer()
                        Image(systemName: "square.and.pencil")
                            .font(.system(size: 20, weight: .regular))
                            .foregroundColor(.blue)
                    }
                    Spacer()
                }.padding(.init(top: 20, leading:15, bottom: 5, trailing: 15))
            }
        }
        .padding(.init(top: 0, leading: 0, bottom: 11, trailing: 0))
    }
}

//
//  PersonDetailView.swift
//  DoBday
//
//  Created by Hajin on 11/3/24.
//

import SwiftUI

struct PersonDetailView: View {

    @State private var name = ""
    @State private var profileImage = ""
    @State private var dateOfBday: Date = Date()
    @State private var isLunar = false
    @State private var notiFrequency = [""]
    @State private var relationshipTag = ""

    @State private var isshowingSheet = false

    var bday: Bday?

    init(bday: Bday? = nil) {
        self.bday = bday
        if let bday = bday {
            _name = State(initialValue: bday.name)
            _profileImage = State(initialValue: bday.profileImage ?? "")
            _dateOfBday = State(initialValue: bday.dateOfBday ?? Date())
            _isLunar = State(initialValue: bday.isLunar)
            _notiFrequency = State(initialValue: bday.notiFrequency)
            _relationshipTag = State(initialValue: bday.relationshipTag)
        }
    }

    var body: some View {
        VStack {

            //MARK: 본인 프로필
            NavigationLink {
                SaveBdayView(bday: bday)
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.init(hex: "F0F0F0"))
                        .frame(width: 353, height: 127)
                    HStack {
                        Image("basicprofile")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            .padding(.init(top: 0, leading: 35, bottom: 0, trailing: 0))

                        VStack(alignment: .leading) {
                            HStack(alignment: .bottom) {
                                Text(name)
                                    .font(.system(size: 18, weight: .bold))
                                Text(relationshipTag)
                                    .font(.system(size: 12, weight: .regular))
                            }
                            Text("\(dateOfBday, formatter: SaveBdayView.dateFormat)")
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

            //MARK: 취향 콜라주
            HStack {
                Text("주고 싶은 선물")
                    .font(.system(size: 18, weight: .semibold))

                Spacer()

                Image(systemName: "chevron.right")
                    .foregroundColor(.blue)
            }
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.init(hex: "F0F0F0"))
                    .frame(width: 353, height: 159)

                Text("아직 마일스님의 취향을 담지 않았아요!")
                    .font(.system(size: 14, weight: .semibold))
            }
            .padding(.init(top: 0, leading: 0, bottom: 11, trailing: 0))

            //MARK: 주고받은 선물 리스트
            HStack {
                Text("주고받은 선물 리스트")
                    .font(.system(size: 18, weight: .semibold))

                Spacer()

                Image(systemName: "chevron.right")
                    .foregroundColor(.blue)
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
        .padding(.init(top: 0, leading: 20, bottom: 0, trailing: 20))
    }
}

#Preview {
    PersonDetailView()
}

//
//  SaveBdayView.swift
//  DoBday
//
//  Created by Hajin on 10/17/24.
//

import SwiftUI
import SwiftData
import PhotosUI

import KoreanLunarSolarConverter

struct SaveBdayView: View {
    //모델에 대한 모든 변경사항 관찰하고 작동할 많은 작업을 제공함.
    @Environment(\.modelContext) var context

    @State private var name = ""
    @State private var profileImage: Data?
    @State private var dateOfBday: Date = Date()
    @State private var isLunar = false
    @State private var notiFrequency = [""]
    @State private var relationshipTag = [""]

    @State private var selectedItem: PhotosPickerItem?

    @State private var isshowingSheetForSettingDate = false
    @State private var isshowingSheetForCreatingTag = false

    var bday: Bday?

    @Query var bdayTags: [BdayTag]

    init(bday: Bday? = nil) {
        self.bday = bday
        if let bday = bday {
            _name = State(initialValue: bday.name)
            _profileImage = State(initialValue: bday.profileImage)
            _dateOfBday = State(initialValue: bday.dateOfBday ?? Date())
            _isLunar = State(initialValue: bday.isLunar)
            _notiFrequency = State(initialValue: bday.notiFrequency)
            _relationshipTag = State(initialValue: bday.relationshipTag)
        }
    }

    @Environment(\.dismiss) var dismiss

    @State private var imageData: Data?

    let relationshipDictionary: [String : Color] = ["#가족": Color.init(hex: "FFA1A1"), "#친구": Color.init(hex: "FFEBA1")]

    let notiArray: [String] = ["당일", "1일 전", "3일 전", "7일 전"]

    static let dateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY년 M월 d일"
        return formatter
    }()

    func lunarToFinalDate() {
        // 사용자가 음력을 선택했을 경우
        if isLunar {
            // 양력 -> 음력 변환
            if let lunarDate = KoreanLunarSolarConverter.instance.solarToLunar(date: dateOfBday) {
                // 변환된 음력 날짜를 현재 연도의 양력 날짜로 변환
                dateOfBday = KoreanLunarSolarConverter.instance.convertLunarToSolarForCurrentYear(lunarDate: lunarDate) ?? dateOfBday
            } else {
                // 음력 변환 실패 시, 기본으로 사용한 양력 날짜 사용
                dateOfBday = dateOfBday
            }
        } else {
            // 사용자가 음력을 선택하지 않았을 경우.
            dateOfBday = dateOfBday
        }
    }


    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    saveBday()
                    dismiss()
                } label: {
                    Text("저장")
                        .font(.system(size: 24, weight: .semibold))
                }
            }.padding(.init(top: 0, leading: 22, bottom: 0, trailing: 24))

            //MARK: 이미지 피커

            ZStack {
                    PhotosPicker(selection: $selectedItem, matching: .images) {
                        if let imageData = imageData, let uiImage = UIImage(data: imageData) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .clipShape(RoundedRectangle(cornerRadius: 45))
                                .frame(width: 112, height: 112)
                        } else {
                            ZStack {
                                Image("basicprofile")
                                    .resizable()
                                    .clipShape(RoundedRectangle(cornerRadius: 45))
                                    .frame(width: 112, height: 112)
                            }
                        }
                    }
                    .onChange(of: selectedItem) { oldItem, newItem in
                        Task {
                            if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                imageData = data
                            }
                        }
                    }

                Image("photologo")
                    .resizable()
                    .clipShape(Circle())
                    .frame(width: 30, height: 30)
                    .offset(x: 30, y: 40)
            }

            //MARK: 이름 설정
            HStack {
                Text("이름")
                    .font(.system(size: 18, weight: .semibold))
                Spacer()
            }.padding(.init(top: 5, leading: 45, bottom: 2, trailing: 45))

            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.init(hex: "F0F0F0"))
                    .frame(width: 324, height: 43)
                TextField("", text: $name)
                    .textFieldStyle(.plain)
                    .padding(.init(top: 0, leading: 20, bottom: 0, trailing: 20))
            }.padding(.init(top: 0, leading: 38, bottom: 0, trailing: 38))
                .onAppear (perform : UIApplication.shared.hideKeyboard)


            //MARK: 생일 날짜 설정
            HStack(alignment: .bottom) {
                Text("생일")
                    .font(.system(size: 18, weight: .semibold))

                Spacer()
            }.padding(.init(top: 5, leading: 45, bottom: 1, trailing: 45))

            HStack {

                Button {
                    isLunar = false
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 40)
                            .fill(Color.init(hex: "0A84FF"))
                            .opacity(!isLunar ? 1 : 0.15)
                            .frame(width: 74, height: 43)
                        Text("양력")
                            .foregroundColor(!isLunar ? .white : Color.init(hex: "0A84FF"))
                            .font(.system(size: 15, weight: !isLunar ? .bold : .regular))
                    }
                }

                Button {
                    isLunar = true
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 40)
                            .fill(Color.init(hex: "0A84FF"))
                            .opacity(isLunar ? 1 : 0.15)
                            .frame(width: 74, height: 43)
                        Text("음력")
                            .foregroundColor(isLunar ? .white : Color.init(hex: "0A84FF"))
                            .font(.system(size: 15, weight: isLunar ? .bold : .regular))
                    }
                }

                Button {
                    isshowingSheetForSettingDate.toggle()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 6)
                            .fill(Color.init(hex: "F0F0F0"))
                            .frame(width: 157, height: 43)
                        Text("\(dateOfBday, formatter: SaveBdayView.dateFormat)")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.blue)
                    }
                }
                .sheet(isPresented: $isshowingSheetForSettingDate) {
                    SetDateView(dateOfBday: $dateOfBday, isshowingSheetForSettingDate: $isshowingSheetForSettingDate, isLunar: $isLunar)
                        .presentationDragIndicator(.visible)
                        .presentationDetents([.medium])
                }

                Spacer()
            }.padding(.init(top: 0, leading: 38, bottom: 0, trailing: 38))

            //MARK: 태그 설정
            HStack {
                Text("태그")
                    .font(.system(size: 18, weight: .semibold))
                Spacer()
            }.padding(.init(top: 5, leading: 45, bottom: 2, trailing: 45))

            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(bdayTags, id:\.self) {relationship in
                        Button {
                            if relationshipTag.contains(relationship.tagName) {
                                relationshipTag.removeAll { $0 == relationship.tagName }
                            } else {
                                relationshipTag.append(relationship.tagName)
                            }
                        } label: {
                            ZStack {
                                Text(relationship.tagName)
                                    .font(.system(size: 15, weight: .bold))
                                    .foregroundColor(.black)
                                    .padding()
                                    .frame(height: 43)
                                    .background(Color.init(hex: relationship.tagColor))
                                    .cornerRadius(40)

                                if relationshipTag.contains(relationship.tagName) {
                                    Text(relationship.tagName)
                                        .font(.system(size: 15, weight: .bold))
                                        .foregroundColor(.clear)
                                        .padding()
                                        .frame(height: 43)
                                        .background(.black)
                                        .cornerRadius(40)
                                        .opacity(0.3)

                                    Image(systemName: "checkmark")
                                        .font(.system(size: 14.5, weight: .bold))
                                        .foregroundColor(.white)
                                }
                            }
                        }
                    }

                    Button {
                        isshowingSheetForCreatingTag.toggle()
                    } label: {
                        ZStack {
                            Text("+")
                                .font(.system(size: 15, weight: .bold))
                                .foregroundColor(Color.init(hex: "0A84FF"))
                                .padding()
                                .frame(height: 43)
                                .background(Color.init(hex: "0A84FF").opacity(0.15))
                                .cornerRadius(40)
                        }
                    }
                    .sheet(isPresented: $isshowingSheetForCreatingTag) {
                        SetTagView(isshowingSheetForCreatingTag: $isshowingSheetForCreatingTag)
                            .presentationDragIndicator(.visible)
                            .presentationDetents([.medium])
                    }

                }
            }.padding(.init(top: 0, leading: 38, bottom: 0, trailing: 38))

            //MARK: 알람 여부
            HStack {
                Text("알람 여부")
                    .font(.system(size: 18, weight: .semibold))
                Spacer()
            }.padding(.init(top: 5, leading: 45, bottom: 2, trailing: 45))

            HStack {
                Text("해당 날짜의 오전 9시에 생일 알림을 보내드려요")
                    .font(.system(size: 12, weight: .light))
                Spacer()
            }.padding(.init(top: 0, leading: 45, bottom: 2, trailing: 45))

            ScrollView(.horizontal, showsIndicators: false) {
                HStack  {
                    ForEach(notiArray, id: \.self) { noti in
                        Button {
                            if notiFrequency.contains(noti) {
                                notiFrequency.removeAll { $0 == noti }
                            } else {
                                notiFrequency.append(noti)
                            }
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 40)
                                    .fill(Color.init(hex: "0A84FF"))
                                    .opacity(notiFrequency.contains(noti) ? 1 : 0.15)
                                    .frame(width: 74, height: 43)
                                Text(noti)
                                    .foregroundColor(notiFrequency.contains(noti) ? .white : Color.init(hex: "0A84FF"))
                                    .font(.system(size: 15, weight: notiFrequency.contains(noti) ? .bold : .regular))
                            }
                        }
                    }
                }
            }.padding(.init(top: 0, leading: 38, bottom: 0, trailing: 38))

            Spacer()

        }
    }


    func saveBday() {
        //수정 혹은 생성 if else문 필요.
        //음력 변환 로직을 이 함수에 뺴냄.
        if let bday = bday {
            // 기존 생일 수정
            print("기존 생일 수정 중")
            bday.name = name
            bday.dateOfBday = dateOfBday
            bday.isLunar = isLunar
            bday.profileImage = imageData
            bday.notiFrequency = notiFrequency
            bday.relationshipTag = relationshipTag

        } else {
            lunarToFinalDate()

            // 새 생일 객체를 저장
            let newBday = Bday(id: UUID(), name: name, profileImage: imageData, dateOfBday: dateOfBday, isLunar: isLunar, notiFrequency: notiFrequency, relationshipTag: relationshipTag)
            context.insert(newBday)

            NotificationManager.instance.scheduleNotification(for: name, dateOfBday: dateOfBday, notiFrequency: notiFrequency)
        }
    }
}


//#Preview {
//    SaveBdayView()
//}
//
//  CreateBdayView.swift
//  DoBday
//
//  Created by Hajin on 10/17/24.
//

import SwiftUI
import SwiftData

struct CreateBdayView: View {
    //모델에 대한 모든 변경사항 관찰하고 작동할 많은 작업을 제공함.
    @Environment(\.modelContext) var context

    //property

    @State private var name = ""
    @State private var profileImage = ""
    @State private var dateOfBday: Date = Date()
    @State private var isLunar = true
    @State private var notiFrequency = ["알람 없음"]
    @State private var relationshipTag = ""

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


    @State var image: Image?
    @State var showImagePicker = false
    @State var selectedUIImage: UIImage?
    @State var imageData: Data?

    let relationshipDictionary: [String : Color] = ["#가족": Color.init(hex: "FFA1A1"), "#친구": Color.init(hex: "FFEBA1"), "#지인": Color.init(hex: "C9F69C"), "#비지니스": Color.init(hex: "A1ACFF")]

    let notiArray: [String] = ["당일", "1일 전", "3일 전", "7일 전"]

    func loadImage() {
        guard let selectedImage = selectedUIImage else { return }
        image = Image(uiImage: selectedImage)
        imageData = selectedImage.jpegData(compressionQuality: 1.0)
    }

    static let dateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY년 M월 d일"
        return formatter
    }()

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Spacer()
                    //추가 버튼
                    Button {
                        print("저장 시도 중")
                        saveBday()
                        print("저장 완료")
                    } label: {
                        Text("저장")
                            .font(.system(size: 24, weight: .semibold))
                    }
                }.padding(.init(top: 0, leading: 22, bottom: 0, trailing: 24))

                ZStack {
                    if let image = image {
                        image
                            .resizable()
                            .clipShape(RoundedRectangle(cornerRadius: 45))
                            .frame(width: 112, height: 112)
                    } else {
                        Image("basicprofile")
                            .resizable()
                            .clipShape(RoundedRectangle(cornerRadius: 45))
                            .frame(width: 112, height: 112)
                    }

                    Image("photologo")
                        .resizable()
                        .clipShape(Circle())
                        .frame(width: 30, height: 30)
                        .offset(x: 30, y: 40)

                    Button {
                        showImagePicker.toggle()
                    } label: {
                        RoundedRectangle(cornerRadius: 45
                        )
                        .fill(.clear)
                        .frame(width: 112, height: 112)

                    }
                    .sheet(isPresented: $showImagePicker, onDismiss: {
                        loadImage()
                    }) {
                        ImagePicker(image: $selectedUIImage)
                    }
                }


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

                HStack {
                    Text("태그")
                        .font(.system(size: 18, weight: .semibold))
                    Spacer()
                }.padding(.init(top: 5, leading: 45, bottom: 2, trailing: 45))

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(relationshipDictionary.keys.sorted(), id:\.self) {relationship in
                            Button {
                                relationshipTag = relationship
                            } label: {
                                ZStack {
                                    Text(relationship)
                                        .font(.system(size: 15, weight: .bold))
                                        .foregroundColor(.black)
                                        .padding()
                                        .frame(height: 43)
                                        .background(relationshipDictionary[relationship]!)
                                        .cornerRadius(40)

                                    if relationshipTag == relationship {
                                        Text(relationship)
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
                    }
                }.padding(.init(top: 0, leading: 38, bottom: 0, trailing: 38))

                HStack {
                    Text("알람 여부")
                        .font(.system(size: 18, weight: .semibold))
                    Spacer()
                }.padding(.init(top: 5, leading: 45, bottom: 2, trailing: 45))

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(notiArray, id:\.self) {noti in
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

                //                Button {
                //                    isLunar.toggle()
                //                } label: {
                //                    Rectangle()
                //                        .frame(width: 80, height: 40)
                //                        .foregroundColor(isLunar ? .red: .blue)
                //                }

                HStack(alignment: .bottom) {
                    Text("생일 날짜")
                        .font(.system(size: 18, weight: .semibold))

                    Text("(양력: \(dateOfBday, formatter: CreateBdayView.dateFormat))")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(.gray)

                    Spacer()
                }.padding(.init(top: 5, leading: 45, bottom: 1, trailing: 45))

                HStack {
                    Text("양력과 음력은 약 30일 정도 차이가 나요")
                        .font(.system(size: 8, weight: .semibold))
                        .foregroundColor(.gray)
                    Spacer()
                }.padding(.init(top: 0, leading: 45, bottom: 1, trailing: 45))

                DatePicker("Please enter a date", selection: $dateOfBday,
                           displayedComponents: .date)
                .datePickerStyle(WheelDatePickerStyle())
                .labelsHidden()
            }
        }
    }
        func saveBday() {
            if let bday = bday {
                // 기존 생일 수정
                print("기존 생일 수정 중")
                bday.name = name
                bday.dateOfBday = dateOfBday
                bday.isLunar = isLunar
                bday.profileImage = profileImage
                bday.relationshipTag = relationshipTag
            } else {
                // 새로운 생일 추가
                print("새 생일 추가 중")
                let newBday = Bday(id: UUID(), name: name, profileImage: profileImage, dateOfBday: dateOfBday, isLunar: isLunar, notiFrequency: notiFrequency, relationshipTag: relationshipTag)
                context.insert(newBday)
            }
    
            do {
                try context.save()  // 변경 사항 저장
                print("저장 완료")
            } catch {
                print("저장 중 오류 발생: \(error)")
            }
        }
}

#Preview {
    CreateBdayView()
}

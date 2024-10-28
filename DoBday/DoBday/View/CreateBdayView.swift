//
//  CreateBdayView.swift
//  DoBday
//
//  Created by Hajin on 10/17/24.
//

import SwiftUI
import KoreanLunarSolarConverter
import SwiftData

struct CreateBdayView: View {
    //모델에 대한 모든 변경사항 관찰하고 작동할 많은 작업을 제공함.
    @Environment(\.modelContext) var context
    
    @State private var name = ""
    @State private var profileImage = ""
    @State private var dateOfBday: Date = Date()
    @State private var isLunar = false
    @State private var notiFrequency = [""]
    @State private var relationshipTag = ""
    
    var bday: Bday?
    
    init(bday: Bday? = nil){
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
    
    @Environment(\.dismiss) var dismiss
    
    @State private var image: Image?
    @State private var showImagePicker = false
    @State private var selectedUIImage: UIImage?
    @State private var imageData: Data?
//    @State private var finalDate: Date
    
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
                    RoundedRectangle(cornerRadius: 45)
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
                HStack  {
                    ForEach(notiArray, id:\.self) { noti in
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
                
                Toggle(isOn: $isLunar) {
                    Text("음력으로 변환")
                }
            }.padding(.init(top: 0, leading: 45, bottom: 1, trailing: 45))
            
            DatePicker("Please enter a date", selection: $dateOfBday, displayedComponents: .date)
                .datePickerStyle(WheelDatePickerStyle())
                .labelsHidden()
            
            if isLunar {
                
                if let lunarDate = KoreanLunarSolarConverter.instance.solarToLunar(date: dateOfBday), let solarDateForCurrentYear =
                    KoreanLunarSolarConverter.instance.convertLunarToSolarForCurrentYear(lunarDate: lunarDate)
                    
                {
                    Text("음력으로 변환된 날짜: \(lunarDate, formatter: CreateBdayView.dateFormat)")
                    Text("현재 연도의 양력 생일: \(solarDateForCurrentYear, formatter: CreateBdayView.dateFormat)")
                }
            }
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
            bday.profileImage = profileImage
            bday.relationshipTag = relationshipTag
            
        } else {
            lunarToFinalDate()
            
            // 새 생일 객체를 저장
            let newBday = Bday(id: UUID(), name: name, profileImage: profileImage, dateOfBday: dateOfBday, isLunar: isLunar, notiFrequency: notiFrequency, relationshipTag: relationshipTag)
            context.insert(newBday)
            
            NotificationManager.instance.scheduleNotification(for: name, dateOfBday: dateOfBday, notiFrequency: notiFrequency)
        }
    }
    
}


#Preview {
    CreateBdayView()
}

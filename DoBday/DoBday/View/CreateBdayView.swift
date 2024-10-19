//////
//////  CreateBdayView.swift
//////  DoBday
//////
//////  Created by Hajin on 10/17/24.
//////
////
////import SwiftUI
////import SwiftData
////
////struct CreateBdayView: View {
////    //모델에 대한 모든 변경사항 관찰하고 작동할 많은 작업을 제공함.
////    @Environment(\.modelContext) var context
////
////    //property
////    //@Query: View에서 모델을 쓰고 싶을 때 씀
////    @Query var bdays: [Bday]
////
////    @State private var name = ""
////    @State private var profileImage = ""
////    @State private var dateOfBday: Date = Date()
////    @State private var isLunar = true
////    @State private var notiFrequency: [String] = []     
////    @State private var relationshipTag = ""
////
////    let relationshipDictionary: [String : Color] = ["#가족": .red, "#친구": .blue, "#지인": .yellow, "#비지니스": .green]
////
////    var body: some View {
////        NavigationView {
////            
////            VStack{
////                // 이름 입력 필드
////                            TextField("이름", text: $name)
////                                .textFieldStyle(.roundedBorder)
////                                .padding()
////                
////                DatePicker("생일 날짜 선택", selection: $dateOfBday, displayedComponents: .date)
////                    .datePickerStyle(WheelDatePickerStyle()) // 날짜 선택 스타일 설정
////                    .padding()
////
////                            // 알림 주기 선택 토글
////                            Toggle("당일", isOn: Binding(
////                                get: { notiFrequency.contains("당일") },
////                                set: { isSelected in
////                                    if isSelected {
////                                        notiFrequency.append("당일")
////                                    } else {
////                                        notiFrequency.removeAll(where: { $0 == "당일" })
////                                    }
////                                }
////                            ))
////
////                            Toggle("1일 전", isOn: Binding(
////                                get: { notiFrequency.contains("1일 전") },
////                                set: { isSelected in
////                                    if isSelected {
////                                        notiFrequency.append("1일 전")
////                                    } else {
////                                        notiFrequency.removeAll(where: { $0 == "1일 전" })
////                                    }
////                                }
////                            ))
////
////                            Toggle("3일 전", isOn: Binding(
////                                get: { notiFrequency.contains("3일 전") },
////                                set: { isSelected in
////                                    if isSelected {
////                                        notiFrequency.append("3일 전")
////                                    } else {
////                                        notiFrequency.removeAll(where: { $0 == "3일 전" })
////                                    }
////                                }
////                            ))
////
////                            Toggle("7일 전", isOn: Binding(
////                                get: { notiFrequency.contains("7일 전") },
////                                set: { isSelected in
////                                    if isSelected {
////                                        notiFrequency.append("7일 전")
////                                    } else {
////                                        notiFrequency.removeAll(where: { $0 == "7일 전" })
////                                    }
////                                }
////                            ))
////
////                            // 생일 추가 버튼
////                            Button("생일 추가") {
////                                let newBday = Bday(id: UUID(), name: name, profileImage: profileImage, dateOfBday: dateOfBday, isLunar: isLunar, notiFrequency: notiFrequency, relationshipTag: relationshipTag)
////
////                                // 알림 스케줄링 호출
////                                NotificationManager.instance.scheduleNotification(for: name, dateOfBday: dateOfBday, notiFrequency: notiFrequency)
////
////                                // 데이터베이스 저장 작업 등 생략
////                            }
////                            .padding()
////                        }
////            }
//////            VStack {
//////                //추가 버튼
//////                Button {
//////                    let newBday = Bday(id: UUID(), name: name, profileImage: profileImage, dateOfBday: dateOfBday, isLunar: isLunar, notiFrequency: notiFrequency, relationshipTag: relationshipTag)
//////                    context.insert(newBday)
//////                } label: {
//////                    Text("추가")
//////                }
//////
//////                TextField("이름", text: $name)
//////                                    .textFieldStyle(.roundedBorder)
//////                                    .padding()
//////
//////                TextField("이미지", text: $profileImage)
//////                                    .textFieldStyle(.roundedBorder)
//////                                    .padding()
//////
//////                Button {
//////                    isLunar.toggle()
//////                } label: {
//////                    Rectangle()
//////                        .frame(width: 80, height: 40)
//////                        .foregroundColor(isLunar ? .red: .blue)
//////                }
//////
//////                DatePicker("Please enter a date", selection: $dateOfBday,
//////                                   displayedComponents: .date)
//////                            .datePickerStyle(WheelDatePickerStyle())
//////                            .labelsHidden()
//////                
//////                
//////            }
////        }
////    
////}
////
////#Preview {
////    CreateBdayView()
////}
//
////
////  CreateBdayView.swift
////  DoBday
////
////  Created by Hajin on 10/17/24.
////
//
//import SwiftUI
//import SwiftData
//
//struct CreateBdayView: View {
//    //모델에 대한 모든 변경사항 관찰하고 작동할 많은 작업을 제공함.
//    @Environment(\.modelContext) var context
//
//    //property
//    //@Query: View에서 모델을 쓰고 싶을 때 씀
//    @Query var bdays: [Bday]
//
//    @State private var name = ""
//    @State private var profileImage = ""
//    @State private var dateOfBday: Date = Date()
//    @State private var isLunar = true
//    @State private var notiFrequency: [String] = []
//    @State private var relationshipTag = ""
//
//    let relationshipDictionary: [String : Color] = ["#가족": .red, "#친구": .blue, "#지인": .yellow, "#비지니스": .green]
//
//    var body: some View {
//        NavigationView {
//            VStack {
//                //추가 버튼
//                Button {
//                    let newBday = Bday(id: UUID(), name: name, profileImage: profileImage, dateOfBday: dateOfBday, isLunar: isLunar, notiFrequency: notiFrequency, relationshipTag: relationshipTag)
//                    context.insert(newBday)
//                } label: {
//                    Text("추가")
//                }
//
//                TextField("이름", text: $name)
//                                    .textFieldStyle(.roundedBorder)
//                                    .padding()
//
//                TextField("이미지", text: $profileImage)
//                                    .textFieldStyle(.roundedBorder)
//                                    .padding()
//
//                Button {
//                    isLunar.toggle()
//                } label: {
//                    Rectangle()
//                        .frame(width: 80, height: 40)
//                        .foregroundColor(isLunar ? .red: .blue)
//                }
//
//                DatePicker("Please enter a date", selection: $dateOfBday,
//                                   displayedComponents: .date)
//                            .datePickerStyle(WheelDatePickerStyle())
//                            .labelsHidden()
//
//                TextField("알람 기간", text: $notiFrequency)
//                                    .textFieldStyle(.roundedBorder)
//                                    .padding()
//            }
//        }
//    }
//}
//
//#Preview {
//    CreateBdayView()
//}

import SwiftUI
import SwiftData

struct CreateBdayView: View {
    @Environment(\.modelContext) var context

    @Query var bdays: [Bday]

    @State private var name = ""
    @State private var profileImage = ""
    @State private var dateOfBday: Date = Date()
    @State private var isLunar = true
    @State private var notiFrequency: [String] = [] // 배열로 변경
    @State private var relationshipTag = ""

    // 알림 주기 옵션
    let frequencyOptions = ["당일", "1일 전", "3일 전", "7일 전"]

    var body: some View {
        NavigationView {
            VStack {
                // 이름 입력 필드
                TextField("이름", text: $name)
                    .textFieldStyle(.roundedBorder)
                    .padding()

                // 생일 날짜 선택
                DatePicker("생일 날짜 선택", selection: $dateOfBday, displayedComponents: .date)
                    .datePickerStyle(WheelDatePickerStyle())
                    .padding()

                // 알림 주기 선택 리스트
                List(frequencyOptions, id: \.self) { option in
                    HStack {
                        Text(option)
                        Spacer()
                        // 선택된 경우 체크마크 표시
                        if notiFrequency.contains(option) {
                            Image(systemName: "checkmark")
                                .foregroundColor(.blue)
                        }
                    }
                    .contentShape(Rectangle()) // 클릭 영역 확장
                    .onTapGesture {
                        // 선택/해제 토글
                        if notiFrequency.contains(option) {
                            notiFrequency.removeAll(where: { $0 == option })
                        } else {
                            notiFrequency.append(option)
                        }
                    }
                }
                .frame(height: 200) // 리스트 높이 조정

                // 생일 추가 버튼
                Button("생일 추가") {
                    let newBday = Bday(id: UUID(), name: name, profileImage: profileImage, dateOfBday: dateOfBday, isLunar: isLunar, notiFrequency: notiFrequency, relationshipTag: relationshipTag)
                    context.insert(newBday)

                    // 알림 스케줄링 호출 (생일 알림)
                    NotificationManager.instance.scheduleNotification(for: name, dateOfBday: dateOfBday, notiFrequency: notiFrequency)
                }
                .padding()
            }
            .navigationTitle("생일 등록")
        }
    }
}

#Preview {
    CreateBdayView()
}

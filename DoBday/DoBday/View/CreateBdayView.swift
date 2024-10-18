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
    //@Query: View에서 모델을 쓰고 싶을 때 씀
    @Query var bdays: [Bday]

    @State private var name = ""
    @State private var profileImage = ""
    @State private var dateOfBday: Date = Date()
    @State private var isLunar = true
    @State private var notiFrequency = ""

    var body: some View {
        NavigationView {
            VStack {
                //추가 버튼
                Button {
                    let newBday = Bday(id: UUID(), name: name, profileImage: profileImage, dateOfBday: dateOfBday, isLunar: isLunar, notiFrequency: notiFrequency)
                    context.insert(newBday)
                } label: {
                    Text("추가")
                }

                TextField("이름", text: $name)
                                    .textFieldStyle(.roundedBorder)
                                    .padding()

                TextField("이미지", text: $profileImage)
                                    .textFieldStyle(.roundedBorder)
                                    .padding()

                Button {
                    isLunar.toggle()
                } label: {
                    Rectangle()
                        .frame(width: 80, height: 40)
                        .foregroundColor(isLunar ? .red: .blue)
                }

                DatePicker("Please enter a date", selection: $dateOfBday,
                                   displayedComponents: .date)
                            .datePickerStyle(WheelDatePickerStyle())
                            .labelsHidden()

                TextField("알람 기간", text: $notiFrequency)
                                    .textFieldStyle(.roundedBorder)
                                    .padding()
            }
        }
    }
}

#Preview {
    CreateBdayView()
}

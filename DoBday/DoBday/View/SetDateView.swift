//
//  SetDateView.swift
//  DoBday
//
//  Created by Hajin on 11/3/24.
//

import SwiftUI

struct SetDateView: View {

    @Binding var dateOfBday: Date
    @Binding var isshowingSheetForSettingDate: Bool
    @Binding var isLunar: Bool

    var body: some View {
        VStack {

            HStack(alignment: .bottom) {
                Text("생일 날짜")
                    .font(.system(size: 30, weight: .bold))

                Spacer()
            }.padding(.init(top: 5, leading: 0, bottom: 1, trailing: 0))

            if isLunar {

                if let lunarDate = KoreanLunarSolarConverter.instance.solarToLunar(date: dateOfBday), let _ =
                    KoreanLunarSolarConverter.instance.convertLunarToSolarForCurrentYear(lunarDate: lunarDate)

                {
                    HStack {
                        Text("양력과 음력은 약 30일 정도 차이가 나요")
                            .font(.system(size: 10, weight: .semibold))
                            .foregroundColor(.gray)
                        Spacer()
                    }.padding(0)

                    HStack {
                        Text("음력: \(lunarDate, formatter: SaveBdayView.dateFormat)")
                            .foregroundColor(.gray)
                        Spacer()
                    }
                    .padding(0)
                }
            }

            Spacer()

            DatePicker("Please enter a date", selection: $dateOfBday, displayedComponents: .date)
                .datePickerStyle(WheelDatePickerStyle())
                .labelsHidden()
                .environment(\.locale, Locale.init(identifier: "ko"))
                .padding(0)

            Spacer()

            Button {
                isshowingSheetForSettingDate.toggle()
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.black)
                        .frame(width: 340, height: 60)
                    Text("완료")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                }
            }
        }
        .padding(.init(top: 40, leading: 20, bottom: 0, trailing: 20))
    }
}

//#Preview {
//    SetDateView(dateOfBday: $dateOfBday, isshowingSheet: $isshowingSheet, isLunar: $isLunar)
//}

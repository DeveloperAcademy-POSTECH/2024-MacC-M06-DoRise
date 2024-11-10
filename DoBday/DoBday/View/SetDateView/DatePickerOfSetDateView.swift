//
//  DatePickerOfSetDateView.swift
//  DoBday
//
//  Created by Hajin on 11/7/24.
//
import SwiftUI

struct DatePickerOfSetDateView: View {

    @Binding var dateOfBday: Date

    var body: some View {
        VStack {
            DatePicker("Please enter a date", selection: $dateOfBday, displayedComponents: .date)
                .datePickerStyle(WheelDatePickerStyle())
                .labelsHidden()
                .environment(\.locale, Locale.init(identifier: "ko"))
                .padding(0)
        }
    }
}

//
//  HeaderForUpComingBdayView.swift
//  DoBday
//
//  Created by Hajin on 11/10/24.
//
import SwiftUI

struct HeaderForUpComingBdayView: View {
    
    var bdays: [Bday]
    
    /// 요일 EEEE(영어)로 표기.
    var titleDayOfWeek: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let dayOfWeek = dateFormatter.string(from: Date())
        return dayOfWeek.uppercased()
    }
    
    /// 날짜 yyyy.MM.dd 표기.
    var titleDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        return dateFormatter.string(from: Date())
    }
    
    @State var now = Date.now
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(titleDayOfWeek)
                    .font(.bdayEmphasized)
                    .foregroundColor(.titleDayOfWeekColor)
                
                Text(titleDate)
                    .font(.bdayEmphasized)
            }
            .lineSpacing(25)
            
            Spacer()
            
            NavigationLink(destination: CalendarView(bdays: bdays, month: now)) {
                Image(systemName: "calendar")
                    .foregroundColor(.black)
                    .font(.system(size: 24))
                    .fontWeight(.semibold)
                    .padding(.top, 40)
            }
        }
    }
}

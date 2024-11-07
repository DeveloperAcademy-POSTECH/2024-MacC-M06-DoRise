//
//  HeaderView.swift
//  DoBday
//
//  Created by 이소현 on 11/7/24.
//
import SwiftUI

// MARK: - HeaderView
struct HeaderView: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    @Binding var month: Date
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Text("Today")
                .font(.bday_t2Emphasized)
                .foregroundStyle(.gray)
            
            HStack {
                Text(Self.dateString ?? "")
                    .foregroundStyle(Color.init(hex: "BF794E"))
                Text(Self.dayString ?? "")
                    .foregroundStyle(.primary)
            }
            .font(.bday_t1Emphasized)
            
            
            HStack {
                Text("\(month, formatter: Self.monthFormatter)")
                    .font(.custom("Pretendard-Regular", size: 20))
                
                Spacer()
                Button {
                    changeMonth(by: -1)
                } label: {
                    Image(systemName: "chevron.left")
                }
                
                Rectangle()
                    .frame(width: 20, height: 1)
                    .foregroundStyle(.clear)
                
                Button {
                    changeMonth(by: 1)
                } label: {
                    Image(systemName: "chevron.right")
                }
                
            }
            .padding(.bottom)
            .foregroundStyle(colorScheme == .dark ? .white : .black)
            
            
            
            HStack {
                ForEach(Self.weekdaySymbols, id: \.self) { symbol in
                    Text(symbol)
                        .frame(maxWidth: .infinity)
                }
            }
            .padding(.bottom, 5)
        }
        
    }
    
}


// MARK: - extension HeaderView

extension HeaderView {
    
    static var dateString: String? {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM. dd"
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    
    static var dayString: String? {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    
    static var monthFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter
    }()
    
    
    static let weekdaySymbols = Calendar.current.shortWeekdaySymbols
    
    /// 월을 변경합니다.
    func changeMonth(by value: Int) {
        let calendar = Calendar.current
        if let newMonth = calendar.date(byAdding: .month, value: value, to: month) {
            self.month = newMonth
        }
    }
    
}

//
//  CalendarGridView.swift
//  DoBday
//
//  Created by 이소현 on 11/7/24.
//
import SwiftUI

// MARK: - CalendarGridView
struct CalendarGridView: View {
    
    @Binding var month: Date
    @Binding var selectedDate: Date?
    @Binding var clickedDate: Date?
    @Binding var clickedBdays: [Bday]
    
    var bdays: [Bday]
    
    
    var daysInMonth: Int {
        numberOfDays(in: month)
    }
    
    var firstWeekday: Int {
        firstWeekdayOfMonth(in: month) - 1
    }
    
    var body: some View {
        VStack {
            LazyVGrid(columns: Array(repeating: GridItem(), count: 7)) {
                ForEach(0 ..< (daysInMonth + firstWeekday), id: \.self) { index in
                    if index < firstWeekday {
                        RoundedRectangle(cornerRadius: 5)
                            .foregroundColor(Color.clear)
                    } else {
                        let date = getDate(for: index - firstWeekday)
                        let day = index - firstWeekday + 1
                        let clicked = (clickedDate == date)
                        let bdaysOnData = bdays.filter { $0.dateOfBday?.startOfDay() == date.startOfDay() }
                        
                        CellView(
                            day: day,
                            isClicked: clicked,
                            cellDate: date,
                            bday: bdaysOnData)
                        .onTapGesture {
                            clickedDate = date
                            selectedDate = date
                            clickedBdays = bdaysOnData
                        }
                    }
                }
            }
        }
    }
}



// MARK: - CellView

private struct CellView: View {
    var day: Int
    var isClicked: Bool = false
    var cellDate: Date
    var bday: [Bday]
    
    var body: some View {
        ZStack {

            if !bday.isEmpty {
                Circle()
                    .fill(Color.init(hex: "FF8080"))
                    .frame(width: 10, height: 10)
                    .offset(x: 0, y: 22)
                
            }
            
            if cellDate.isSameDate(date: Date()) {
                Circle()
                    .frame(width: 30, height: 30)
                    .foregroundStyle(.primary)
                    .opacity(0.2)
            }
            
            if isClicked {
                Circle()
                    .stroke(Color.primary, lineWidth: 4)
                    .frame(width: 30, height: 30)
                    .opacity(0.2)
            }
            
            RoundedRectangle(cornerRadius: 5)
                .opacity(0)
                .overlay(Text(String(day)))
                .foregroundStyle(.primary)
        }
        .scaledToFit()
    }
}

// MARK: - CalendarGridView Method
extension CalendarGridView {
    /// 특정 해당 일자를 반환합니다.
    func getDate(for day: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: day, to: startOfMonth())!
    }
    
    /// bdays에서 otherDate와 동일한 날인 데이터를 찾아서 반환합니다. 없는 경우 nil을 반환합니다.
    func bdayByDate(otherDate: Date) -> Bday? {
        return bdays.first { bday in
            startOfDay(date: bday.dateOfBday ?? Date()) == startOfDay(date: otherDate)
        }
    }
    
    /// Date를 해당 날짜의 자정으로 바꿔줍니다.(시, 분을 초기화 합니다.)
    func startOfDay(date: Date) -> Date {
        Calendar.current.startOfDay(for: date)
    }
    
    /// 항상 해당 월의 1일로 시작할 수 있도록 해당 월의 시작 날짜(1일)를 반환합니다. 해당 월의 1일을 기준으로 일정을 계산하거나 날짜 관련 작업을 할 수 있습니다.
    func startOfMonth() -> Date {
        let components = Calendar.current.dateComponents([.year, .month], from: month)
        return Calendar.current.date(from: components)!
    }
    
    
    /// 해당 월의 일자 수를 계산합니다.
    func numberOfDays(in date: Date) -> Int {
        return Calendar.current.range(of: .day, in: .month, for: date)?.count ?? 0
    }
    
    /// 해당 월의 1일이 일주일 중 몇 번째 날에 해당하는지를 반환합니다.
    /// 예) date = 2024 10 15 -> 2024 10 01이 3번째 요일(화요일)임을 반환
    func firstWeekdayOfMonth(in date: Date) -> Int {
        let components = Calendar.current.dateComponents([.year, .month], from: date)
        
        let firstDayOfMonth = Calendar.current.date(from: components)!  // Question. 왜 강제 해제..?
        
        return Calendar.current.component(.weekday, from: firstDayOfMonth)
    }
    
}

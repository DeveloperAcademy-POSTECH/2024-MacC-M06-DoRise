//
//  CalendarView.swift
//  DoBday
//
//  Created by Hajin on 10/17/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Query var bdays: [Bday]
    
    var body: some View {
        CalendarView(month: Date(), bdays: bdays)
            .padding()
    }
}


struct CalendarView: View {
    // Property
    // month: 현재 달력의 월 정보
    // offset: 드래그 제스쳐로 월을 변경
    // clickedDates: 특정 일자 클릭시 뷰 추가
    @State var month: Date
    @State var offset: CGSize = CGSize()
    @State var clickedDates: Set<Date> = []
    var bdays: [Bday]
    
    
    @Environment(\.modelContext) var context

    
    let relationshipDictionary: [String : Color] = ["#가족": .red, "#친구": .blue, "#지인": .yellow, "#비지니스": .green]
    
    
    var body: some View {
        VStack {
            headerView
            calendarGridView
        }
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    self.offset = gesture.translation
                }
                .onEnded { gesture in
                    if gesture.translation.width < 100 {
                        changeMonth(by: 1)
                    } else if gesture.translation.width > 100 {
                        changeMonth(by: -1)
                    }
                    self.offset = CGSize()
                }
        )
    }
    
    // MARK: - headerView
    private var headerView: some View {
        VStack {
            Text(month, formatter: Self.dateFormatter)
                .font(.title)
                .padding(.bottom)
            
            HStack {
                ForEach(Self.weekdaySymbols, id: \.self) { symbol in
                    Text(symbol)
                        .frame(maxWidth: .infinity)
                }
            }
            .padding(.bottom, 5)
        }
    }
    
    // MARK: - calendarGridView
    private var calendarGridView: some View {
        let daysInMonth: Int = numberOfDays(in: month)
        let firstWeekday: Int = firstWeekdayOfMonth(in: month) - 1
        
        return VStack {
            LazyVGrid(columns: Array(repeating: GridItem(), count: 7)) {
                ForEach(0 ..< (daysInMonth + firstWeekday), id: \.self) { index in
                    if index < firstWeekday {
                        RoundedRectangle(cornerRadius: 5)
                            .foregroundColor(Color.clear)
                    } else {
                        let date = getDate(for: index - firstWeekday)
                        let day = index - firstWeekday + 1
                        let clicked = clickedDates.contains(date)
                        let bday = bdays.first(where: { $0.dateOfBday == date })
                        
                        CellView(day: day, clicked: clicked, cellDate: date, bday: bday)
                            .onTapGesture {
                                if clicked {
                                    clickedDates.remove(date)
                                } else {
                                    clickedDates.insert(date)
                                }
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
    var clicked: Bool = false
    var cellDate: Date
    var bday: Bday?
    
    init(day: Int, clicked: Bool, cellDate: Date, bday: Bday?) {
        self.day = day
        self.clicked = clicked
        self.cellDate = cellDate
        self.bday = bday
    }
    
    var body: some View {
        ZStack {
            if let bday {
                Circle()
                    .fill(Color.red)
            }
            
            // cellDate와 Date()가 같은 날이면 Circle 표시
            if cellDate.isSameDate(date: Date()) {
                Circle()
            }
            
            RoundedRectangle(cornerRadius: 5)
                .opacity(0)
                .overlay(Text(String(day)))
                .foregroundStyle(.blue)
        }
        .scaledToFit()
    }
}



// MARK: - CustomCalendarView Method
private extension CalendarView {
    /// 특정 해당 일자를 반환합니다.
    private func getDate(for day: Int) -> Date {
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
    
    /// 월을 변경합니다.
    func changeMonth(by value: Int) {
        let calendar = Calendar.current
        if let newMonth = calendar.date(byAdding: .month, value: value, to: month) {
            self.month = newMonth
        }
    }
}




// MARK: - Static Property
extension CalendarView {
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter
    }()
    
    
    static let weekdaySymbols = Calendar.current.shortWeekdaySymbols
}


// MARK: - extension Date
extension Date {
    private func startOfDay() -> Date {
        Calendar.current.startOfDay(for: self)
    }
    
    func isSameDate(date: Date) -> Bool {
        self.startOfDay() == date.startOfDay()
    }
}


//#Preview {
//    CalendarView()
//}

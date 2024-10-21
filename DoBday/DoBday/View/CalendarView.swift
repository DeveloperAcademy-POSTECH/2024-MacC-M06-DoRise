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
//    var bdays: [Bday]
    
    var body: some View {
        CalendarView(month: Date(), bdays: bdays)
            .padding()
    }
}

// MARK: - CalendarView
struct CalendarView: View {
    // Property
    @State var month: Date
    @State var offset: CGSize = CGSize()
    @State var clickedDates: Set<Date> = []
    @State var selectedDate: Date? = nil
    @State private var clickedDate: Date? = nil
    @State private var clickedBdays: [Bday] = []
    @State private var showingAlert = false
    
    var bdays: [Bday]
    
    @Environment(\.modelContext) var context
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    
    
    var body: some View {
        NavigationView {
            VStack {
                headerView
                calendarGridView
                    .padding(.bottom)
                
                if !clickedBdays.isEmpty {
                    ScrollView {
                        VStack {
                            ForEach(clickedBdays, id: \.id) { bday in
                                CardView(bday: bday)
                                    .padding(.bottom, 5)
                            }
                        }
                    }

                }
                
                Spacer()
            }
            .padding()
        }
    }
    
    
    // MARK: - headerView
    private var headerView: some View {
        VStack {
            HStack {
                NavigationLink {
                    UpComingBdayView()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.custom("Pretendard-Bold", size: 20))
                        .foregroundStyle(colorScheme == .dark ? .white : .black)
                    
                }
                
                Text("\(selectedDate ?? Date(), formatter: Self.dateFormatter)")
                    .font(.custom("Pretendard-Bold", size: 24))
                
                
                
                Spacer()
                
                NavigationLink {
                    CreateBdayView()
                } label: {
                    Image(systemName: "plus")
                        .foregroundStyle(colorScheme == .dark ? .white : .black)
                        .font(.custom("Pretendard-Bold", size: 20))
                    
                    
                }
                
            }
            .padding(.bottom, 30)
            
            HStack {
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
                        let bdaysOnData = bdays.filter { $0.dateOfBday?.startOfDay() == date.startOfDay() }
                        
                        CellView(day: day, clicked: clicked, cellDate: date, bday: bdaysOnData)
                            .onTapGesture {
                                if clicked {
                                    clickedDates.remove(date)
                                    clickedBdays = []
                                } else {
                                    clickedDates.insert(date)
                                    selectedDate = date
                                    clickedDate = date
                                    clickedBdays = bdaysOnData
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
    var bday: [Bday]
        
    var body: some View {
        ZStack {
            
            // 데이터 상 생일과 일자가 동일할 때 Circle이 나타남
            if !bday.isEmpty {
                Circle()
                    .fill(Color.init(hex: "FF8080"))
                    .frame(width: 10, height: 10)
                    .offset(x: 0, y: 20)
                
            }
            
            if cellDate.isSameDate(date: Date()) {
                Circle()
                    .foregroundStyle(.primary)
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


// MARK: - CardView
private struct CardView: View {
    var bday: Bday
    let relationshipDictionary: [String : Color] = ["#가족": Color.init(hex: "FFA1A1"), "#친구": Color.init(hex: "FFEBA1"), "#지인": Color.init(hex: "C9F69C"), "#비지니스": Color.init(hex: "A1ACFF")]
    
    
    @State private var showingAlert = false
    
    var body: some View {
            RoundedRectangle(cornerRadius: 16)
                .foregroundStyle(
                    relationshipDictionary[bday.relationshipTag] ?? .gray.opacity(0.5)
                )
                .frame(maxWidth: .infinity)
                .frame(height: 120)
                .overlay {
                    HStack {
                        NavigationLink {
                            EditBdayView()
                        } label: {
                            
                            Image(bday.profileImage!)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .background(.white)
                                .clipShape(Circle())
                            
                        }
                        Spacer()
                        
                        VStack(alignment: .leading) {
                            Text(bday.name)
                                .font(.custom("Pretendard-SemiBold", size: 24))
                                .foregroundStyle(.black)
                            Spacer(minLength: 16)
                            HStack {
                                Text(bday.relationshipTag)
                                Spacer()
                                Text("D-\(daysUntilBday(from: bday.dateOfBday!))")
                            }
                            .font(.custom("Pretendard-Regular", size: 16))
                            .foregroundStyle(.black)
                        }
                        .padding()
                        
                    }
                    .padding()
                }
                .contextMenu {
                    Button {
                        showingAlert = true
                    } label: {
                        Label("Delete", systemImage: "trash.fill")
                    }
                    
                }
                .alert("생일 기록을 삭제하시겠습니까?", isPresented: $showingAlert) {
                    Button("취소", role: .cancel) {
                        showingAlert = false
                    }
                    Button("삭제", role: .destructive) {
                        // 실제 삭제 기능은 여기에 구현
                        print("Record deleted")
                        showingAlert = false
                    }
                } message: {
                    Text("\(bday.name)의 생일 기록을 삭제하시겠습니까?")
                }
            
    }
    
    // MARK: - CardView method
    /// 오늘 날짜로부터 생일이 며칠 남았는지 계산하여 반환합니다.
    func daysUntilBday(from date: Date) -> Int {
        let calendar = Calendar.current
        let today = Date()
        
        let components = calendar.dateComponents([.month, .day], from: date)
        
        // 내년 생일 계산
        var nextBday = calendar.nextDate(after: today, matching: components, matchingPolicy: .nextTime)
        
        if nextBday == nil || nextBday! < today {
            var nextYearComponents = components
            nextYearComponents.year = calendar.component(.year, from: today) + 1
            nextBday = calendar.date(from: nextYearComponents)
        }
        
        return calendar.dateComponents([.day], from: today, to: nextBday!).day!
    }
}




// MARK: - CalendarView Method
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
        formatter.dateFormat = "MMMM dd, yyyy"
        return formatter
    }()
    
    
    static let weekdaySymbols = Calendar.current.shortWeekdaySymbols
}


// MARK: - extension Date
extension Date {
    func startOfDay() -> Date {
        Calendar.current.startOfDay(for: self)
    }
    
    func isSameDate(date: Date) -> Bool {
        self.startOfDay() == date.startOfDay()
    }
}


//#Preview {
//    ContentView(bdays: mockBdayData)
//}

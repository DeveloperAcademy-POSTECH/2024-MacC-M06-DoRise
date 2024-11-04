//
//  CalendarView.swift
//  DoBday
//
//  Created by Hajin on 10/17/24.
//

import SwiftUI
import SwiftData


// MARK: - CalendarView

struct CalendarView: View {
    
    // Property
    @Environment(\.modelContext) var context
    
    var bdays: [Bday]
    
    @State var offset: CGSize = CGSize()
    @State var clickedDate: Date? = nil
    @State private var clickedBdays: [Bday] = []
    @State private var showingAlert = false

//    @Environment(\.modelContext) var context
    @Environment(\.colorScheme) var colorScheme: ColorScheme

    @State var selectedDate: Date? = nil
    @State var month: Date

    var body: some View {
        
        VStack {

            
            HeaderView(month: $month)
            CalendarGridView(
                month: $month,
                selectedDate: $selectedDate,
                clickedDate: $clickedDate,
                clickedBdays: $clickedBdays,
                bdays: bdays)
            .padding(.bottom)
            
            if let date = clickedDate {
                HStack {
                    Text("\(formattedDate(date)) 생일인 사람")
                        .font(.custom("Pretendard-Bold", size: 24))
                        .padding(.leading)
                    
                    Spacer()
                }
                
                if !clickedBdays.isEmpty {
                    CardListView(bdays: clickedBdays, clickedBdays: $clickedBdays)
                } else {
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .foregroundStyle(.gray.opacity(0.2))
                            
                        VStack {
                            Text("오늘은 생일인 사람이 없어요!")
                                .font(.custom("Pretendard-Medium", size: 20))
                                .padding(.bottom, 8)
                            Text("하지만 매일을 생일처럼 보내보아요🎉")
                                .font(.custom("Pretendard-Medium", size: 12))
                        }
                        .padding()
                        
                    }
                }
            }
            
            
            
            Spacer()
            
        }
        .navigationTitle("캘린더")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink {
                    SaveBdayView()
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .padding()
    }
    
    /// 날짜를 "M월 d일" 형식으로 포맷팅하는 함수입니다.
    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "M월 d일"
        return formatter.string(from: date)
    }
}


// MARK: - HeaderView
private struct HeaderView: View {
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


// MARK: - CalendarGridView
private struct CalendarGridView: View {
    
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


// MARK: - CardListView
private struct CardListView: View {
    @Environment(\.modelContext) var context
    
    @State private var showingAlert = false
    @State var selectedBday: Bday?
    
    var bdays: [Bday]
    @Binding var clickedBdays: [Bday]
    
    // TODO: 새로운 tag 모델로 갈아끼우면 삭제할 것
    let relationshipDictionary: [String : Color] = ["#가족": Color.init(hex: "FFA1A1"), "#친구": Color.init(hex: "FFEBA1"), "#지인": Color.init(hex: "C9F69C"), "#비지니스": Color.init(hex: "A1ACFF")]
    
    var body: some View {

        VStack(alignment: .leading) {
            List {
                ForEach(clickedBdays, id: \.id) { bday in
                    NavigationLink {
                        // TODO: PersonalDetailView 로 갈아 끼우기
                        EmptyView()
                    } label: {
                        HStack {
                            Image(bday.profileImage == nil || bday.profileImage == "" ? "basicprofile" : bday.profileImage!)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80, height: 80)
                                .clipShape(Circle())
                                .padding(.trailing, 10)
                            
                                VStack(alignment: .leading) {
                                Text(bday.name)
                                    .padding(.horizontal, 8)
//                                Text(bday.relationshipTag)
//                                    .padding(.horizontal, 8)
//                                    .padding(.vertical, 4)
//                                    .background(
//                                        // TODO: 새로운 relationshipTag 모델로 갈아끼워야 함
//                                        relationshipDictionary[bday.relationshipTag]?.opacity(0.5) ?? .gray.opacity(0.2)
//                                    )
//                                    .clipShape(.capsule)
                            }
                            .foregroundStyle(.primary)
                        }
                    }
                }
                .onDelete(perform: showAlertBeforeDelete)
                .listRowSeparator(.hidden)
                .listRowBackground(
                    RoundedRectangle(cornerRadius: 12)
                        .background(.clear)
                        .foregroundStyle(.gray.opacity(0.2))
                        .padding(
                            EdgeInsets(
                                top: 2,
                                leading: 10,
                                bottom: 2,
                                trailing: 10
                            )
                        )
                )
            }
            .listRowInsets(.none)
            .listStyle(.plain)
            .alert("생일 기록을 삭제하시겠습니까?", isPresented: $showingAlert) {
                Button("취소", role: .cancel) {
                    showingAlert = false
                }
                Button("삭제", role: .destructive) {
                    
                    if let bdayToRemove = selectedBday {
                        context.delete(bdayToRemove)
                        clickedBdays.removeAll { $0.id == bdayToRemove.id }
                    }
                }
            }
        }
    }
    
    /// 삭제 경고창을 띄우기 전 호출되는 함수입니다.
    func showAlertBeforeDelete(at offsets: IndexSet) {
        if let index = offsets.first {
            selectedBday = clickedBdays[index]
            showingAlert = true
        }
    }
}


// MARK: - CardView

private struct CardView: View {
    @Environment(\.modelContext) var context
    var bday: Bday
    let relationshipDictionary: [String : Color] = ["#가족": Color.init(hex: "FFA1A1"), "#친구": Color.init(hex: "FFEBA1"), "#지인": Color.init(hex: "C9F69C"), "#비지니스": Color.init(hex: "A1ACFF")]
    
    
    @State private var showingAlert = false
    
    var body: some View {
        RoundedRectangle(cornerRadius: 16)
//            .foregroundStyle(
//                relationshipDictionary[bday.relationshipTag] ?? .gray.opacity(0.5)
//            )
            .frame(maxWidth: .infinity)
            .frame(height: 120)
            .overlay {
                HStack {
                    NavigationLink {
                        SaveBdayView(bday: bday)
                    } label: {
                        Image("basicprofile")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .leading) {
                        Text(bday.name)
                            .font(.custom("Pretendard-SemiBold", size: 24))
                            .foregroundStyle(.black)
                        Spacer(minLength: 16)
                        HStack {
//                            Text(bday.relationshipTag)
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
                    
                    context.delete(bday)
                    
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

extension CalendarGridView {
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


// MARK: - extension Date

extension Date {
    /// 주어진 date의 가장 첫번째 순간을 반환하는 함수입니다.
    /// 예를 들어 11월의 startOfDay는 1일입니다.
    func startOfDay() -> Date {
        Calendar.current.startOfDay(for: self)
    }
    
    func isSameDate(date: Date) -> Bool {
        self.startOfDay() == date.startOfDay()
    }
    
}


//#Preview {
//    NavigationStack{
//        CalendarView()
//    }
//}

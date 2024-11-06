////////
////////  ContentView.swift
////////  DoBday
////////
////////  Created by Hajin on 10/17/24.
////////
//////
import SwiftUI
import SwiftData

struct UpComingBdayView: View {
    @Environment(\.modelContext) var context
    @Query var bdays: [Bday]

    @State var now = Date.now
    
    /// 현재 날짜로부터 30일 이내에 해당하는 생일 목록을 반환.
    var upcomingBdays: [Bday] {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let thirtyDaysLater = calendar.date(byAdding: .day, value: 30, to: today)!
        
        return bdays.filter { bday in
            guard let bdayDate = bday.dateOfBday else { return false }
            
            /// 해당 생일의 월, 일을 가져와서 현재 연도의 날짜로 변환.
            let components = calendar.dateComponents([.month, .day], from: bdayDate)
            let thisYearBday = calendar.date(from: DateComponents(year: calendar.component(.year, from: today), month: components.month, day: components.day)) ?? today
            
            /// 오늘과 같은 날짜이거나 30일 이내에 포함되는지 확인.
            if calendar.isDate(thisYearBday, inSameDayAs: today) {
                return true
            }
            
            return thisYearBday > today && thisYearBday <= thirtyDaysLater
        }.sorted {
            let date1 = calendar.date(from: calendar.dateComponents([.month, .day], from: $0.dateOfBday ?? Date())) ?? Date()
            let date2 = calendar.date(from: calendar.dateComponents([.month, .day], from: $1.dateOfBday ?? Date())) ?? Date()
            return date1 < date2
        }
    }
    /// 가장 가까운 생일 리스트를 반환.
    /// 가장 가까운 날짜의 생일을 찾아 해당 날짜와 같은 생일들을 필터링.
    var closestBdays: [Bday] {
        guard let firstBday = upcomingBdays.first else { return [] }
        let calendar = Calendar.current
        let firstDate = calendar.date(from: calendar.dateComponents([.month, .day], from: firstBday.dateOfBday ?? Date())) ?? Date()
        
        return upcomingBdays.filter {
            let date = calendar.date(from: calendar.dateComponents([.month, .day], from: $0.dateOfBday ?? Date())) ?? Date()
            return calendar.isDate(date, inSameDayAs: firstDate)
        }
    }
    
    /// 가장 가까운 생일을 제외한 나머지 30일 이내의 생일 목록을 반환.
    var filteredUpcomingBdays: [Bday] {
        return upcomingBdays.filter { !closestBdays.contains($0) }
    }
    
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
    
    var body: some View {
        TabView {
            NavigationView {
                VStack {
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
                    
                    Spacer(minLength: 25)
                    
                    HStack {
                        Text("가장 가까운 생일")
                            .font(.bday_t2Emphasized)
                        Spacer()
                    }
                    
                    if closestBdays.count > 1 {
                        TabView {
                            ForEach(closestBdays, id: \.id) { bday in
//                                NavigationLink(destination: CalendarView
                                NavigationLink(destination: PersonDetailView(bday: bday)){
                                    UpComingBdayCardView(bday: bday)
                                        .padding(.bottom, 25)
                                }
                            }
                        }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                        .frame(height: 247)
                        .background(Color.upComingBdayCardBackgroundColor)
                        .cornerRadius(20)
                        
                    } else if let closestBday = closestBdays.first {
                        NavigationLink(destination: PersonDetailView(bday: closestBday)){
                            
                            
                            UpComingBdayCardView(bday: closestBday)
                                .padding(.top, 10)
                                .frame(height: 247)
                                .background(Color.upComingBdayCardBackgroundColor)
                                .cornerRadius(20)
                        }
                        
                    } else {
                        Text("생일을 추가해 보세요!")
                            .foregroundColor(.gray)
                            .padding(.top, 10)
                    }
                    
                    Spacer(minLength: 15)
                    HStack {
                        Text("곧 생일이에요!")
                            .font(.bday_t2Emphasized)
                        Spacer()
                    }.padding(.leading,10)
                    
                    HStack {
                        Text("30일 이내 생일인 사람들이 표시돼요.")
                            .font(.bday_callRegular)
                            .foregroundColor(.gray)
                        Spacer()
                    }.padding(.leading,10)
                    
                    ScrollView {
                        VStack {
                            ForEach(filteredUpcomingBdays) { bday in
                                NavigationLink(destination: PersonDetailView(bday: bday)){
                                    BdayTextView(bday: bday)
                                }
                            }
                        }
                    }
                }
                .padding()
            }
            .tabItem {
                Image(systemName: "house.fill")
                Text("Home")
            } // : Home 탭
            
            PersonListView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Person")
                } // : Person 탭
            
        }
        .accentColor(.blue)
    }
}

//#Preview {
//    do {
//        let config = ModelConfiguration(isStoredInMemoryOnly: true)
//        let container = try ModelContainer(for: Bday.self, configurations: config)
//
//        let today = Date()
//        let mockBdays = [
//            Bday(id: UUID(), name: "소이", profileImage: "soy", dateOfBday: today, isLunar: false, notiFrequency: ["당일", "1일 전"], relationshipTag: ["#비지니스"]),
//            Bday(id: UUID(), name: "씨네필", profileImage: "", dateOfBday: Calendar.current.date(byAdding: .day, value: 2, to: today)!, isLunar: false, notiFrequency: ["3일 전"], relationshipTag: ["#지인"]),
//            Bday(id: UUID(), name: "피카", profileImage: "pika", dateOfBday: Calendar.current.date(byAdding: .day, value: 15, to: today)!, isLunar: true, notiFrequency: ["1일 전", "7일 전"], relationshipTag: ["#친구"]),
//            Bday(id: UUID(), name: "레디", profileImage: "ready", dateOfBday: Calendar.current.date(byAdding: .day, value: 25, to: today)!, isLunar: false, notiFrequency: ["당일"], relationshipTag: ["#가족"])
//        ]
//
//        for bday in mockBdays {
//            container.mainContext.insert(bday)
//        }
//
//        return UpComingBdayView()
//            .modelContainer(container)
//    } catch {
//        return Text("Failed to create preview: \(error.localizedDescription)")
//    }
//}

//////
//////  ContentView.swift
//////  DoBday
//////
//////  Created by Hajin on 10/17/24.
//////
////
////import SwiftUI
////import SwiftData
////
////struct UpComingBdayView: View {
////    @Environment(\.modelContext) var context
////    @Query var bdays: [Bday]
////    
////    var upcomingBdays: [Bday] {
////        let calendar = Calendar.current
////        let today = calendar.startOfDay(for: Date())
////        let thirtyDaysLater = calendar.date(byAdding: .day, value: 30, to: today)!
////        
////        return bdays.filter { bday in
////            guard let bdayDate = bday.dateOfBday else { return false }
////            
////            let components = calendar.dateComponents([.month, .day], from: bdayDate)
////            let thisYearBday = calendar.date(from: DateComponents(year: calendar.component(.year, from: today), month: components.month, day: components.day)) ?? today
////            
////            // 생일이 오늘이거나 오늘부터 30일 이내인 경우를 포함
////            
////            // 오늘 생일인 것을 포함하는 로직
////            if calendar.isDate(thisYearBday, inSameDayAs: today) {
////                return true
////            }
////            
////            // 오늘부터 30일 후까지의 범위에 포함되는지 확인
////            return thisYearBday > today && thisYearBday <= thirtyDaysLater
////        }.sorted {
////            let date1 = calendar.date(from: calendar.dateComponents([.month, .day], from: $0.dateOfBday ?? Date())) ?? Date()
////            let date2 = calendar.date(from: calendar.dateComponents([.month, .day], from: $1.dateOfBday ?? Date())) ?? Date()
////            return date1 < date2
////        }
////    }
////    
////    var titleDayOfWeek: String {
////        let dateFormatter = DateFormatter()
////        dateFormatter.dateFormat = "EEEE" // 요일을 풀 네임으로.
////        let dayOfWeek = dateFormatter.string(from: Date())
////        return dayOfWeek.uppercased() // 대문자로 변환.
////    }
////    
////    var titleDate: String {
////        let dateFormatter = DateFormatter()
////        dateFormatter.dateFormat = "yyyy.MM.dd"
////        return dateFormatter.string(from: Date())
////    }
////    
////    var body: some View {
////        NavigationView {
////            VStack {
////                HStack {
////                    VStack(alignment: .leading){
////                        // 날짜와 요일 표시.
////                        Text(titleDayOfWeek)
////                            .font(.system(size: 32))
////                            .foregroundColor(.titleDayOfWeekColor)
////                        //색상추가했습니다.
////                        
////                        Text(titleDate)
////                            .font(.system(size: 32))
////                        
////                    }
////                    
////                    Spacer()
////                    NavigationLink(destination: CalendarView(month: Date(), bdays: bdays)) {
////                        Image(systemName: "calendar")
////                            .foregroundColor(.black)
////                            .font(.system(size: 24))
////                            .fontWeight(.bold)
////                            .padding(.top,40)
////                    }
////                }
////                //: HSTACK
////                
////                Spacer(minLength: 43)
////                
////                HStack {
////                    Text("가장 가까운 생일")
////                        .font(.system(size: 22, weight: .bold))                     //title2 폰트추가해서 수정해야해요. 레디!
////                    Spacer()
////                } //: HSTACK
////                
//////                ZStack{
//////                    Rectangle()
//////                        .frame(width: 353, height:247)
//////                        .cornerRadius(20)
//////                        .foregroundColor(.upComingBdayCardBackgroundColor)
//////                    ScrollView(.horizontal, showsIndicators: true){
//////                        HStack(spacing: 40){
//////                            Spacer()
//////                            ZStack{
//////                                RoundedRectangle(cornerRadius: 10)
//////                                    .stroke(Color(hex: "FFFFFF"), lineWidth: 5) // 흰색(FFFFFF) 테두리와 두께 5 적용
//////                                    .frame(width: 120, height: 160) // Image와 같은 크기
//////                                
//////                                
//////                                
//////                                Image("pika")
//////                                    .resizable()
//////                                    .scaledToFill()
//////                                    .frame(width:120,height:160)
//////                                    .clipShape(RoundedRectangle(cornerRadius: 12)) // 테두리 모양에 맞게 이미지 클리핑
//////                                
//////                            }
//////                            Spacer()
//////                            VStack{
//////                                Text("이름")
//////                                Text("날짜")
//////                                Text("태그")
//////                                Text("D-DAY")
//////                                
//////                                
//////                            }
//////                            Spacer()
//////                        }
//////                    }
//////                }
////                
////                
////                
////                Spacer(minLength: 39)
////                HStack {
////                    Text("곧 생일이에요!")                        .font(.system(size: 22, weight: .bold))                     //title2 폰트추가해서 수정해야해요. 레디!
////                    Spacer()
////                }
////                
////                ScrollView{
////                    VStack{
////                        ForEach(upcomingBdays) { bday in BdayTextView(bday: bday)}
////                    }
////                }
////                
////            } //: VSTACK
////            .padding()
////        }.navigationTitle("다가오는 생일 리스트")
////    }
////}
////
//////#Preview {
//////    UpComingBdayView()
//////}
////
////#Preview {
////    do {
////        let config = ModelConfiguration(isStoredInMemoryOnly: true)
////        let container = try ModelContainer(for: Bday.self, configurations: config)
////        
////        // 목업 데이터 생성
////        let today = Date()
////        let mockBdays = [
////            Bday(id: UUID(), name: "소이", profileImage: "soy", dateOfBday: today, isLunar: false, notiFrequency: ["당일", "1일 전"], relationshipTag: "#비지니스"),
////            Bday(id: UUID(), name: "씨네필", profileImage: "", dateOfBday: Calendar.current.date(byAdding: .day, value: 7, to: today)!, isLunar: false, notiFrequency: ["3일 전"], relationshipTag: "#지인"),
////            Bday(id: UUID(), name: "피카", profileImage: "pika", dateOfBday: Calendar.current.date(byAdding: .day, value: 15, to: today)!, isLunar: true, notiFrequency: ["1일 전", "7일 전"], relationshipTag: "#친구"),
////            Bday(id: UUID(), name: "레디", profileImage: "ready", dateOfBday: Calendar.current.date(byAdding: .day, value: 25, to: today)!, isLunar: false, notiFrequency: ["당일"], relationshipTag: "#가족")
////        ]
////        
////        for bday in mockBdays {
////            container.mainContext.insert(bday)
////        }
////        
////        return UpComingBdayView()
////            .modelContainer(container)
////    } catch {
////        return Text("Failed to create preview: \(error.localizedDescription)")
////    }
////}
////
//
//import SwiftUI
//import SwiftData
//
//struct UpComingBdayView: View {
//    @Environment(\.modelContext) var context
//    @Query var bdays: [Bday]
//    
//    var upcomingBdays: [Bday] {
//        let calendar = Calendar.current
//        let today = calendar.startOfDay(for: Date())
//        let thirtyDaysLater = calendar.date(byAdding: .day, value: 30, to: today)!
//        
//        return bdays.filter { bday in
//            guard let bdayDate = bday.dateOfBday else { return false }
//            
//            let components = calendar.dateComponents([.month, .day], from: bdayDate)
//            let thisYearBday = calendar.date(from: DateComponents(year: calendar.component(.year, from: today), month: components.month, day: components.day)) ?? today
//            
//            if calendar.isDate(thisYearBday, inSameDayAs: today) {
//                return true
//            }
//            
//            return thisYearBday > today && thisYearBday <= thirtyDaysLater
//        }.sorted {
//            let date1 = calendar.date(from: calendar.dateComponents([.month, .day], from: $0.dateOfBday ?? Date())) ?? Date()
//            let date2 = calendar.date(from: calendar.dateComponents([.month, .day], from: $1.dateOfBday ?? Date())) ?? Date()
//            return date1 < date2
//        }
//    }
//    
//    var titleDayOfWeek: String {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "EEEE"
//        let dayOfWeek = dateFormatter.string(from: Date())
//        return dayOfWeek.uppercased()
//    }
//    
//    var titleDate: String {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy.MM.dd"
//        return dateFormatter.string(from: Date())
//    }
//    
//    var body: some View {
//        NavigationView {
//            VStack {
//                HStack {
//                    VStack(alignment: .leading) {
//                        Text(titleDayOfWeek)
//                            .font(.system(size: 32))
//                            .foregroundColor(.titleDayOfWeekColor)
//                        
//                        Text(titleDate)
//                            .font(.system(size: 32))
//                    }
//                    
//                    Spacer()
//                    NavigationLink(destination: CalendarView(month: Date(), bdays: bdays)) {
//                        Image(systemName: "calendar")
//                            .foregroundColor(.black)
//                            .font(.system(size: 24))
//                            .fontWeight(.bold)
//                            .padding(.top, 40)
//                    }
//                }
//                
//                Spacer(minLength: 43)
//                
//                HStack {
//                    Text("가장 가까운 생일")
//                        .font(.system(size: 22, weight: .bold))
//                    Spacer()
//                }
//                
//                if let closestBday = upcomingBdays.first {
//                    UpComingBdayCardView(bday: closestBday)
//                        .padding(.top, 10)
//                } else {
//                    Text("다가오는 생일이 없습니다.")
//                        .foregroundColor(.gray)
//                        .padding(.top, 10)
//                }
//                
//                Spacer(minLength: 39)
//                HStack {
//                    Text("곧 생일이에요!")
//                        .font(.system(size: 22, weight: .bold))
//                    Spacer()
//                }
//                
//                ScrollView {
//                    VStack {
//                        ForEach(upcomingBdays) { bday in
//                            BdayTextView(bday: bday)
//                        }
//                    }
//                }
//            }
//            .padding()
//        }
//        .navigationTitle("다가오는 생일 리스트")
//    }
//}
//
//#Preview {
//    do {
//        let config = ModelConfiguration(isStoredInMemoryOnly: true)
//        let container = try ModelContainer(for: Bday.self, configurations: config)
//        
//        // 목업 데이터 생성
//        let today = Date()
//        let mockBdays = [
//            Bday(id: UUID(), name: "소이", profileImage: "soy", dateOfBday: today, isLunar: false, notiFrequency: ["당일", "1일 전"], relationshipTag: "#비지니스"),
//            Bday(id: UUID(), name: "씨네필", profileImage: "", dateOfBday: Calendar.current.date(byAdding: .day, value: 7, to: today)!, isLunar: false, notiFrequency: ["3일 전"], relationshipTag: "#지인"),
//            Bday(id: UUID(), name: "피카", profileImage: "pika", dateOfBday: Calendar.current.date(byAdding: .day, value: 15, to: today)!, isLunar: true, notiFrequency: ["1일 전", "7일 전"], relationshipTag: "#친구"),
//            Bday(id: UUID(), name: "레디", profileImage: "ready", dateOfBday: Calendar.current.date(byAdding: .day, value: 25, to: today)!, isLunar: false, notiFrequency: ["당일"], relationshipTag: "#가족")
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

import SwiftUI
import SwiftData

struct UpComingBdayView: View {
    @Environment(\.modelContext) var context
    @Query var bdays: [Bday]
    
    var upcomingBdays: [Bday] {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let thirtyDaysLater = calendar.date(byAdding: .day, value: 30, to: today)!
        
        return bdays.filter { bday in
            guard let bdayDate = bday.dateOfBday else { return false }
            
            let components = calendar.dateComponents([.month, .day], from: bdayDate)
            let thisYearBday = calendar.date(from: DateComponents(year: calendar.component(.year, from: today), month: components.month, day: components.day)) ?? today
            
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
    
    var titleDayOfWeek: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let dayOfWeek = dateFormatter.string(from: Date())
        return dayOfWeek.uppercased()
    }
    
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
                                .font(.system(size: 32))
                                .foregroundColor(.titleDayOfWeekColor)
                            
                            Text(titleDate)
                                .font(.system(size: 32))
                        }
                        
                        Spacer()
                        NavigationLink(destination: CalendarView(month: Date(), bdays: bdays)) {
                            Image(systemName: "calendar")
                                .foregroundColor(.black)
                                .font(.system(size: 24))
                                .fontWeight(.bold)
                                .padding(.top, 40)
                        }
                    }
                    
                    Spacer(minLength: 43)
                    
                    HStack {
                        Text("가장 가까운 생일")
                            .font(.system(size: 22, weight: .bold))
                        Spacer()
                    }
                    
                    if let closestBday = upcomingBdays.first {
                        UpComingBdayCardView(bday: closestBday)
                            .padding(.top, 10)
                    } else {
                        Text("다가오는 생일이 없습니다.")
                            .foregroundColor(.gray)
                            .padding(.top, 10)
                    }
                    
                    Spacer(minLength: 39)
                    HStack {
                        Text("곧 생일이에요!")
                            .font(.system(size: 22, weight: .bold))
                        Spacer()
                    }
                    
                    ScrollView {
                        VStack {
                            ForEach(upcomingBdays) { bday in
                                BdayTextView(bday: bday)
                            }
                        }
                    }
                }
                .padding()
            }
            .tabItem {
                Image(systemName: "house.fill")
                Text("Home")
            }
            
            PersonView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Person")
                }
            
            GiftView()
                .tabItem {
                    Image(systemName: "gift.fill")
                    Text("Gift")
                }
        }
        .accentColor(.blue)
        .navigationTitle("다가오는 생일 리스트")
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Bday.self, configurations: config)
        
        let today = Date()
        let mockBdays = [
            Bday(id: UUID(), name: "소이", profileImage: "soy", dateOfBday: today, isLunar: false, notiFrequency: ["당일", "1일 전"], relationshipTag: "#비지니스"),
            Bday(id: UUID(), name: "씨네필", profileImage: "", dateOfBday: Calendar.current.date(byAdding: .day, value: 7, to: today)!, isLunar: false, notiFrequency: ["3일 전"], relationshipTag: "#지인"),
            Bday(id: UUID(), name: "피카", profileImage: "pika", dateOfBday: Calendar.current.date(byAdding: .day, value: 15, to: today)!, isLunar: true, notiFrequency: ["1일 전", "7일 전"], relationshipTag: "#친구"),
            Bday(id: UUID(), name: "레디", profileImage: "ready", dateOfBday: Calendar.current.date(byAdding: .day, value: 25, to: today)!, isLunar: false, notiFrequency: ["당일"], relationshipTag: "#가족")
        ]
        
        for bday in mockBdays {
            container.mainContext.insert(bday)
        }
        
        return UpComingBdayView()
            .modelContainer(container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}

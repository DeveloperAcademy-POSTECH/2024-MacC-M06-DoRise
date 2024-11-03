//
//  ContentView.swift
//  DoBday
//
//  Created by Hajin on 10/17/24.
//

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
            
            // 생일이 오늘이거나 오늘부터 30일 이내인 경우를 포함
            
            // 오늘 생일인 것을 포함하는 로직
            if calendar.isDate(thisYearBday, inSameDayAs: today) {
                return true
            }
            
            // 오늘부터 30일 후까지의 범위에 포함되는지 확인
            return thisYearBday > today && thisYearBday <= thirtyDaysLater
        }.sorted {
            let date1 = calendar.date(from: calendar.dateComponents([.month, .day], from: $0.dateOfBday ?? Date())) ?? Date()
            let date2 = calendar.date(from: calendar.dateComponents([.month, .day], from: $1.dateOfBday ?? Date())) ?? Date()
            return date1 < date2
        }
    }

    var body: some View {
        NavigationView {
            VStack {
                Spacer(minLength: 98)
                HStack {
                    Spacer()
                    NavigationLink(destination: CalendarView(month: Date())) {
                        Image(systemName: "calendar")
                            .foregroundColor(.black)
                            .frame(width: 34, height: 16)
                    }
                        
                } //: HSTACK
                
                Spacer(minLength: 69)
                
                HStack {
                    Text("다가오는 생일")
                        .font(.system(size: 30, weight: .semibold))
                    Spacer()
                } //: HSTACK
                
                Spacer(minLength: 90)
                
                ScrollView(.horizontal) {
                                    HStack(spacing: 25) {
                                        ForEach(upcomingBdays) { bday in
                                            BdayTextView(bday: bday)
                                                .frame(width: 210, height: 262)
                                                .scrollTransition { content, phase in
                                                    content
                                                        .opacity(phase.isIdentity ? 1 : 0.5)
                                                        .scaleEffect(y: phase.isIdentity ? 1 : 0.8)
                                                }
                                        }
                                    }
                                    .scrollTargetLayout()
                    
                    Spacer(minLength: 246)
                }
                .contentMargins(50, for: .scrollContent)
                .scrollTargetBehavior(.viewAligned)
                
            } //: VSTACK
            .padding()
        }.navigationTitle("다가오는 생일 리스트")
    }
}

//#Preview {
//    UpComingBdayView()
//}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Bday.self, configurations: config)
        
        // 목업 데이터 생성
        let today = Date()
        let mockBdays = [
            Bday(id: UUID(), name: "소이", profileImage: "soy", dateOfBday: today, isLunar: false, notiFrequency: ["당일", "1일 전"], relationshipTag: "#비지니스"),
            Bday(id: UUID(), name: "씨네필", profileImage: "cinephile", dateOfBday: Calendar.current.date(byAdding: .day, value: 7, to: today)!, isLunar: false, notiFrequency: ["3일 전"], relationshipTag: "#지인"),
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


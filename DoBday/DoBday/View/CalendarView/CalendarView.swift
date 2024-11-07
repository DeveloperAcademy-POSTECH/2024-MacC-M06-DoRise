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













//#Preview {
//    NavigationStack{
//        CalendarView()
//    }
//}

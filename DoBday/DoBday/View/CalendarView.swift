//
//  CalendarView.swift
//  DoBday
//
//  Created by Hajin on 10/17/24.
//

import SwiftUI
import SwiftData

struct CalendarView: View {
    @Environment(\.modelContext) var context
    @Query var bdays: [Bday]

    var body: some View {
        NavigationView {
            VStack {
                NavigationLink("+", destination: CreateBdayView())
                
                List{
                    ForEach(bdays) { bday in
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .frame(width: 358, height: 104)
                                .foregroundColor(.gray)

                            HStack {
                                Circle()
                                    .frame(width: 72)

                                VStack {
                                    Text("\(bday.name)의 생일")
                                    Text(bday.notiFrequency)
                                }
                                Spacer()
                            }
                        }
                    }.onDelete { indexSet in
                        indexSet.forEach({index in
                            context.delete(bdays[index])
                        })
                    }
                }
            }
            .padding()
        }.navigationTitle("다가오는 생일 리스트")
    }
}

#Preview {
    CalendarView()
}

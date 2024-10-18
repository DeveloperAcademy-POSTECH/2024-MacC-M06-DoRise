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
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink("+", destination: CreateBdayView())



                List(bdays) {bday in
                    Text(bday.name)
                    Text("\(String(describing: bday.dateOfBday))")
                }
            }
            .padding()
        }.navigationTitle("다가오는 생일 리스트")
    }
}

#Preview {
    UpComingBdayView()
}

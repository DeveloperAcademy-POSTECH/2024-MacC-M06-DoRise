//
//  ShowingNearBirthsListView.swift
//  DoBday
//
//  Created by Hajin on 11/10/24.
//
import SwiftUI

struct ShowingNearBirthsListView: View {
    var upcomingBdays: [Bday]
    var closestBdays: [Bday]

    /// 가장 가까운 생일을 제외한 나머지 30일 이내의 생일 목록을 반환.
    var filteredUpcomingBdays: [Bday] {
        return upcomingBdays.filter { !closestBdays.contains($0) }
    }

    var body: some View {
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
}

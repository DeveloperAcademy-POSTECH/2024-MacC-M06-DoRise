//
//  ShowingTheNearestBirthView.swift
//  DoBday
//
//  Created by Hajin on 11/10/24.
//
import SwiftUI


struct ShowingTheNearestBirthView: View {

    var upcomingBdays: [Bday]

    /// 가장 가까운 생일 리스트를 반환.
    /// 가장 가까운 날짜의 생일을 찾아 해당 날짜와 같은 생일들을 필터링.
    var closestBdays: [Bday]

    var body: some View {
        HStack {
            Text("가장 가까운 생일")
                .font(.bday_t2Emphasized)
            Spacer()
        }

        if closestBdays.count > 1 {
            TabView {
                ForEach(closestBdays, id: \.id) { bday in
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

    }
}

//
//  MainTabView.swift
//  DoBday
//
//  Created by chanu on 11/3/24.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            UpComingBdayView()
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
        .accentColor(.blue) // 파란색으로일단.
    }
}

// 대충 뭐 만듬일단
struct PersonView: View {
    var body: some View {
        Text("Person View")
            .font(.largeTitle)
    }
}

struct GiftView: View {
    var body: some View {
        Text("Gift View")
            .font(.largeTitle)
    }
}

#Preview {
    MainTabView()
}

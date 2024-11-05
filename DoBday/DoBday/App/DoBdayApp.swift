//
//  DoBdayApp.swift
//  DoBday
//
//  Created by Hajin on 10/17/24.
//

import SwiftUI

@main
struct DoBdayApp: App {
    
    var body: some Scene {
        WindowGroup {
//            UpComingBdayView()
            GiveAndTakeView()
                .onAppear {
                    // 앱이 실행될 때 알림 권한 요청입니다.
                    NotificationManager.instance.requestAuthorization()
                }
        }
        .modelContainer(for: [Bday.self, GiftStatus.self, BdayGift.self])
    }
}

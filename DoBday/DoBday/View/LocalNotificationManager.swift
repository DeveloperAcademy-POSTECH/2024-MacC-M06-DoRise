//
//  LocalNotificationManager.swift.swift
//  DoBday
//
//  Created by chanu on 10/17/24.
//


import SwiftUI
import UserNotifications

class NotificationManager {
    
    static let instance = NotificationManager()
    
    let notiCenter = UNUserNotificationCenter.current()
    
    //인증
    func requestAuthorization() {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        notiCenter.requestAuthorization(options: options) { (success, error) in
            
            if success {
                print("인증 완료")
            }
            else {
                print("인증 안됨")
            }
        
            }
        }
    
    //노티 생성
    func scheduleNotification(){
        
        //내용
    
        let content = UNMutableNotificationContent()
        content.title = "오늘은 name의 생일이에요~!"
        content.subtitle = "name에게 축하메세지를 보내보세요!"
        content.sound = .default
        content.badge = 1
    
//날짜
        var dateComponents = DateComponents()
        dateComponents.hour = 13
        dateComponents.minute = 55
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            //time, calendar, location
        notiCenter.add(request)
        
        
        
        
    }
    
    //삭제
    func CancelNotification(){
        notiCenter.removeAllPendingNotificationRequests()
        notiCenter.removeAllDeliveredNotifications()
    }
    
    }
    

struct LocalNotificationManager: View{
    @State private var isToggleOn: Bool = false
    @State private var notiTime: Date = Date()
    
    
    var body: some View{
        VStack(spacing:40){
            Button("Request permission") {
                NotificationManager.instance.requestAuthorization()
            }
            Button("notifi") {
                NotificationManager.instance.scheduleNotification()
            }
            Button("cancel") {
                NotificationManager.instance.CancelNotification()
            }
            Toggle("무야호", isOn: $isToggleOn)
            if isToggleOn{
                DatePicker("", selection: $notiTime, displayedComponents: .date)
            }
            Text("\(isToggleOn)")
            Text("\(notiTime)")
//            Text("\(Calendar.current.component(.month, from: bday.dateOfBday!))")
        }
        .onAppear{
            UIApplication.shared.applicationIconBadgeNumber = 0
        }
    }
}

//당일/1일전/3일전/7일전/알림없음 Notification 구현
//알림없음은 false로 준다치면 됨 걍 함수실행안하면됨
//다중선택되게 뭐 7일전부터 당일마다 주는게 아니라 3일전 7일전 고르면 3,7일전 노티.

#Preview {
    LocalNotificationManager()
}

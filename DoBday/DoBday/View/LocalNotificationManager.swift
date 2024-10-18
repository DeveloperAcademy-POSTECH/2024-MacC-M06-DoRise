//
//  LocalNotificationManager.swift.swift
//  DoBday
//
//  Created by chanu on 10/17/24.
//


import SwiftUI
import UserNotifications //필수
import CoreLocation //위치쓸때쓰는거임

class NotificationManager {
    
    static let instance = NotificationManager() // 싱글톤
    
    let notiCenter = UNUserNotificationCenter.current()
    
    //인증받는창
    func requestAuthorization() {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        notiCenter.requestAuthorization(options: options) { (success, error) in
            
            if success {
                print("good")
            }
            else {
                print("no")
            }
        
            }
        }
    
    //생성함수
    func scheduleNotification(){
        
        let content = UNMutableNotificationContent()
        content.title = "오늘은 name의 생일이에요~!"
        content.subtitle = "name에게 축하메세지를 보내보세요!"
//        content.body = "Happy Birthday!"
        content.sound = .default
        content.badge = 1 //알림숫자
        
////        //time
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5.0, repeats: false) //오직 1번만 발생하고
        
//        calendar
        var dateComponents = DateComponents()
//        dateComponents.year = 2024
//        dateComponents.month = 11
//        dateComponents.day = 1
        dateComponents.hour = 13
        dateComponents.minute = 55
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
//        var coordinates = CLLocationCoordinate2D(latitude: 40.00, longitude: 50.00)
//        let region = CLCircularRegion(center: coordinates, radius: 100, identifier: UUID().uuidString)
//        let trigger = UNLocationNotificationTrigger(region: region, repeats: true)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            //time, calendar, location
        notiCenter.add(request)
        
        
        
        
    }
    
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
        }
        .onAppear{
            UIApplication.shared.applicationIconBadgeNumber = 0
        }
    }
}

//당일/1일전/3일전/7일전/알림없음 Notification 구현
//알림없음은 false로 준다치면 됨
//다중선택되게 뭐 7일전부터 당일마다 주는게 아니라 3일전 7일전 고르면 그날에만 주게

#Preview {
    LocalNotificationManager()
}

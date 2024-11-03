////
////  UpComingBdayCardView.swift
////  DoBday
////
////  Created by chanu on 11/3/24.
////
//
//import SwiftUI
//
//struct UpComingBdayCardView: View {
//    let bday: Bday
//    
//    var formattedBirthdate: String {
//            let formatter = DateFormatter()
//            formatter.dateFormat = "M.dd"
//            return formatter.string(from: bday.dateOfBday ?? Date())
//        }
//        
//        var dayOfWeek: String {
//            let formatter = DateFormatter()
//            formatter.locale = Locale(identifier: "ko_KR")
//            formatter.dateFormat = "E"
//            return formatter.string(from: bday.dateOfBday ?? Date())
//        }
//        
//        var dDayText: String {
//            guard let birthdate = bday.dateOfBday else { return "날짜 없음" }
//            
//            let calendar = Calendar.current
//            let today = calendar.startOfDay(for: Date())
//            let targetDate = calendar.startOfDay(for: birthdate)
//            let components = calendar.dateComponents([.day], from: today, to: targetDate)
//            
//            if let daysUntil = components.day {
//                return daysUntil == 0 ? "D-Day" : "D-\(daysUntil)"
//            } else {
//                return "D-Day"
//            }
//        }
//
////    var body: some View {
////        ZStack{
////            Rectangle()
////                .frame(width: 353, height:247)
////                .cornerRadius(20)
////                .foregroundColor(.upComingBdayCardBackgroundColor)
////            ScrollView(.horizontal, showsIndicators: true){
////                HStack(spacing: 40){
////                    Spacer()
////                    ZStack{
////                        RoundedRectangle(cornerRadius: 10)
////                            .stroke(Color(hex: "FFFFFF"), lineWidth: 5) // 흰색(FFFFFF) 테두리와 두께 5 적용
////                            .frame(width: 120, height: 160) // Image와 같은 크기
////                        
////                        
////                        
////                        Image("pika")
////                            .resizable()
////                            .scaledToFill()
////                            .frame(width:120,height:160)
////                            .clipShape(RoundedRectangle(cornerRadius: 12)) // 테두리 모양에 맞게 이미지 클리핑
////                        
////                    }
////                    Spacer()
////                    VStack{
////                        Text("이름")
////                        Text("날짜")
////                        Text("태그")
////                        Text("D-DAY")
////                        
////                        
////                    }
////                    Spacer()
////                }
////            }
////        }
////    }
////}
//    
////    
////
////#Preview {
////    UpComingBdayCardView()
////}
//
//    struct UpComingBdayCardView: View {
//        let bday: Bday
//        
//        var formattedBirthdate: String {
//            let formatter = DateFormatter()
//            formatter.dateFormat = "M.dd"
//            return formatter.string(from: bday.dateOfBday ?? Date())
//        }
//        
//        var dayOfWeek: String {
//            let formatter = DateFormatter()
//            formatter.locale = Locale(identifier: "ko_KR")
//            formatter.dateFormat = "E"
//            return formatter.string(from: bday.dateOfBday ?? Date())
//        }
//        
//        var dDayText: String {
//            guard let birthdate = bday.dateOfBday else { return "날짜 없음" }
//            
//            let calendar = Calendar.current
//            let today = calendar.startOfDay(for: Date())
//            let targetDate = calendar.startOfDay(for: birthdate)
//            let components = calendar.dateComponents([.day], from: today, to: targetDate)
//            
//            if let daysUntil = components.day {
//                return daysUntil == 0 ? "D-Day" : "D-\(daysUntil)"
//            } else {
//                return "D-Day"
//            }
//        }
//        
//        var body: some View {
//            ZStack {
//                RoundedRectangle(cornerRadius: 20)
//                    .fill(Color(UIColor.systemGray5))
//                    .frame(width: 353, height: 247)
//                    .shadow(radius: 5)
//                
//                HStack(spacing: 20) {
//                    ZStack {
//                        RoundedRectangle(cornerRadius: 10)
//                            .stroke(Color(hex: "FFFFFF"), lineWidth: 5)
//                            .frame(width: 120, height: 160)
//                        
//                        if let profileImage = bday.profileImage, !profileImage.isEmpty {
//                            Image(profileImage)
//                                .resizable()
//                                .scaledToFill()
//                                .frame(width: 120, height: 160)
//                                .clipShape(RoundedRectangle(cornerRadius: 12))
//                        } else {
//                            Image(systemName: "person.crop.circle.fill")
//                                .resizable()
//                                .frame(width: 120, height: 160)
//                                .foregroundColor(.gray)
//                        }
//                    }
//                    
//                    VStack(alignment: .leading, spacing: 10) {
//                        Text(bday.name)
//                            .font(.title3)
//                            .fontWeight(.bold)
//                        
//                        Text("\(formattedBirthdate)(\(dayOfWeek))")
//                            .font(.subheadline)
//                            .foregroundColor(.gray)
//                        
//                        Text(bday.relationshipTag)
//                            .font(.caption)
//                            .padding(.horizontal, 6)
//                            .padding(.vertical, 2)
//                            .background(Color.yellow.opacity(0.3))
//                            .clipShape(Capsule())
//                        
//                        Text(dDayText)
//                            .font(.headline)
//                            .foregroundColor(.black)
//                    }
//                    Spacer()
//                }
//                .padding()
//            }
//            .padding(.horizontal)
//        }
//    }
//
//    #Preview {
//        let sampleBday = Bday(id: UUID(),
//                              name: "임찬우",
//                              profileImage: "sampleImage",
//                              dateOfBday: Calendar.current.date(byAdding: .day, value: 7, to: Date()),
//                              isLunar: false,
//                              notiFrequency: ["당일", "1일 전"],
//                              relationshipTag: "#친구")
//        
//        return UpComingBdayCardView(bday: sampleBday)
//    }

import SwiftUI

struct UpComingBdayCardView: View {
    let bday: Bday
    
    var formattedBirthdate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "M.dd"
        return formatter.string(from: bday.dateOfBday ?? Date())
    }
    
    var dayOfWeek: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "E"
        return formatter.string(from: bday.dateOfBday ?? Date())
    }
    
    var dDayText: String {
        guard let birthdate = bday.dateOfBday else { return "날짜 없음" }
        
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let targetDate = calendar.startOfDay(for: birthdate)
        let components = calendar.dateComponents([.day], from: today, to: targetDate)
        
        if let daysUntil = components.day {
            return daysUntil == 0 ? "D-Day" : "D-\(daysUntil)"
        } else {
            return "D-Day"
        }
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(UIColor.systemGray5))
                .frame(width: 353, height: 247)
                .shadow(radius: 5)
            
            HStack(spacing: 20) {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color(hex: "FFFFFF"), lineWidth: 5)
                        .frame(width: 120, height: 160)
                    
                    if let profileImage = bday.profileImage, !profileImage.isEmpty {
                        Image(profileImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 120, height: 160)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    } else {
                        Image("basicprofile")
                            .resizable()
                            .scaledToFill()

                            .frame(width: 120, height: 160)
                            .foregroundColor(.gray)
                            .clipShape(RoundedRectangle(cornerRadius: 12))

                    }
                }
                
                VStack(alignment: .leading, spacing: 10) {
                    Text(bday.name)
                        .font(.title3)
                        .fontWeight(.bold)
                    
                    Text("\(formattedBirthdate)(\(dayOfWeek))")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    Text(bday.relationshipTag)
                        .font(.caption)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .background(Color.yellow.opacity(0.3))
                        .clipShape(Capsule())
                    
                    Text(dDayText)
                        .font(.headline)
                        .foregroundColor(.black)
                }
                Spacer()
            }
            .padding()
        }
        .padding(.horizontal)
    }
}

#Preview {
    let sampleBday = Bday(id: UUID(),
                          name: "임찬우",
                          profileImage: "",
                          dateOfBday: Calendar.current.date(byAdding: .day, value: 7, to: Date()),
                          isLunar: false,
                          notiFrequency: ["당일", "1일 전"],
                          relationshipTag: "#친구")
    
    return UpComingBdayCardView(bday: sampleBday)
}

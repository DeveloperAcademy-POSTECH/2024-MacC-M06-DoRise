////
////  BdayTextView.swift
////  DoBday
////
////  Created by Cho YeonJi on 10/20/24.
////
//
//import SwiftUI
//
//struct BdayTextView: View {
//    let bday: Bday
//    let formatter = DateFormatter()
//    let calendar = Calendar.current
//    
//    // 생일 달과 일을 MM.dd 형식으로 변형하는 DateFormatter
//    var formattedBirthdate: String {
//        formatter.dateFormat = "M.dd"
//        return formatter.string(from: bday.dateOfBday ?? Date())
//    }
//    
//    // 생일 요일을 한글(E)로 변형하는 DateFormatter
//    var dayOfWeek: String {
//        formatter.locale = Locale(identifier: "ko_KR")
//        formatter.dateFormat = "E"
//        return formatter.string(from: bday.dateOfBday ?? Date())
//    }
//    
//    // d-day 계산하는 기능
//    var dDayText: String {
//           guard let birthdate = bday.dateOfBday else { return "날짜 없음" }
//           
//           let today = calendar.startOfDay(for: Date())
//           let thirtyDaysLater = calendar.date(byAdding: .day, value: 30, to: today)!
//           
//           // 생일의 월과 일만 고려
//           let birthdateComponents = calendar.dateComponents([.month, .day], from: birthdate)
//           let thisYearBirthdate = calendar.date(from: DateComponents(year: calendar.component(.year, from: today), month: birthdateComponents.month, day: birthdateComponents.day))!
//           
//           // 생일이 오늘부터 30일 이내인지 확인
//           if thisYearBirthdate < today {
//               // 이미 지난 생일은 내년 생일로 계산
//               let nextYearBirthdate = calendar.date(byAdding: .year, value: 1, to: thisYearBirthdate)!
//               if nextYearBirthdate <= thirtyDaysLater {
//                   let daysUntilBirthday = calendar.dateComponents([.day], from: today, to: nextYearBirthdate).day!
//                   return daysUntilBirthday == 0 ? "D-Day" : "D-\(daysUntilBirthday)"
//               }
//           } else if thisYearBirthdate <= thirtyDaysLater {
//               let daysUntilBirthday = calendar.dateComponents([.day], from: today, to: thisYearBirthdate).day!
//               return daysUntilBirthday == 0 ? "D-Day" : "D-\(daysUntilBirthday)"
//           }
//           
//           return "" // 30일 이내 생일이 아닌 경우 빈 문자열 반환
//       }
//
//    
//    var body: some View {
//        VStack {
//            HStack {
//                Text("\(formattedBirthdate)")
//                    .font(.custom("Pretendard-Bold", size: 18))
//                Text("(\(dayOfWeek))")
//                    .font(.custom("Pretendard-Regular", size: 12))
//            } //: HSTACK
//            
//            ZStack {
//                // profileImage가 있으면 사진을, 없으면 검은 사각형을 띄움
//                Group {
//                    if let profileImage = bday.profileImage, !profileImage.isEmpty {
//                        Image(profileImage)
//                            .resizable()
//                            .aspectRatio(contentMode: .fill)
//                    } else {
//                        RoundedRectangle(cornerRadius: 30)
//                            .fill(Color.black)
//                    }
//                }
//                .frame(width: 210, height: 262)
//                .clipShape(RoundedRectangle(cornerRadius: 30))
//                .shadow(radius: 10, x: 5, y: 5)
//                
//                // 이름과 D-day 표시
//                    HStack {
//                        Spacer()
//                        
//                        Text("\(bday.name)")
//                            .font(.custom("Pretendard-SemiBold", size: 34))
//                            .foregroundStyle(Color.white)
//                            .background(Color.black.opacity(1))
//                            .padding(.leading, 20)
//                            .padding(.top, 202)
//                            .padding(.bottom, 19)
//                        
//                        Spacer()
//                        
//                        Text(dDayText)
//                            .font(.custom("Pretendard-SemiBold", size: 17))
//                            .foregroundStyle(Color.white)
//                            .background(Color.black.opacity(1))
//                            .padding(.trailing, 15.4)
//                            .padding(.top, 234)
//                        
//                        Spacer()
//                    }
//            } //: ZSTACK
//        } //: VSTACK
//    }
//}
//
//#Preview {
//    let sampleBday = Bday(id: UUID(),
//                          name: "소이",
//                          profileImage: "soy",
//                          dateOfBday: Date(),
//                          isLunar: false,
//                          notiFrequency: ["당일", "1일 전"],
//                          relationshipTag: "#비지니스")
//    
//    return BdayTextView(bday: sampleBday)
//}
//
import SwiftUI

struct BdayTextView: View {
    let bday: Bday
    let formatter = DateFormatter()
    let calendar = Calendar.current
    
    var formattedBirthdate: String {
        formatter.dateFormat = "M.dd"
        return formatter.string(from: bday.dateOfBday ?? Date())
    }
    
    var dayOfWeek: String {
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "E"
        return formatter.string(from: bday.dateOfBday ?? Date())
    }
    
    var dDayText: String {
        guard let birthdate = bday.dateOfBday else { return "날짜 없음" }
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
                .foregroundColor(.upComingBdayCardBackgroundColor)
                .frame(width: 352, height: 102)
                .shadow(radius: 4)
            
            HStack(spacing: 20) {
                ZStack {
                    if let profileImage = bday.profileImage, !profileImage.isEmpty {
                        Image(profileImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 70, height: 70)
                            .cornerRadius(45)                            .overlay(Circle().stroke(Color.white, lineWidth: 2))
                    } else {
                        Image("basicprofile")
                            .resizable()
                            .scaledToFill()
                            .frame(width:70, height:70)
                            .cornerRadius(45)
                            .overlay(Circle().stroke(Color.white, lineWidth: 2))
                            
                    }
                }
                
                VStack(alignment: .leading, spacing: 5) {
                    HStack{
                        Text(bday.name)
                            .font(.system(size: 16))
                            .fontWeight(.semibold)
                            .lineLimit(1)
                        
                        
                        Text(bday.relationshipTag)
                            .font(.caption)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 4)
                            .background(Color.yellow.opacity(0.3))
                            .clipShape(Capsule())
                        
                    }
                    Text("\(formattedBirthdate)(\(dayOfWeek))")
                        
                        .font(.subheadline)
                        .foregroundColor(.gray)


                }
                
                Spacer()
                
                Text(dDayText)
                    .font(.subheadline)
                    .foregroundColor(.black)
                    .padding(.trailing,17)
                    .padding(.top,60)
                

                    
            }
            .padding(.horizontal, 15)
        }
    }
}

#Preview {
    let sampleBday = Bday(id: UUID(),
                          name: "임찬우",
                          profileImage: "",
                          dateOfBday: Calendar.current.date(byAdding: .day, value: 7, to: Date()),
                          isLunar: false,
                          notiFrequency: ["당일", "1일 전"],
                          relationshipTag: "친구")
    
    return BdayTextView(bday: sampleBday)
}

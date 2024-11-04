////
////  BdayTextView.swift
////  DoBday
////
////  Created by Cho YeonJi on 10/20/24.
////
//
import SwiftUI

struct BdayTextView: View {
    let bday: Bday
    let formatter = DateFormatter()
    let calendar = Calendar.current
    
    var formattedBirthdate: String {
        formatter.dateFormat = "M.dd"
        return formatter.string(from: bday.dateOfBday ?? Date())
    } // : 날짜 M.dd 표기
    
    var dayOfWeek: String {
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "E"
        return formatter.string(from: bday.dateOfBday ?? Date())
    } // : 요일 E 표기
    
    var dDayText: String {
        guard let birthdate = bday.dateOfBday else { return "저장된 날짜가 없어요." }
        let today = calendar.startOfDay(for: Date())
        let targetDate = calendar.startOfDay(for: birthdate)
        let components = calendar.dateComponents([.day], from: today, to: targetDate)
        if let daysUntil = components.day {
            return daysUntil == 0 ? "D-Day" : "D-\(daysUntil)" // : D-day 표기
        } else {
            return "daysUntil is nil"
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
                            .cornerRadius(45)                          .overlay(Circle().stroke(Color.white, lineWidth: 2))
                    } else {
                        Image("basicprofile")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 70, height: 70)
                            .cornerRadius(45)
                                .overlay(Circle().stroke(Color.white, lineWidth: 2))
                        
                    }
                }
                
                VStack(alignment: .leading, spacing: 5) {
                        Text(bday.name)
                        .font(.bday_t3Emphasized)
                    
                    Text("\(formattedBirthdate)(\(dayOfWeek))")
                    .font(.bday_footRegular)
                    .foregroundColor(.gray)
                    
                    Text(bday.relationshipTag)
                    .font(.bday_c2Emphasized)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 3)
                    .background(Color.yellow.opacity(0.3))
                    .clipShape(Capsule())
                    
                }
                
                Spacer()
                
                Text(dDayText)
                    .font(.bday_footEmphasized)
                    .padding(.trailing,17)
                    .padding(.top,60)
                
                
                
            } // : HStack
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

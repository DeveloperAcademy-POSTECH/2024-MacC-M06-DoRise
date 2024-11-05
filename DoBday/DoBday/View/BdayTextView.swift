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
    
    /// 날짜 M.dd 표기
    var formattedBirthdate: String {
        formatter.dateFormat = "M.dd"
        return formatter.string(from: bday.dateOfBday ?? Date())
    }
    
    /// 요일 E 표기
    var dayOfWeek: String {
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "E"
        return formatter.string(from: bday.dateOfBday ?? Date())
    }
    
    /// 선택된 생일 날짜와 오늘의 날짜를 비교하여 D-Day 텍스트를 반환.
    /// 생일이 오늘이면 "D-Day"를 반환하고, 오늘보다 멀다면 "D-daysUntil" 형식으로 반환.
    /// 생일 날짜가 없으면 "저장된 날짜가 없어요."를 반환.
    var dDayText: String {
        guard let birthdate = bday.dateOfBday else { return "저장된 날짜가 없어요." }
        let today = calendar.startOfDay(for: Date())
        let targetDate = calendar.startOfDay(for: birthdate)
        let components = calendar.dateComponents([.day], from: today, to: targetDate)
        if let daysUntil = components.day {
            return daysUntil == 0 ? "D-Day" : "D-\(daysUntil)"
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

                    if let profileImage = bday.profileImage, let uiImage = UIImage(data: profileImage) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 70, height: 70)
                            .cornerRadius(45)
                            .overlay(Circle().stroke(Color.white, lineWidth: 2))
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
                    
                    if !bday.relationshipTag.filter({ !$0.isEmpty }).isEmpty {
                        HStack {
                            ForEach(bday.relationshipTag.filter { !$0.isEmpty }, id: \.self) { tag in
                                Text(tag)
                                    .font(.bday_c2Emphasized)
                                    .padding(.horizontal, 6)
                                    .padding(.vertical, 2)
                                    .background(Color.red.opacity(0.3))
                                    .cornerRadius(20)
                            }
                        }
                    }
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

//#Preview {
//    let sampleBday = Bday(id: UUID(),
//                          name: "임찬우",
//                          profileImage: "",
//                          dateOfBday: Calendar.current.date(byAdding: .day, value: 7, to: Date()),
//                          isLunar: false,
//                          notiFrequency: ["당일", "1일 전"],
//                          relationshipTag: ["#친구","#비즈니스"])
//    
//    return UpComingBdayCardView(bday: sampleBday)
//}

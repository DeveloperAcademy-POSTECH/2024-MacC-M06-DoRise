////////
////////  UpComingBdayCardView.swift
////////  DoBday
////////
////////  Created by chanu on 11/3/24.
////////
//////
import SwiftUI

struct UpComingBdayCardView: View {
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
            return daysUntil == 0 ? "D-Day" : "D-\(daysUntil)" // : D-day 표기
        } else {
            return "daysUntil is nil"
        }
    }
    
    var body: some View {
        ZStack {
            HStack(spacing: 20) {
                ZStack {
                    if let profileImage = bday.profileImage, let uiImage = UIImage(data: profileImage) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 120, height: 160)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    } else {
                        Image("basicprofile")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 120, height: 160)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                    
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color(hex: "FFFFFF"), lineWidth: 5)
                        .frame(width: 120, height: 160)
                } // : ZStack
                
                
                VStack(alignment: .leading, spacing: 10) {
                    Text(bday.name)
                        .font(.bday_t2Emphasized)
                    
                    Text("\(formattedBirthdate)(\(dayOfWeek))")
                        .font(.bday_t3Regular)
                        .foregroundColor(.gray)
                    
                    //TODO : #47PR 피카피드백반영하여 주석처리
//                    if !bday.relationshipTag.filter({ !$0.isEmpty }).isEmpty {
//                        HStack {
//                            ForEach(bday.relationshipTag.filter { !$0.isEmpty }, id: \.self) { tag in
//                                Text(tag)
//                                    .font(.bday_c2Emphasized)
//                                    .padding(.horizontal, 6)
//                                    .padding(.vertical, 2)
//                                    .background(Color.red.opacity(0.3))
//                                    .cornerRadius(20)
//                            }
//                        }
//                    }
                    
                    
                    HStack{
                        Spacer()
                        Text(dDayText)
                            .font(.bday_t1Emphasized)
                        
                    }.padding(.trailing,-30)
                    
                }.padding(.leading,10) // : VStack
                
                Spacer()
            } // : HStack
            .padding()
        }
        .padding(.horizontal)
    }
}

//#Preview {
//    let sampleBday = Bday(id: UUID(),
//                          name: "임찬우",
//                          profileImage: "",
//                          dateOfBday: Calendar.current.date(byAdding: .day, value: 7, to: Date()),
//                          isLunar: false,
//                          notiFrequency: ["당일", "1일 전"],
//                          relationshipTag: ["#친구","비즈니스"])
//    
//    return UpComingBdayCardView(bday: sampleBday)
//}

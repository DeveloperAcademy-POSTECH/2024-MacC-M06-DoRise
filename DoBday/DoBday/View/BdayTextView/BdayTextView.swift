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

    var body: some View {
        ZStack {
            //배경
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(.upComingBdayCardBackgroundColor)
                .frame(width: 352, height: 102)
                .shadow(radius: 4)
            
            HStack(spacing: 20) {
                ZStack {
                    ProfileImageView(profileImage: bday.profileImage)
                }
                
                VStack(alignment: .leading, spacing: 5) {
                    // 생일자 이름
                    Text(bday.name)
                        .font(.bday_t3Emphasized)
                        .foregroundColor(.black)

                    // 생일 날짜와 요일
                    Text("\(formattedBirthdate())" + "(" + dayOfWeek() + ")")
                        .font(.bday_footRegular)
                        .foregroundColor(.gray)
                    // 태그
                    TagListView(tags: bday.relationshipTag)
                }
                
                
                
                Spacer()
                
                // D-Day
                Text(dDayText())
                    .font(.bday_footEmphasized)
                    .foregroundColor(.black)
                    .padding(.trailing,17)
                    .padding(.top,60)
                
                
                
                
            } // : HStack
            .padding(.horizontal, 15)
        }
    }
}
// MARK: - extension BdayTextView
extension BdayTextView {
    
    /// 날짜 M.dd 표기
    func formattedBirthdate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "M.dd"
        return formatter.string(from: bday.dateOfBday ?? Date())
    }
    
    
    /// 요일 E 표기
    func dayOfWeek() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "E"
        return formatter.string(from: bday.dateOfBday ?? Date())
    }

    /// 선택된 생일 날짜와 오늘의 날짜를 비교하여 D-Day 텍스트를 반환.
    /// 생일이 오늘이면 "D-Day"를 반환하고, 오늘보다 멀다면 "D-daysUntil" 형식으로 반환.
    /// 생일 날짜가 없으면 "저장된 날짜가 없어요."를 반환.
    func dDayText() -> String {
        guard let birthdate = bday.dateOfBday else { return "저장된 날짜가 없어요." }
        let today = Calendar.current.startOfDay(for: Date())
        let targetDate = Calendar.current.startOfDay(for: birthdate)
        let components = Calendar.current.dateComponents([.day], from: today, to: targetDate)
        if let daysUntil = components.day {
            return daysUntil == 0 ? "D-Day" : "D-\(daysUntil)" // : D-day 표기
        } else {
            return "daysUntil is nil"
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

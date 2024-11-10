
import SwiftUI

struct UpComingBdayCardView: View {
    let bday: Bday
    
        
    var body: some View {
        ZStack {
            HStack(spacing: 20) {
                ZStack {
                    
                    PhotoRoundedRect(imageData: bday.profileImage, alternativeImage: "basicprofile", width: 120, height: 160)
                    
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color(hex: "FFFFFF"), lineWidth: 5)
                        .frame(width: 120, height: 160)
                }
                
                CardContentView(bday: bday)
                
                Spacer()
            } 
            .padding()
        }
        .padding(.horizontal)
    }
}


struct CardContentView: View {
    
    var bday: Bday
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // 이름
            Text(bday.name)
                .font(.bday_t2Emphasized)
                .foregroundColor(.black)
            
            // 12.09(월)
            Text("\(formattedBirthdate())" + "(" + dayOfWeek() + ")")
                .font(.bday_t3Regular)
                .foregroundColor(.gray)
            
            // 태그
            TagListView(tags: bday.relationshipTag)
            
            
            HStack{
                
                Spacer()
                
                // D-30
                Text(dDayText())
                    .font(.bday_t1Emphasized)
                    .foregroundColor(.black)
                
            }.padding(.trailing,-30)
            
        }.padding(.leading,10) 
    }
}



extension CardContentView {
    
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



#Preview {
    UpComingBdayCardView(
        bday: Bday(
            id: UUID(),
            name: "피카",
            profileImage: nil,
            dateOfBday: Calendar.current.date(byAdding: .month, value: 1, to: Date()),
            isLunar: true,
            notiFrequency: ["1일 전", "7일 전"],
            relationshipTag: ["#친구"]
        )
    )
}

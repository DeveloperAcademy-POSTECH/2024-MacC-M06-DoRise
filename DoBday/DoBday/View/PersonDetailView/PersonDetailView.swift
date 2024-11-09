import SwiftUI

struct PersonDetailView: View {

    @State private var name = ""
    @State private var profileImage: Data?
    @State private var dateOfBday: Date = Date()
    @State private var isLunar = false
    @State private var notiFrequency = [""]
    @State private var relationshipTag = [""]

    @State private var isshowingSheet = false

    var bday: Bday?

    init(bday: Bday? = nil) {
        self.bday = bday
        if let bday = bday {
            _name = State(initialValue: bday.name)
            _profileImage = State(initialValue: bday.profileImage)
            _dateOfBday = State(initialValue: bday.dateOfBday ?? Date())
            _isLunar = State(initialValue: bday.isLunar)
            _notiFrequency = State(initialValue: bday.notiFrequency)
            _relationshipTag = State(initialValue: bday.relationshipTag)
        }
    }

    var body: some View {
        VStack {

            ShowingProfileOfPersonView(name: $name, dateOfBday: $dateOfBday)

            ShowingPresentForGivingToYouView()

            ShowingTasteCollageView(name: $name)

            ShowingPresentForGiveAndTakeView(name: $name)

        }
        .padding(.init(top: 0, leading: 20, bottom: 0, trailing: 20))
    }
}



//#Preview {
//    PersonDetailView()
//}


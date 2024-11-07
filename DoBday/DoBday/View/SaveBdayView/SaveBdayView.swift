//
//  SaveBdayView.swift
//  DoBday
//
//  Created by Hajin on 10/17/24.
//

import SwiftUI
import SwiftData
import PhotosUI

import KoreanLunarSolarConverter

struct SaveBdayView: View {
    //모델에 대한 모든 변경사항 관찰하고 작동할 많은 작업을 제공함.
    @Environment(\.modelContext) var context

    @State private var name = ""
    @State private var profileImage: Data?
    @State private var dateOfBday: Date = Date()
    @State private var isLunar = false
    @State private var notiFrequency = [""]
    @State private var relationshipTag = [""]

    @State private var selectedItem: PhotosPickerItem?

    @State private var isshowingSheetForSettingDate = false
    @State private var isshowingSheetForCreatingTag = false

    var bday: Bday?

    @Query var bdayTags: [BdayTag]

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

    @Environment(\.dismiss) var dismiss

    @State private var imageData: Data?

    static let dateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY년 M월 d일"
        return formatter
    }()


    var body: some View {
        VStack {
            HeaderForSaveBdayView(name: $name, dateOfBday: $dateOfBday, isLunar: $isLunar, notiFrequency: $notiFrequency, imageData: $imageData, relationshipTag: $relationshipTag, profilrImage: $profileImage)

            PhotoPickerForSaveBdayView(imageData: $imageData, selectedItem: $selectedItem)

            SetNameForSaveBdayView(name: $name)

            SetBirthForSaveBdayView(isLunar: $isLunar, dateOfBday: $dateOfBday, isshowingSheetForSettingDate: $isshowingSheetForSettingDate)

            ShowingBdayTagOfSaveBdayView(bdayTags: bdayTags, relationshipTag: $relationshipTag, isshowingSheetForCreatingTag: $isshowingSheetForCreatingTag)

            SetAlarmInSaveBdayView(notiFrequency: $notiFrequency)

            Spacer()

        }
    }
}

//#Preview {
//    SaveBdayView()
//}

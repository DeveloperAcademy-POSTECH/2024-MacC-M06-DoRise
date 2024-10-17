//
//  Model.swift
//  DoBday
//
//  Created by Hajin on 10/17/24.
//

import Foundation
import SwiftData
import SwiftUI

@Model
final class Bday: Identifiable {
    var id: UUID
    var name: String
    var profileImage: Image?
    var dateOfBday: Date?
    var isLunar: Bool
    var notiFrequency: String

    init(id: UUID, name: String, profileImage: Image? = nil, dateOfBday: Date? = nil, isLunar: Bool, notiFrequency: String) {
        self.id = id
        self.name = name
        self.profileImage = profileImage
        self.dateOfBday = dateOfBday
        self.isLunar = isLunar
        self.notiFrequency = notiFrequency
    }
}

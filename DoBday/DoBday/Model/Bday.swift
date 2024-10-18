//
//  Model.swift
//  DoBday
//
//  Created by Hajin on 10/17/24.
//

import Foundation
import SwiftData

@Model
final class Bday: Identifiable {
    var id: UUID
    var name: String
    var profileImage: String?
    var dateOfBday: Date?
    var isLunar: Bool
    var notiFrequency: String
    var relationshipTag: String

    init(id: UUID, name: String, profileImage: String? = nil, dateOfBday: Date? = nil, isLunar: Bool, notiFrequency: String, relationshipTag: String) {
        self.id = id
        self.name = name
        self.profileImage = profileImage
        self.dateOfBday = dateOfBday
        self.isLunar = isLunar
        self.notiFrequency = notiFrequency
        self.relationshipTag = relationshipTag
    }
}

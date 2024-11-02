//
//  BdayTag.swift
//  DoBday
//
//  Created by Hajin on 11/1/24.
//

import Foundation
import SwiftData
import SwiftUI

@Model
final class BdayTag: Identifiable {
    var id: UUID
    var tagName: String
//    var tagColor: Color

    init(id: UUID, tagName: String/*tagColor: Color*/) {
        self.id = id
        self.tagName = tagName
//        self.tagColor = tagColor
    }
}

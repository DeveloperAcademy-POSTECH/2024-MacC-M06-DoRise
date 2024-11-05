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

    init(id: UUID, tagName: String/*, tagColor: Color*/) {
        self.id = id
        self.tagName = tagName
//        self.tagColor = tagColor
    }
}
//
//func initializeDefaultTags(context: ModelContext) {
//    // 기본 태그들
//    let defaultTags = [
//        ("#친구", Color.red),
//        ("#가족", Color.green)
//    ]
//
//    // 기본 태그가 이미 존재하는지 확인하고 없으면 추가
//    for (name, color) in defaultTags {
//        if !context.contains(where: { ($0 as? BdayTag)?.tagName == name }) {
//            let newTag = BdayTag(tagName: name, tagColor: color)
//            context.insert(newTag)
//        }
//    }
//}

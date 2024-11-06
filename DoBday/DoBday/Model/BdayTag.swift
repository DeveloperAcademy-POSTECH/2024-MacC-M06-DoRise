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
    var tagColor: String

    init(id: UUID, tagName: String, tagColor: String) {
        self.id = id
        self.tagName = tagName
        self.tagColor = tagColor
    }
}

func addDefaultTags(context: ModelContext) {

    let defaultTags = [
        BdayTag(id: UUID(), tagName: "가족", tagColor: "73BFB9"),
        BdayTag(id: UUID(), tagName: "친구", tagColor: "3DA5D9")
    ]

    for tag in defaultTags {

        do {
            let fetchList = try context.fetch(FetchDescriptor<BdayTag>())

        } catch {
            print("앗 패치 실패,,,")
        }
        context.insert(tag)



//        do {
//            let bdayList = try context.fetch(FetchDescriptor<Bday>())
//        } catch {
//
//        }
//
//        if context.fetch(Bday.self).allSatisfy({ $0.tagName != tag.tagName }) {
//            context.insert(tag)
//        }
    }
}

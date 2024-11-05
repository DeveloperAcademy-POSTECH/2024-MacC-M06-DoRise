//
//  GiftStatus.swift
//  DoBday
//
//  Created by Hajin on 11/1/24.
//

import Foundation
import SwiftData

enum GiftStatusType: Codable {
    case toBeGiven // 줄 예정
    case given     // 준 선물
    case receivedGift // 받은 선물
}

@Model
final class GiftStatus: Identifiable {
    var id: UUID
    var gift: BdayGift?
    var person: Bday?
    var status: GiftStatusType

    init(id: UUID, gift: BdayGift? = nil, person: Bday, status: GiftStatusType) {
        self.id = id
        self.gift = gift
        self.person = person
        self.status = status
    }
}

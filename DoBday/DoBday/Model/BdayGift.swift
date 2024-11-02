//
//  File.swift
//  DoBday
//
//  Created by Hajin on 11/1/24.
//

import Foundation
import SwiftData

@Model
final class BdayGift: Identifiable {
    var id: UUID
    var isToBeGiven: Bool
    var giftName: String
    var giftPrice: String?
    var giftImage: String?
    var memo: String?
    var giftURL: String?

    init(id: UUID, isToBeGiven: Bool, giftName: String, giftPrice: String?, giftImage: String?, memo: String?, giftURL: String?) {
        self.id = id
        self.isToBeGiven = true
        self.giftName = giftName
        self.giftPrice = nil
        self.giftImage = nil
        self.memo = nil
        self.giftURL = nil
    }
}

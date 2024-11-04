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
    var giftImage: Data?
    var memo: String?
    var giftURL: String?

    init(id: UUID, isToBeGiven: Bool, giftName: String, giftPrice: String?, giftImage: Data?, memo: String?, giftURL: String?) {
        self.id = id
        self.isToBeGiven = isToBeGiven
        self.giftName = giftName
        self.giftPrice = giftPrice
        self.giftImage = giftImage
        self.memo = memo
        self.giftURL = giftURL
    }
}

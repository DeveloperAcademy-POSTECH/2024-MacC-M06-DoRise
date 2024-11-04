//
//  MockupData.swift
//  DoBday
//
//  Created by 이소현 on 10/17/24.
//

import Foundation
import SwiftUI

let mockBdayData: [Bday] = [
    Bday(id: UUID(), name: "레디", profileImage: "ready", dateOfBday: Calendar.current.date(byAdding: .day, value: -1, to: Date()), isLunar: false, notiFrequency: ["당일"], relationshipTag: "#가족"),
    Bday(id: UUID(), name: "소이", profileImage: "soy", dateOfBday: Calendar.current.date(byAdding: .day, value: -1, to: Date()), isLunar: false, notiFrequency: ["당일", "1일 전"], relationshipTag: "#비지니스"),
    Bday(id: UUID(), name: "씨네필", profileImage: "cinephile", dateOfBday: Calendar.current.date(byAdding: .day, value: 7, to: Date()), isLunar: false, notiFrequency: ["3일 전"], relationshipTag: "#지인"),
    Bday(id: UUID(), name: "피카", profileImage: "pika", dateOfBday: Calendar.current.date(byAdding: .month, value: 1, to: Date()), isLunar: true, notiFrequency: ["1일 전", "7일 전"], relationshipTag: "#친구")
]


let sampleGifts: [BdayGift] = [
    BdayGift(
        id: UUID(),
        isToBeGiven: true,
        giftName: "꽃다발",
        giftPrice: "₩30,000",
        giftImage: nil,
        memo: "생일에 맞춰 전달 예정",
        giftURL: "https://flowershop.com/bouquet"
    ),
    BdayGift(
        id: UUID(),
        isToBeGiven: true,
        giftName: "초콜릿 박스",
        giftPrice: "₩15,000",
        giftImage: nil,
        memo: "달콤한 선물",
        giftURL: "https://chocolateshop.com/box"
    ),
    BdayGift(
        id: UUID(),
        isToBeGiven: false,
        giftName: "책 - 소설",
        giftPrice: "₩20,000",
        giftImage: nil,
        memo: "추천 도서",
        giftURL: "https://bookstore.com/novel"
    ),
    BdayGift(
        id: UUID(),
        isToBeGiven: false,
        giftName: "커피 기프티콘 스타벅스 개존맛",
        giftPrice: "₩5,000",
        giftImage: nil,
        memo: "언제든 사용 가능",
        giftURL: "https://coffeeshop.com/giftcard"
    )
]

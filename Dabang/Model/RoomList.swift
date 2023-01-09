//
//  RoomList.swift
//  Dabang
//
//  Created by seonggon on 2023/01/06.
//

import Foundation

/// 전체 방 목록 모델
struct RoomList: Decodable {
    let average: [Average]
    let rooms: [Room]
}
/// 평균가 모델
struct Average: Decodable {
    let monthPrice: String
    let name: String
    let yearPrice: String
}
/// 방 정보 모델
struct Room: Decodable {
    let desc: String
    let is_check: Bool
    let price_title: String
    private let room_type: Int
    private let selling_type: Int
    let hash_tags: [String]
    let img_url: String
    
    /// 방 종류
    var roomType: RoomType? {
        RoomType(rawValue: room_type)
    }
    /// 매물 종류
    var sellingType: SellingType? {
        SellingType(rawValue: selling_type)
    }
    /// 가격
    var price: Int {
        price_title.priceToInt
    }
}

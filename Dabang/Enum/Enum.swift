//
//  Enum.swift
//  Dabang
//
//  Created by seonggon on 2023/01/07.
//

import Foundation

/// 방 종류
enum RoomType: Int, CaseIterable {
    case 원룸 = 0
    case 투쓰리룸
    case 오피스텔
    case 아파트
}
/// 매물 종류
enum SellingType: Int, CaseIterable {
    case 월세 = 0
    case 전세
    case 매매
}
/// 가격 정렬
enum PriceType {
    case 오름차순
    case 내림차순
}

//
//  ViewModel.swift
//  Dabang
//
//  Created by seonggon on 2023/01/06.
//

import Foundation

/// 방목록 뷰모델
final class ViewModel {
    /// 전체 데이터
    private lazy var roomList: RoomList = load("RoomListData.json")
    /// 한 페이지 당 아이템 개수
    let pageCount = 12
    /// 방 종류 필터 배열
    private var roomTypeArr = RoomType.allCases
    /// 매물 종류 필터 배열
    private var sellingTypeArr = SellingType.allCases
    /// 가격 정렬
    private var priceType: PriceType = .오름차순
    /// 페이징 플래그
    private var isPaging = false
    /// 방 목록
    var rooms: [Room] = []
    /// 데이터 출력 (refresh: 초기화)
    var outputData: ((_ refresh: Bool) -> ())?
    
    init() {
        getData()
    }
    
    /// 방 목록 데이터 가져오기
    /// - Parameter reset: 초기화
    private func getData(reset: Bool = true) {
        isPaging = true
        
        if reset {
            rooms.removeAll()
        }
        
        let filterRooms = roomList.rooms.filter {
            guard let roomType = $0.roomType,
                  let sellingType = $0.sellingType else { return false }
            return roomTypeArr.contains(roomType) && sellingTypeArr.contains(sellingType)
        }.sorted {
            priceType == .오름차순 ? $0.price < $1.price : $0.price > $1.price
        }
        
        let nextCount = rooms.count + pageCount
        
        let addArr = (rooms.count..<nextCount).compactMap {
            filterRooms[safe: $0]
        }
        
        rooms += addArr
        
        outputData?(reset)
        
        isPaging = false
    }
    
    /// 방 종류 선택
    /// - Parameters:
    ///   - roomType: 방 종류
    ///   - isSelected: 선택 여부
    func inputRoomType(roomType: RoomType, isSelected: Bool) -> Bool {
        if isSelected, roomTypeArr.count == 1 {
            return isSelected
        }
        if isSelected {
            roomTypeArr.removeAll(where: { $0.rawValue == roomType.rawValue })
        } else {
            roomTypeArr.append(roomType)
        }
        getData()
        
        return !isSelected
    }
    
    /// 매물 종류 선택
    /// - Parameters:
    ///   - sellingType: 매물 종류
    ///   - isSelected: 선택 여부
    func inputSellingType(sellingType: SellingType, isSelected: Bool) -> Bool {
        if isSelected, sellingTypeArr.count == 1 {
            return isSelected
        }
        if isSelected {
            sellingTypeArr.removeAll(where: { $0.rawValue == sellingType.rawValue })
        } else {
            sellingTypeArr.append(sellingType)
        }
        getData()
        
        return !isSelected
    }
    
    /// 가격 정렬 선택
    /// - Parameter priceType: 정렬
    func inputPrice(priceType: PriceType) {
        self.priceType = priceType
        getData()
    }
    
    /// 스크롤 하단
    func inputScrollBottom() {
        let totalCount = roomList.rooms.count
        let nowCount = rooms.count
        
        let hasNextPage = nowCount < totalCount
        
        if isPaging == false && hasNextPage {
            getData(reset: false)
        }
    }
    
    /// 평균가 데이터 가져오기
    func getAverageData(idx: Int) -> Average? {
        let count = idx + 1
        return count.isMultiple(of: pageCount) || count == rooms.count ? roomList.average.first : nil
    }
    
    /// Json 데이터 읽기
    /// - Parameter filename: 파일명
    /// - Returns: 제네릭 타입
    private func load<T: Decodable>(_ filename: String) -> T {
        let data: Data
        
        guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
        }
        
        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
        }
    }
}

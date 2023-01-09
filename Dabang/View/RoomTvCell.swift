//
//  RoomTvCell.swift
//  Dabang
//
//  Created by seonggon on 2023/01/06.
//

import UIKit

/// 방 목록 테이블뷰 셀
final class RoomTvCell: UITableViewCell {
    
    /// 컨텐츠 스택뷰
    @IBOutlet weak private var stackContents: UIStackView!
    
    ///레이블들 스택뷰
    @IBOutlet weak private var stackLbls: UIStackView!
    /// 제목 레이블
    @IBOutlet weak private var lblTitle: UILabel!
    /// 방 종류 레이블
    @IBOutlet weak private var lblRoomType: UILabel!
    /// 정보 레이블
    @IBOutlet weak private var lblDescription: UILabel!
    /// 해시태그 버튼 배열
    @IBOutlet private var btnsHashtag: [UIButton]!
    
    ///이미지들 뷰
    @IBOutlet weak private var viewImgs: UIView!
    /// 썸네일 이미지뷰
    @IBOutlet weak private var ivThumbnail: UIImageView!
    /// 별 이미지뷰 좌
    @IBOutlet weak private var ivStarLeft: UIImageView!
    /// 별 이미지뷰 우
    @IBOutlet weak private var ivStarRight: UIImageView!
    
    /// 평균가 스택뷰
    @IBOutlet weak private var stackAverage: UIStackView!
    /// 평균가 지역 이름
    @IBOutlet weak private var lblAverageName: UILabel!
    /// 평균월세
    @IBOutlet weak private var lblMonthPrice: UILabel!
    /// 평균전세
    @IBOutlet weak private var lblYearPrice: UILabel!
    
    /// 설정
    /// - Parameters:
    ///   - roomData: 방 정보
    ///   - averageData: 평균가 정보
    func configure(roomData: Room, averageData: Average?) {
        
        guard let roomType = roomData.roomType,
              let sellingType = roomData.sellingType else { return }
        
        let rightImgLayout = roomType == .원룸 || roomType == .투쓰리룸
        
        if stackContents.arrangedSubviews.count > 1 {
            stackContents.insertArrangedSubview(stackLbls, at: rightImgLayout ? 0 : 1)
            stackContents.insertArrangedSubview(viewImgs, at: rightImgLayout ? 1 : 0)
        }
        
        ivStarLeft.isHidden = rightImgLayout
        ivStarRight.isHidden = !rightImgLayout
        
        ivStarLeft.image = roomData.is_check ? #imageLiteral(resourceName: "StarSelect") : #imageLiteral(resourceName: "StarDeselect")
        ivStarRight.image = roomData.is_check ? #imageLiteral(resourceName: "StarSelect") : #imageLiteral(resourceName: "StarDeselect")
        
        ivThumbnail.setKfImg(roomData.img_url)
        
        lblTitle.text = "\(sellingType) \(roomData.price_title)"
        
        lblRoomType.text = "\(roomType)"
        
        lblDescription.text = roomData.desc
        
        btnsHashtag.enumerated().forEach {
            let hashtag = roomData.hash_tags[safe: $0.offset]
            $0.element.isHidden = hashtag == nil
            $0.element.setTitle(hashtag, for: .normal)
        }
        
        stackAverage.isHidden = averageData == nil
        
        if let averageData {
            lblAverageName.text = averageData.name
            lblMonthPrice.text = averageData.monthPrice
            lblYearPrice.text = averageData.yearPrice
        }
    }
}

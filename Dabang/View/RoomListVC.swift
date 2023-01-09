//
//  RoomListVC.swift
//  Dabang
//
//  Created by seonggon on 2023/01/06.
//

import UIKit

/// 방 목록 화면
final class RoomListVC: UIViewController {
    /// 방 목록 테이블뷰
    @IBOutlet weak private var tableView: UITableView!
    /// 뷰모델
    private let viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.outputData = { [weak self] refresh in
            if refresh {
                self?.tableView.setContentOffset(.zero, animated: true)
            }
            self?.tableView.reloadData()
        }
    }
    
    //MARK: - @IBAction
    // 방 종류 버튼 터치 (원룸 0, 투쓰리룸 1, 오피스텔 2, 아파트 3)
    @IBAction private func roomTypeBtnTap(_ sender: SelectButton) {
        guard let roomType = RoomType(rawValue: sender.tag) else { return }
        sender.isSelected = viewModel.inputRoomType(roomType: roomType, isSelected: sender.isSelected)
    }
    
    // 매물 종류 버튼 터치 (월세 0, 전세 1, 매매 2)
    @IBAction private func sellingTypeBtnTap(_ sender: SelectButton) {
        guard let sellingType = SellingType(rawValue: sender.tag) else { return }
        sender.isSelected = viewModel.inputSellingType(sellingType: sellingType, isSelected: sender.isSelected)
    }
    
    // 가격 버튼 터치 (select 오름차순, deselect 내림차순)
    @IBAction private func priceBtnTap(_ sender: SelectButton) {
        sender.isSelected.toggle()
        viewModel.inputPrice(priceType: sender.isSelected ? .오름차순 : .내림차순)
    }
}

//MARK: - UITableViewDataSource
extension RoomListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.rooms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell: RoomTvCell = tableView.dequeueReusableCell(withIdentifier: String(describing: RoomTvCell.self),
                                                                   for: indexPath) as? RoomTvCell else { return UITableViewCell() }
        let idx = indexPath.row
        let roomData = viewModel.rooms[idx]
        let averageData = viewModel.getAverageData(idx: idx)
        cell.configure(roomData: roomData, averageData: averageData)
        
        return cell
    }
}

//MARK: - UITableViewDelegate
extension RoomListVC: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.height
        
        if offsetY > (contentHeight - height) {
            viewModel.inputScrollBottom()
        }
    }
}

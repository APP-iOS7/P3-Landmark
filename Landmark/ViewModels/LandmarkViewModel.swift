//
//  LandmarkListViewModel.swift
//  Landmark
//
//  Created by 최범수 on 2025-02-05.
//

import SwiftUI
import SwiftData

@Observable
class LandmarkViewModel {
//    @Environment(\.modelContext) var modelContext
    
    var landmarks: [Item] = []
    var searchText: String = ""
    var detailLandmark: Item = .init(contentid: "", contenttypeid: "", title: "", createdtime: "", modifiedtime: "", tel: "", telname: "", homepage: "", booktour: "", firstimage: "", firstimage2: "", cpyrhtDivCd: "", areacode: "", sigungucode: "", addr1: "", addr2: "", zipcode: "", mapx: "", mapy: "", mlevel: "", overview: "")
    
    func fetchLandmarks() async {
        do {
            APIManager.shared.keyword = searchText
            landmarks = try await APIManager.shared.fetchSearchData()
        } catch {
            print(error)
        }
    }
    
    func fetchDetailLandmark(id: String) async {
        do {
            detailLandmark = try await APIManager.shared.fetchDetailData(contentId: id)
        } catch {
            print(error)
        }
    }
    
//    func saveLandmark() {
//        let savedLandmark = FavoriteItem(from: detailLandmark)
//        modelContext.insert(savedLandmark)
//        
//        do {
//            try modelContext.save()
//            print("좋아요 저장됨: \(savedLandmark.title)")
//        } catch {
//            print("저장 실패: \(error)")
//        }
//    }
}



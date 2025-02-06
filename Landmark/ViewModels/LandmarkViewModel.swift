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
    
    
}



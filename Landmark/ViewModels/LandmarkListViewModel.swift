//
//  LandmarkListViewModel.swift
//  Landmark
//
//  Created by 최범수 on 2025-02-05.
//

import SwiftUI

@Observable
class LandmarkListViewModel {
    var landmarks: [Item] = []
    var searchText: String = ""
    
    func fetchLandmarks() async {
        do {
            APIManager.shared.keyword = searchText
            landmarks = try await APIManager.shared.fetchSearchData()
        } catch {
            print(error)
        }
    }
}

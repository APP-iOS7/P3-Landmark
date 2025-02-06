//
//  FavoriteDataModel.swift
//  Landmark
//
//  Created by 최범수 on 2025-02-06.
//

import Foundation
import SwiftData

@Model
final class UserDefaults {
    var favoriteLandmarks: [Item] = []
    init() { }
}

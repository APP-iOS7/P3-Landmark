//
//  APIDataModel.swift
//  Landmark
//
//  Created by 최범수 on 2025-02-05.
//

import Foundation
import CoreLocation

struct APIResponse: Codable {
    let response: Response
}

struct Response: Codable {
    let header: ResponseHeader
    let body: ResponseBody
}

struct ResponseHeader: Codable {
    let resultCode: String
    let resultMsg: String
}

struct ResponseBody: Codable {
    let items: Items
    let numOfRows: Int
    let pageNo: Int
    let totalCount: Int
}

struct Items: Codable {
    let item: [Item]
}

struct Item: Codable, Identifiable, Hashable {
    var id: String { contentid }
    let addr1: String
    let addr2: String?
    let areacode: String
    let booktour: String?
    let cat1: String
    let cat2: String
    let cat3: String
    let contentid: String
    let contenttypeid: String
    let createdtime: String
    let firstimage: String?
    let firstimage2: String?
    let cpyrhtDivCd: String?
    let mapx: String
    let mapy: String
    let mlevel: String
    let modifiedtime: String
    let sigungucode: String
    let tel: String?
    let title: String
    var locationCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: Double(mapx) ?? 0,
            longitude: Double(mapy) ?? 0
        )
    }
}

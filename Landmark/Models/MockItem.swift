//
//  MockItem.swift
//  Landmark
//
//  Created by 최범수 on 2025-02-05.
//

import Foundation
import MapKit

struct MockItem {
    static var shared = MockItem()
    
    private init() { }
    
    var mockItem: Item = .init(addr1: "경상남도 창원시 의창구 도계동", addr2: "449", cat1: "A04", cat2: "A0401", cat3: "A04010200", areacode: <#T##String#>, booktour: <#T##String?#>, cat1: <#T##String#>, cat2: <#T##String#>, cat3: <#T##String#>, contentid: <#T##String#>, contenttypeid: <#T##String#>, createdtime: <#T##String#>, firstimage: <#T##String?#>, firstimage2: <#T##String?#>, cpyrhtDivCd: <#T##String?#>, mapx: <#T##String#>, mapy: <#T##String#>, mlevel: <#T##String#>, modifiedtime: <#T##String#>, sigungucode: <#T##String#>, tel: <#T##String?#>, title: <#T##String#>)
    var id: String { contentid }
    var addr1 =
    var addr2: String? =
    var areacode = "36"
    var booktour: String? = nil
    var cat1 = "A04"
    var cat2 = "A0401"
    var cat3 = "A04010200"
    var contentid = "2783898"
    var contenttypeid = "38"
    var createdtime = "20211130234018"
    var firstimage: String? = "http://tong.visitkorea.or.kr/cms/resource/68/2799968_image2_1.JPG"
    var firstimage2: String? = "http://tong.visitkorea.or.kr/cms/resource/68/2799968_image2_1.JPG"
    var cpyrhtDivCd: String? = "Type3"
    var mapx = "128.6374257938"
    var mapy = "35.2576398081"
    var mlevel = "6"
    var modifiedtime = "20250131092423"
    var sigungucode = "16"
    var tel: String? = nil
    var title = "창원 도계부부시장"
    var locationCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: Double(mapx) ?? 0,
            longitude: Double(mapy) ?? 0
        )
    }
}

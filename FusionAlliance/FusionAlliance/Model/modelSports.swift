//
//  List.swift
//  FusionAlliance
//
//  Created by Consultant on 8/8/22.
//

import Foundation

struct listSports: Codable,Hashable {
    let key, group, title, sportDescription: String
   

    enum CodingKeys: String, CodingKey {
        case key, group, title
        case sportDescription = "description"
    }
}

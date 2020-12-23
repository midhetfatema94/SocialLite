//
//  Friend.swift
//  SocialLite
//
//  Created by Waveline Media on 12/23/20.
//

import Foundation

class Friend: ObservableObject, Codable {
    
    enum CodingKeys: CodingKey {
        case id, name
    }

    @Published var id: String = ""
    @Published var name: String = ""
    
    init() {
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
    }
}

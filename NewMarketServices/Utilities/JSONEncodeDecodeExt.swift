//
//  JSONEncodeDecodeExt.swift
//  CitiControls
//
//  Created by rampal verma on 09/01/18.
//  Copyright © 2018 Citgroup Inc. All rights reserved.
//

import Foundation
extension Encodable {
    func encode() throws -> Data {
        let encoderObj = JSONEncoder()
        encoderObj.outputFormatting = .prettyPrinted
        return try encoderObj.encode(self)
    }
    
    func asDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            throw NSError()
        }
        return dictionary
    }
}
extension Decodable {
    static func decode(data: Data) throws -> Self {
        return try JSONDecoder().decode(Self.self, from: data)
    }
}



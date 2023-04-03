//
//  formatter.swift
//  50.ObjectMapperDemo
//
//  Created by jackfrow on 2023/2/24.
//

import Foundation
import ObjectMapper


extension Mapper{
    
    func map(JSON data: Data) -> N? {
        
        if let string = String(data: data, encoding: .utf8) {
            return map(JSONString: string)
        }
        return nil
    }
}

extension Mappable {

    func toJSONData() -> Data? {
        return toJSONString()?.data(using: .utf8)
    }
}


struct StringTransform: TransformType {

  func transformFromJSON(_ value: Any?) -> String? {
    return value.flatMap(String.init(describing:))
  }

  func transformToJSON(_ value: String?) -> Any? {
    return value
  }

}

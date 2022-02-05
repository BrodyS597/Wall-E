//
//  Camera.swift
//  Wall-E
//
//  Created by Brody Sears on 2/5/22.
//

import Foundation

//uWzZH8DoQu36mo581gdaDeQhljm6np81ekLyIRi9
// nasa api

enum Keys: String {
    case name = "full_name"
}

class Camera {
    let cameraName: String
    
    init?(dictionary: [String: Any]) {
        guard let name = dictionary[Keys.name.rawValue] as? String else { return nil }
        
        self.cameraName = name
    }
}

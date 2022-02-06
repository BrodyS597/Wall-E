//
//  Photo.swift
//  Wall-E
//
//  Created by Brody Sears on 2/5/22.
//

import Foundation

enum PhotoKeys: String {
    case photoURL = "img_src"
    case camera = "camera"
}

class Photo {
    let photoURL: String
    let camera: Camera
    
    init?(dictionary: [String: Any]) {
        guard let photoURL = dictionary[PhotoKeys.photoURL.rawValue] as? String,
              let cameraDict = dictionary[PhotoKeys.camera.rawValue] as? [String: Any],
              let camera = Camera(dictionary: cameraDict) else { return nil }
        
        self.photoURL = photoURL
        self.camera = camera
    }
}

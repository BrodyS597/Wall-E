//
//  PhotoTableViewCell.swift
//  Wall-E
//
//  Created by Brody Sears on 2/5/22.
//

import UIKit

class PhotoTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var cameraNameLabel: UILabel!
    @IBOutlet weak var roverImageView: UIImageView!
    
    func updateViews(photo: Photo) {
        cameraNameLabel.text = photo.camera.cameraName
        NetworkController.fetchImage(from: photo.photoURL) { roverImage in
            
            DispatchQueue.main.async {
                self.roverImageView.image = roverImage
                
            }
        }
    }
}

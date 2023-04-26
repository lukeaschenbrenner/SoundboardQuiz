//
//  ImageCollectionViewCell.swift
//  SoundboardQuiz
//
//  Created by Luke A Aschenbrenner on 4/24/23.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    public static let REUSE_IDENTIFIER = "imagePanel";
    
    @IBOutlet var label: UILabel!
    private var secretName: String?
    
    public var isMatched = false
    
    public var name: String? {
        get{
            return secretName
        }
        set{
            secretName = newValue
            label.text = secretName
        }
    }
    
    private var secretImageFile: UIImage?
    
    public var imageFile: UIImage? {
        get{
            return secretImageFile
        }
        set{
            secretImageFile = newValue
        }
    }
    
}

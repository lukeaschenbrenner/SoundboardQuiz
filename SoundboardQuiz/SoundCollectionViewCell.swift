//
//  SoundCollectionViewCell.swift
//  SoundboardQuiz
//
//  Created by Luke A Aschenbrenner on 4/24/23.
//

import UIKit

class SoundCollectionViewCell: UICollectionViewCell {
    public static let REUSE_IDENTIFIER = "soundPanel"
    
    @IBOutlet var label: UILabel!
    
    public var canMove = true
    
    private var secretName: String?
    
    public var name: String? {
        get{
            return secretName
        }
        set{
            secretName = newValue
            label.text = secretName
        }
    }
    
    private var secretSoundFile: URL?
    
    public var imageFile: URL? {
        get{
            return secretSoundFile
        }
        set{
            secretSoundFile = newValue
        }
    }
    
}

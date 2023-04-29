//
//  SoundCollectionViewCell.swift
//  SoundboardQuiz
//
//  Created by Luke A Aschenbrenner on 4/24/23.
//

import UIKit

class SoundCollectionViewCell: UICollectionViewCell {
    public static let REUSE_IDENTIFIER = "soundPanel"
    private static var lastNum = 0
    
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
    
    public var soundFile: URL? {
        get{
            return secretSoundFile
        }
        set{
            secretSoundFile = newValue
        }
    }
    override func prepareForReuse() {
        secretName = nil
        name = nil
        soundFile = nil
        secretSoundFile = nil
        backgroundColor = .systemGreen
    }
    
//    public var cellID: Int = {
//        return lastNum
//    }()
    
    
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        SoundCollectionViewCell.lastNum = ((SoundCollectionViewCell.lastNum + 1) % Int.max)
//    }
   // override func layoutSubviews() {
   //    super.layoutSubviews()
   //     contentView.frame = contentView.frame.inset(by:  UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0))
   //     }
}

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
    
    @IBOutlet var playButtonImage: UIImageView!
    
    @IBOutlet var label: UILabel!
    
    public var canMove = true
    public var isPlaying = false
    
    private var secretCellPlaysLeft = 3
    public var cellPlaysLeft: Int {
        get {
            return secretCellPlaysLeft
        } set {
            secretCellPlaysLeft = newValue
            label.text = "\(secretCellPlaysLeft)"
        }
    }
    
    private var secretName: String?
    
    public var name: String? {
        get{
            return secretName
        }
        set{
            secretName = newValue
            //label.text = secretName
        }
    }
    
    private var secretSoundFile: String?
    
    public var soundFile: String? {
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
        secretCellPlaysLeft = 3
        playButtonImage.image = UIImage(systemName: "play.fill")
        isPlaying = false
        backgroundColor = .systemGreen
    }
    public func decrementPlayCount(){
        if(secretCellPlaysLeft > 0){
            secretCellPlaysLeft -= 1
            if(secretCellPlaysLeft == 0){
                backgroundColor = .systemGray
            }
            label.text = "\(secretCellPlaysLeft)"
        }
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

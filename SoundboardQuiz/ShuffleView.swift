//
//  ShuffleView.swift
//  SoundboardQuiz
//
//  Created by Luke A Aschenbrenner on 4/27/23.
//

import UIKit

class ShuffleView: UIView {

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.accessibilityTraits = UIAccessibilityTraits.button
        self.accessibilityLabel = "Shuffle"
        self.accessibilityValue = "\(secretNumShufflesLeft) Shuffles Left"
    }
    private var secretNumShufflesLeft = 0
    public var numShufflesLeft: Int {
        set{
            secretNumShufflesLeft = newValue
            self.accessibilityValue = "\(secretNumShufflesLeft) Shuffles Left"
        }
        get{
            return secretNumShufflesLeft
        }
    
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
//    func  addTapGesture(action : @escaping ()->Void ){
//        self.gestureRecognizers?.forEach({ (gr) in
//            self.removeGestureRecognizer(gr)
//        })
//        let tap = MyTapGestureRecognizer(target: self , action: #selector(self.handleTap(_:)))
//        tap.action = action
//        tap.numberOfTapsRequired = 1
//
//        self.addGestureRecognizer(tap)
//        self.isUserInteractionEnabled = true
//
//    }

}


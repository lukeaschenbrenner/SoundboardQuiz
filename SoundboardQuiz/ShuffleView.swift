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

        //TODO: Add voiceover support for shuffle button number of shuffles left and fix green sound buttons to read out the number of plays left from their accessible sub-labels
        // TODO: Announce to accessibility users before the sound starts playing that there are X plays left (even if there are 0!)
        
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


//
//  SecondGameViewController.swift
//  SoundboardQuiz
//
//  Created by Luke A Aschenbrenner on 4/21/23.
//

import UIKit

class SecondGameViewController: UIViewController {
    private var isDragging = false
    
    private let myView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        view.backgroundColor = .link
        view.isUserInteractionEnabled = true;
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        myView.center = view.center
    }
    
    var oldX: CGFloat = 0;
    var oldY: CGFloat = 0;
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: - Touches

extension SecondGameViewController{
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        let location = touch.location(in: myView)
        
        oldX = location.x
        oldY = location.y
        if myView.bounds.contains(location){
           // print("did touch in blue view")
            isDragging = true;
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard isDragging else{
            return;
        }//only continues if they are dragging right now, similar to an assert
        guard let touch = touches.first else{
            return
        }
        //NOTE: use oldX and oldY to avoid view clipping directly to center
        let location = touch.location(in: view) //get the location in the larger container view
        myView.frame.origin.x = location.x - (myView.frame.size.width / 2)
        myView.frame.origin.y = location.y - (myView.frame.size.height / 2)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        isDragging = false
    }
}

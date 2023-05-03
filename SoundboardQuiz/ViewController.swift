//
//  ViewController.swift
//  SoundboardQuiz
//
//  Created by Luke A Aschenbrenner on 2/28/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    //performSegue(withIdentifier: "segueGameOver", sender: self)
//    @IBAction func resumePressed(_ sender: Any) {
//        if self.shouldPerformSegue(withIdentifier: <#T##String#>, sender: <#T##Any?#>){}
//        self.performSegue(withIdentifier: "segueDirectlyToGame", sender: self)
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? MainGameViewController{
            if(UserDefaults.standard.data(forKey: "lastState") != nil){
                print("NOW RESUMING MAIN GAME")
                vc.isResuming = true
            }

//            if let categoryName, let sounds{
//                vc.setInfo(categoryName: categoryName, sounds: (sounds as NSSet), score: score)
//            }
        }
    }
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if(identifier == "directGameViewSegue"){
            if(UserDefaults.standard.data(forKey: "lastState") != nil){
                print("NOW RESUMING MAIN GAME")
                return true
            }else{
                let uialert = UIAlertController(title: "No Resumable Session", message: "Sorry, there is no game to resume at this time.", preferredStyle: UIAlertController.Style.alert)
                   uialert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
                self.present(uialert, animated: true, completion: nil)
                return false
            }
        }
        return true
    }
}


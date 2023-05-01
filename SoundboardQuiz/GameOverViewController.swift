//
//  GameOverViewController.swift
//  SoundboardQuiz
//
//  Created by Luke A Aschenbrenner on 4/27/23.
//

import UIKit

class GameOverViewController: UIViewController {
    
    @IBOutlet var scoreLabel: UILabel!
    var categoryName: String?
    var sounds: NSSet?
    var score: Int?

    func setInfo(categoryName: String, sounds: NSSet, score: Int){
        self.categoryName = categoryName
        self.sounds = sounds
        self.score = score
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        if let score {
            scoreLabel.text = "Score: \(score)"
            //TODO: ADD SCORE TO HIGH SCORES LIST
        }else{
            print("ERROR")
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func newGamePressed(_ sender: Any) {
        navigationController?.viewControllers.removeAll(where: { (vc) -> Bool in
            if vc.isKind(of: ViewController.self) || vc.isKind(of: UINavigationController.self) || vc.isKind(of: GameOverViewController.self) {
                print("false: \(vc)")
                return false
            } else {
                print("true: \(vc)")
                return true
            }
        })
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let newViewController = storyboard.instantiateViewController(identifier: "MainGameScreen") as! MainGameViewController
        newViewController.setCategoryInfo(catName: categoryName!, sounds: sounds!)
        newViewController.populateSounds()
        //newViewController.shuffle(itemCount: 4)

        
        guard var viewControllers = navigationController?.viewControllers else{
            print("Unable to find navigation controller! Check storyboard")
            return
        }
        viewControllers[(viewControllers.count) - 1] = newViewController
        self.navigationController?.setViewControllers(viewControllers, animated: true)
    }
    
    @IBAction func mainMenuPressed(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

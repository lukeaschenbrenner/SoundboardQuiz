//
//  GameOverViewController.swift
//  SoundboardQuiz
//
//  Created by Luke A Aschenbrenner on 4/27/23.
//

import UIKit
import Foundation

public struct MyTuple: Codable {
    var categoryName: String
    var score: Int
}

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
        if let score, let categoryName {
            scoreLabel.text = "Score: \(score)"
            let defaults = UserDefaults.standard
            let fetchedData = UserDefaults.standard.data(forKey: "highScores")
     //       var highScoresArr: Array<MyTuple>? = defaults.array(forKey: "highScores") as? Array<MyTuple>

            var highScoresArr = try? PropertyListDecoder().decode([MyTuple].self, from: fetchedData ?? Data())
            
            if(highScoresArr == nil){
                defaults.set(NSArray(), forKey: "highScores")
                highScoresArr = defaults.array(forKey: "highScores") as? Array<MyTuple>
            }
            if let highScoresArr{
                if(score > 0) {
                    print("High Score Array Successfully Obtained.")
                    if(!highScoresArr.allSatisfy({predicate in
                        if(predicate.score > score){
                            return true
                        }else{
                            return false
                        }
                    }) || highScoresArr.count <= 0){
                        print("The score is greater than at least one previous high score. Creating new array")
                        /*
                         let bookiesData = try! PropertyListEncoder().encode(bookies)
                         UserDefaults.standard.set(bookiesData, forKey: "bookies")

                         let fetchedData = UserDefaults.standard.data(forKey: "bookies")!
                         let fetchedBookies = try! PropertyListDecoder().decode([Bookie].self, from: fetchedData)
                         print(fetchedBookies)
                         */
                        let newElement: MyTuple = MyTuple(categoryName: categoryName, score: score)
                   //     newElement = try! PropertyListEncoder().encode(arrSorted)
                        var arrSorted = (highScoresArr) + [newElement] //[(categoryName as NSString, score as NSNumber)]
                        
                        arrSorted = Array(arrSorted.sorted(by: {t1, t2 in
                            let int1: Int = t1.score
                            let int2: Int = t2.score
                            return int1 >= int2
                        })[0..<min(5, arrSorted.endIndex)])
                        
                        print("New sorted array: \(arrSorted)")
                        let arrayEncoded = try! PropertyListEncoder().encode(arrSorted)

                        defaults.set(arrayEncoded, forKey: "highScores")
                        
                        
                        
                    }
                }
            }else{
                print("Error: cannot add to high scores")
            }
            
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

//
//  HighScoresViewController.swift
//  SoundboardQuiz
//
//  Created by Luke A Aschenbrenner on 5/2/23.
//

import UIKit

class HighScoresViewController: UIViewController {

    @IBOutlet weak var score1: UILabel!
    @IBOutlet weak var score2: UILabel!
    @IBOutlet weak var score3: UILabel!
    @IBOutlet weak var score4: UILabel!
    @IBOutlet weak var score5: UILabel!
    private var scoreArray: [UILabel]?
    //private var tupleArray: [(String, String)] = []
    
    override func viewDidLoad() {
        scoreArray = [score1, score2, score3, score4, score5]
        super.viewDidLoad()
        print("Entered High Scores View Controller")
      //  let defaults = UserDefaults.standard
        //let highScoresArr: Array<(String, Int)>? = defaults.array(forKey: "highScores") as? Array<(String, Int)>
        let fetchedData = UserDefaults.standard.data(forKey: "highScores")!
        let highScoresArr = try? PropertyListDecoder().decode([MyTuple].self, from: fetchedData)
//        highScoresDict?.forEach({
//
//            let (gameType, score) = $0
//            let scoreString = score as! Int
//            tupleArray.append((gameType, scoreString))
//
//        })
        if let scoreArray, let highScoresArr{
            var i = 0
            for myTuple in highScoresArr[0..<min(5, highScoresArr.endIndex)]{
                scoreArray[i].text? = "\(myTuple.score) (\(myTuple.categoryName))"
                i += 1
            }
            if(i < scoreArray.count){
                while(i < scoreArray.count){
                    scoreArray[i].text? = "N/A"
                    i += 1
                }
            }
        }else{
            var i = 1
            for label in scoreArray!{
                label.text = "N/A"
                i += 1
            }
        }
        


        // Do any additional setup after loading the view.
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

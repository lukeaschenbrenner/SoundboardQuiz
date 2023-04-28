//
//  MainGameViewController.swift
//  SoundboardQuiz
//
//  Created by Luke A Aschenbrenner on 4/24/23.
//

import UIKit

class MainGameViewController: UIViewController {
    //    @IBOutlet var titleBar: UINavigationItem!
    
    private var embeddedViewController1: SquareCollectionViewController!
    private var embeddedViewController2: SquareCollectionViewController!
    
    @IBOutlet var scoreLabel: UILabel!


    @IBOutlet var containerView1: UIView!
    @IBOutlet var containerView2: UIView!
    var score = 0
    var categoryName: String?
    var sounds: Set<Sound>?
    var subSounds: [Sound]?
    //try sounds = (self.parent as! MainGameViewController).subSounds?.sorted(by: {(firstSound, secondSound) throws -> Bool in return firstSound.name ?? "" > secondSound.name ?? ""})
    func setCategoryInfo(catName: String, sounds: NSSet) -> () {
        categoryName = catName
        self.sounds = sounds as? Set<Sound>
    }
    
    func shuffle(itemCount: Int){

        
        if let sub = sounds?.shuffled() {
            var slice = Array(sub[0..<min(itemCount, sub.endIndex)])
            while (slice.count < itemCount) {
                slice.append(sub.randomElement()!)
            }
            print("size of slice: \(slice.count)")
            subSounds = slice
        }else{
            print("error")
            return
        }
        subSounds = subSounds?.shuffled()
        
        embeddedViewController1.shuffle()
        embeddedViewController2.shuffle()


    }
    @IBAction func doAnimateNewItems(_ sender: Any) {
        
        shuffle(itemCount: 8)
        embeddedViewController1.reload()
        embeddedViewController2.reload()

        if var subSounds {
            subSounds = Array(subSounds[4..<min(8, subSounds.endIndex)])
            //TODO: FIX FILLER FUNCTION

            self.subSounds = subSounds
            print("subsounds shrunk")
        }else{
            print("ERROR: subsounds not shrunk")
        }
        // do animate here
        embeddedViewController1.disableUserInteractionAndAnimate()
        embeddedViewController2.disableUserInteractionAndAnimate()
        
        
    }
    func populateSounds() {
        if let sub = sounds?.shuffled(){
            print("about to slice!")
            //.prefix(upTo:4)
            let slice = sub[0..<min(4, sub.endIndex)]
            subSounds = Array(slice)
            print("subsounds has been set")
        }else{
            print("ERROR: subsounds not populated")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = categoryName
        scoreLabel.text = "Score: \(score)"
        //do{
            //try subSounds = sounds?.sorted(by: {(firstSound, secondSound) throws -> Bool in return firstSound.name ?? "" > secondSound.name ?? ""})


       // }
       // catch{ print(error.localizedDescription)}

        // Do any additional setup after loading the view.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? SquareCollectionViewController,
                    segue.identifier == "soundViewSegue" {
            self.embeddedViewController1 = vc
        }else if let vc = segue.destination as? SquareCollectionViewController, segue.identifier == "imageViewSegue" {
            self.embeddedViewController2 = vc
        }else if let vc = segue.destination as? GameOverViewController{
            print("NOW ENTERING GAME OVER!")
            if let categoryName, let sounds{
                vc.setInfo(categoryName: categoryName, sounds: (sounds as NSSet), score: score)
            }
        }
    }

    @IBOutlet var shuffleView: ShuffleView!
    
    func stopDragAndGreyOutSoundCell(name: String){
        score = score + 1;
        scoreLabel.text = "Score: \(score)"
        let didSucceed = embeddedViewController1.correctCell(name: name)
        print("did succeed? \(didSucceed)")
    }
    
    @IBAction func shuffleTapped(_ sender: Any) {
        shuffle(itemCount: 4)
        
        embeddedViewController1.shuffle()
        embeddedViewController2.shuffle()
        
        embeddedViewController1.reload()
        embeddedViewController2.reload()

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

protocol ClickableCell {
    func correctCell(name: String) -> Bool
    //DO STUFF HERE TO GREY OUT CELL ETC.

}

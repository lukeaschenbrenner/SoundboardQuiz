//
//  MainGameViewController.swift
//  SoundboardQuiz
//
//  Created by Luke A Aschenbrenner on 4/24/23.
//

import UIKit

class MainGameViewController: UIViewController {
    //    @IBOutlet var titleBar: UINavigationItem!
    private static var currentInstance: MainGameViewController?
    private var embeddedViewController1: SquareCollectionViewController!
    private var embeddedViewController2: SquareCollectionViewController!
    
    @IBOutlet var scoreLabel: UILabel!
    
    public var isResuming: Bool = false
    //private var secretIsResuming: Bool = false
    
    @IBOutlet var containerView1: UIView!
    @IBOutlet var containerView2: UIView!
    var score = 0
    var categoryName: String?
    var sounds: Set<Sound>?
    var subSounds: [Sound]?
    var didGameOver = false
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
        
        
        
    }
    func addSoundItems(_ numItems: Int){
        
        //        for aSound in subSounds!{
        //            print(aSound.name!, terminator: ", ")
        //        }
        //        print()
        
        if let sub = sounds?.shuffled() {
            var slice = Array(sub[0..<min(numItems, sub.endIndex)])
            while (slice.count < numItems) {
                slice.append(sub.randomElement()!)
            }
            subSounds?.append(contentsOf: Array(slice))
        }else{
            print("error")
            return
        }
        
        embeddedViewController1.reloadFromParentController()
        embeddedViewController2.reloadFromParentController()
    }
    //    @IBAction func doAnimateNewItems(_ sender: Any) {
    //
    //        //shuffle(itemCount: 8)
    //        addSoundItems(4)
    //
    //        if var subSounds {
    //            subSounds = Array(subSounds[4..<min(8, subSounds.endIndex)])
    //            self.subSounds = subSounds
    //            print("subsounds shrunk")
    //        }else{
    //            print("ERROR: subsounds not shrunk")
    //        }
    //        // do animate here
    //        embeddedViewController1.disableUserInteractionAndAnimate()
    //        embeddedViewController2.disableUserInteractionAndAnimate()
    //
    //
    //    }
    
    func animate() {
        
        //shuffle(itemCount: 8)
        addSoundItems(4)
        
        if var subSounds {
            subSounds = Array(subSounds[4..<min(8, subSounds.endIndex)])
            self.subSounds = subSounds
            print("subsounds shrunk")
        }else{
            print("ERROR: subsounds not shrunk")
        }
        
        // do animate here
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.embeddedViewController1.disableUserInteractionAndAnimate()
            self.embeddedViewController2.disableUserInteractionAndAnimate()
            
        }
        
        
        
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
    
    @IBOutlet var numShufflesLeftLabel: UILabel!
    public var numShufflesLeft = 5
    override func loadView() {
        print("HELLO???????")
        if(isResuming){
            try! self.restoreState()
            isResuming = false
        }
        super.loadView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        MainGameViewController.currentInstance = self
        self.title = categoryName
        scoreLabel.text = "Score: \(score)"
        numShufflesLeftLabel.text = "(\(numShufflesLeft > 0 ? numShufflesLeft : 0) Left)"
        shuffleView.numShufflesLeft = self.numShufflesLeft
        
        //do{
        //try subSounds = sounds?.sorted(by: {(firstSound, secondSound) throws -> Bool in return firstSound.name ?? "" > secondSound.name ?? ""})
        
        
        // }
        // catch{ print(error.localizedDescription)}
        
        // Do any additional setup after loading the view.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        shuffle(itemCount: 4)
        
        if let vc = segue.destination as? SquareCollectionViewController,
           segue.identifier == "soundViewSegue" {
            self.embeddedViewController1 = vc
        }else if let vc = segue.destination as? SquareCollectionViewController, segue.identifier == "imageViewSegue" {
            self.embeddedViewController2 = vc
        }else if let vc = segue.destination as? GameOverViewController{
            print("NOW ENTERING GAME OVER!")
            didGameOver = true
            self.embeddedViewController1.stopSound(forName: nil)
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
        embeddedViewController1.stopSound(forName: name)
        if(score > 0 && score % 4 == 0){
            animate()
            
        }
    }
    
    @IBAction func shuffleTapped(_ sender: Any) {
        
        if(numShufflesLeft > 0){
            embeddedViewController1.stopSound(forName: nil)
            
            shuffle(itemCount: 4)
            numShufflesLeft -= 1
            
            embeddedViewController1.reloadFromParentController()
            embeddedViewController2.reloadFromParentController()
            
            embeddedViewController1.reload()
            embeddedViewController2.reload()
            
            numShufflesLeftLabel.text = "(\(numShufflesLeft > 0 ? numShufflesLeft : 0) Left)"
        }
        if(numShufflesLeft == 0){
            numShufflesLeft -= 1
            shuffleView.backgroundColor = UIColor.systemGray
        }
        shuffleView.numShufflesLeft = self.numShufflesLeft

    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    public static func attemptSaveState() throws {
        print("ATTEMPTING TO SAVE STATE!")
        if let currentInstance{
            if(currentInstance.didGameOver){
                print("Garbage collector didn't pick this up yet, not saving state")
                return
            }
            print("INSTANCE FOUND!")
            let possibleData = currentInstance.saveState()
            let defaults = UserDefaults.standard
            do{
                let encodedState = try PropertyListEncoder().encode(possibleData)
                defaults.set(encodedState, forKey: "lastState")
                print("STATE SAVED!")
            }
            catch{
                print(String(describing: error))
            }

            //save the data
            
        }else{
            throw CocoaError(.coderInvalidValue)
        }
    }
    private func saveState() -> MainGameData {
        var data = MainGameData()
        data.score = self.score
        data.categoryName = self.categoryName
        data.sounds = self.sounds
        data.subSounds = self.subSounds
        return data
    }
    
    private func restoreState() throws {
    //    @UIKit.Environment(\.managedObjectContext) var moc
        
        print("RESTORING STATE!")
        let fetchedData = UserDefaults.standard.data(forKey: "lastState")
        if let fetchedData{
            let decoder = PropertyListDecoder()
            decoder.userInfo[CodingUserInfoKey.managedObjectContext] = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let mainGameData = try? decoder.decode(MainGameData.self, from: fetchedData)
            if(mainGameData == nil){
                print("ERROR: MainGameData is nil!")
//                throw fatalError("MainGameData was nil, we should have never allowed to resume to happen.")
            }
//            self.score = mainGameData.score
//            self.categoryName = mainGameData.categoryName
//            self.sounds = mainGameData.sounds
//            self.subSounds = mainGameData.subSounds
            
             self.score = mainGameData?.score ?? 0
             self.categoryName = mainGameData?.categoryName
             self.sounds = mainGameData?.sounds
             self.subSounds = mainGameData?.subSounds
             
        }
    }

}

protocol ClickableCell {
    func correctCell(name: String) -> Bool
    //DO STUFF HERE TO GREY OUT CELL ETC.

}

struct MainGameData: Codable{
    var score: Int = 0
    var categoryName: String?
    var sounds: Set<Sound>?
    var subSounds: [Sound]?
    
//    enum CodingKeys: String, CodingKey {
//        case score
//        case categoryName
//        case sounds
//        case subSounds
//    }
}
//extension MainGameData: Encodable {
//  func encode(to encoder: Encoder) throws {
//    var container = encoder.container(keyedBy: CodingKeys.self)
//    try container.encode(score, forKey: .score)
//    try container.encode(categoryName, forKey: .categoryName)
//    try container.encode(movieDetails.language, forKey: .language)
//    try container.encode(movieDetails.genre, forKey: .genre)
//    try container.encode(movieDetails.releaseDate, forKey: .releaseDate)
//    try container.encode(movieDetails.bannerImageUrl, forKey:  .bannerUrl)
//  }
//}
//extension MainGameData: Decodable {
//  init(from decoder: Decoder) throws {
//
//     var container = try decoder.container(keyedBy: CodingKeys.self)
//     movieId = try container.decode(Int.self, forKey: .movieId)
//
//     name = try container.decode(String.self, forKey: .name)
//     let language = try container.decode(String.self, forKey: .language)
//     let genre = try container.decode(String.self, forKey: .genre)
//     let releaseDate = try container.decode(String.self, forKey: .releaseDate)
//     let bannerUrl = try container.decode(String.self, forKey: .bannerUrl)
//     movieDetails =  MovieDetail(language: language, genre: genre, releaseDate: releaseDate, bannerImageUrl: bannerUrl)
//    }
//}

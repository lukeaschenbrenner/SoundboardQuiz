//
//  SoundCollectionView.swift
//  SoundboardQuiz
//
//  Created by Luke A Aschenbrenner on 4/24/23.
//

import UIKit
import AVFAudio
import AVFoundation

class SoundCollectionView: UICollectionView, AVAudioPlayerDelegate {
    var player: AVAudioPlayer?
    
    @IBOutlet var label: UILabel!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    private var mostRecentCell: SoundCollectionViewCell?
    
    func stopSound(cell: SoundCollectionViewCell?){
        
        if let player{
            player.stop()
        }
        if let cell{
            mostRecentCell = cell
            cell.playButtonImage.image = UIImage(systemName: "play.fill")
        }
    }
    
    func playSound(for name: String, cell: SoundCollectionViewCell) {
        if let mostRecentCell {
            if(mostRecentCell.isPlaying){
                mostRecentCell.isPlaying = false
                stopSound(cell: mostRecentCell)
            }
            mostRecentCell.playButtonImage.image = UIImage(systemName: "play.fill")

        }
        mostRecentCell = cell
        if(cell.cellPlaysLeft <= 0){
            return
        }
        guard let path = Bundle.main.path(forResource: name, ofType: nil) else {
            print("Invalid sound path, cannot create sound. Name: \(name)")
            player?.stop()
            return;
            
        }
        let url = URL(fileURLWithPath: path)

        do {
            cell.playButtonImage.image = UIImage(systemName: "stop.fill")
            player = try AVAudioPlayer(contentsOf: url)
//            if(player?.url == nil){
//                return;
//            }
//            if FileManager.default.fileExists(atPath: player?.url?.path ?? "") {
//                print("FILE AVAILABLE")
//            } else {
//                print("FILE NOT AVAILABLE")
//                return
//            }
            player?.delegate = self
            player?.volume = 0.5
            player?.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }

}
extension SoundCollectionView{
    func audioPlayerDidFinishPlaying(
        _ player: AVAudioPlayer,
        successfully flag: Bool
    ){
        mostRecentCell?.playButtonImage.image = UIImage(systemName: "play.fill")
        mostRecentCell?.isPlaying = false

    }
}

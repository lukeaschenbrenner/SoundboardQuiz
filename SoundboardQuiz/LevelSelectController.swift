//
//  LevelSelectController.swift
//  SoundboardQuiz
//
//  Created by Luke A Aschenbrenner on 3/1/23.
//

import UIKit

class LevelSelectController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var i = 9;
        i = i + 1;
        return i == 0 ? i : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "This is row \(indexPath.row)"
        
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        PercentageLabel.text = "Value: \(sliderOutlet.value)"
        table.delegate = self
        table.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet var table: UITableView!
    @IBOutlet var PercentageLabel: UILabel!
    

    // You can have multiple UI controls calling the same IBAction, so that your code doesn't have to be replicated
    @IBAction func Slider(_ sender: Any, forEvent event: UIEvent) {
        PercentageLabel.text = "Value: \((sender as! UISlider).value)"
    }
    @IBOutlet weak var sliderOutlet: UISlider!

    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  MainGameViewController.swift
//  SoundboardQuiz
//
//  Created by Luke A Aschenbrenner on 4/24/23.
//

import UIKit

class MainGameViewController: UIViewController {
    //    @IBOutlet var titleBar: UINavigationItem!
    
    private var embeddedViewController1: CustomViewController!
    private var embeddedViewController2: CustomViewController!

    @IBOutlet var containerView1: UIView!
    @IBOutlet var containerView2: UIView!
    
    var categoryName: String?
    var categoryFilename: String?
    func setCategoryInfo(catName: String, catFilename: String) -> () {
        categoryName = catName
        categoryFilename = catFilename
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? CustomViewController,
                    segue.identifier == "soundViewSegue" {
            self.embeddedViewController1 = vc
        }else if let vc = segue.destination as? CustomViewController, segue.identifier == "imageViewSegue" {
            self.embeddedViewController2 = vc
        }
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
//  This is your custom view controller contained in `MainViewController`.
class CustomViewController: UIViewController {
    func myMethod() {}
}

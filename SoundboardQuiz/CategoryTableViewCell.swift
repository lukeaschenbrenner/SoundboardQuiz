//
//  CategoryTableViewCell.swift
//  SoundboardQuiz
//
//  Created by Luke A Aschenbrenner on 4/13/23.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
    
    public static let RESUSE_IDENTIFIER = "category"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    //@IBOutlet weak var categoryLabel2: UILabel!
    
    @IBOutlet weak var categoryLabel: UILabel? //{
//        didSet {
//            if categoryLabel == nil {
//                print("Label set to nil!")
//                // ^ SET A BREAKPOINT IN THIS LINE
//            }
//        }
//    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

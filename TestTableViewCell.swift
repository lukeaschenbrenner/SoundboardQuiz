//
//  TestTableViewCell.swift
//  SoundboardQuiz
//
//  Created by Luke A Aschenbrenner on 4/24/23.
//

import UIKit

class TestTableViewCell: UITableViewCell {
    public static let RESUSE_IDENTIFIER = "category"

    @IBOutlet var catLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

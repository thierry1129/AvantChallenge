//
//  CardTableViewCell.swift
//  Avant
//
//  Created by Shuailin Lyu on 3/5/18.
//  Copyright © 2018 Shuailin Lyu. All rights reserved.
//

import UIKit

class CardTableViewCell: UITableViewCell {


    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

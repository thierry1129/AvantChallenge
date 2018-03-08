//
//  CardDetailTableViewCell.swift
//  Avant
//
//  Created by Shuailin Lyu on 3/5/18.
//  Copyright © 2018 Shuailin Lyu. All rights reserved.
//

import UIKit

class CardDetailTableViewCell: UITableViewCell {


    @IBOutlet weak var transaction: UILabel!
    @IBOutlet weak var Date: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//
//  PostCell.swift
//  flysafe
//
//  Created by Satya Sah on 5/4/19.
//  Copyright © 2019 Satya Sah. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {

    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

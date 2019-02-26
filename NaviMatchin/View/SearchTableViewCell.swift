//
//  SearchTableViewCell.swift
//  NaviMatchin
//
//  Created by Kento Katsumata on 2019/02/26.
//  Copyright © 2019 hiropon. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet var firstName: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

//
//  ElementGoToTopTableViewCell.swift
//  ElementTableViewLoadMoreProgressIndicator
//
//  Created by Ani Adhikary on 01/07/18.
//  Copyright © 2018 Ani Adhikary. All rights reserved.
//

import UIKit

class ElementGoToTopTableViewCell: UITableViewCell {
    
    @IBOutlet weak var elementLabel: UILabel!
    @IBOutlet weak var elementSymbolLabel: UILabel!
    @IBOutlet weak var goToTopButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

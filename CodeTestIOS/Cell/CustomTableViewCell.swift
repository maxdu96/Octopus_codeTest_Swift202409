//
//  CustomTableViewCell.swift
//  CodeTestIOS
//
//  Created by Max DU on 25/9/2024.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var tv_typeBar: UIView!
    @IBOutlet weak var lb_typeBar: UILabel!
    @IBOutlet weak var lb_text: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

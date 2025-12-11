//
//  CustomTableViewswift
//  CodeTestIOS
//
//  Created by Max DU on 25/9/2024.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var tv_typeBar: UIView!
    @IBOutlet weak var lb_typeBar: UILabel!
    @IBOutlet weak var lb_text: UILabel!

    let recommendedText = "Recommended"
    let moreText = "More"

    let helper = Helper.shared

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

    func configure(data: Actions, indexPath: IndexPath) {
        let totalRecommended = data.recommended.count
        let totalMore = data.more.count
        var isPhoneType = false
        var titleText = ""

        if indexPath.row == 0 && totalRecommended > 0 {
            tv_typeBar.isHidden = false
            lb_typeBar.text = recommendedText
            let phoneType = data.recommended[indexPath.row].type
            isPhoneType = getPhoneType(phoneType)
            titleText = data.recommended[indexPath.row].titleEn

        } else if indexPath.row == totalRecommended && totalMore > 0 {
            tv_typeBar.isHidden = false
            lb_typeBar.text = moreText
            let moreIndex = indexPath.row - totalRecommended
            let phoneType = data.more[moreIndex].type
            isPhoneType = getPhoneType(phoneType)
            titleText = data.more[moreIndex].titleEn
        } else {
            tv_typeBar.isHidden = true
            if indexPath.row < totalRecommended {
                let phoneType = data.recommended[indexPath.row].type
                isPhoneType = getPhoneType(phoneType)
                titleText = data.recommended[indexPath.row].titleEn
            } else {
                let moreIndex = indexPath.row - totalRecommended
                let phoneType = data.more[moreIndex].type
                isPhoneType = getPhoneType(phoneType)
                titleText = data.more[moreIndex].titleEn
            }
        }

        if (isPhoneType){
            lb_text.attributedText = helper.splitPhoneString(titleText)
        }else {
            lb_text.text = titleText
        }

    }

    func getPhoneType(_ type: String) -> Bool {
        if type == "phone" {
            return true
        }else {
            return false
        }
    }

}

//
//  cellTableViewCell.swift
//  pathodev1
//
//  Created by erdem öden on 26.07.2021.
//

import UIKit

class cellTableViewCell: UITableViewCell {
//    class SubclassedUIButton: UIButton {
//        var character: String?
//    }
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var actor: UILabel!
    @IBOutlet weak var dateofbirth: UILabel!
    @IBOutlet weak var resim: UIImageView!
    
    @IBOutlet weak var heartbut: SubclassedUIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        resim.layer.cornerRadius = 20
        resim.layer.borderColor = UIColor.black.cgColor
        resim.layer.borderWidth = 5
        resim.layer.backgroundColor = UIColor.black.cgColor
        resim.clipsToBounds = true
    }
}

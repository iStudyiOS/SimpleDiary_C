//
//  CheckListTableViewCell.swift
//  SimpleDiary_C
//
//  Created by 홍경표 on 2021/02/27.
//

import UIKit

class CheckListTableViewCell: UITableViewCell {
    static let identifier = String(describing: CheckListTableViewCell.self)

    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var colorView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

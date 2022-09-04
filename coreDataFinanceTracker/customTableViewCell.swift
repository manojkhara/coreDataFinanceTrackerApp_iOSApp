//
//  customTableViewCell.swift
//  coreDataFinanceTracker
//
//  Created by Manoj 07 on 10/08/22.
//

import UIKit

class customTableViewCell: UITableViewCell {

    static let identifier = "customTableViewCell"
        
    let categoryLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    let amountLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    let infoTypeLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        categoryLabel.frame = CGRect(x: 0, y:0, width: contentView.frame.width - 80, height: contentView.frame.height/2)
        amountLabel.frame = CGRect(x: 0, y:contentView.frame.midY, width: contentView.frame.width - 80, height: contentView.frame.height/2)
        infoTypeLabel.frame = CGRect(x: contentView.frame.width - 80, y:15, width: 80, height: 40)

        contentView.addSubview(categoryLabel)
        contentView.addSubview(amountLabel)
        contentView.addSubview(infoTypeLabel)
        
        
    }
    
    

}

//
//  ItemCell.swift
//  Dreamlister
//
//  Created by Kyle Thompson on 11/19/16.
//  Copyright © 2016 KTinc. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {

    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var details: UILabel!
    @IBOutlet weak var type: UILabel!
    
    func configureCell(item: Item) {
        title.text = item.title
        price.text = "$\(item.price)"
        details.text = item.details
        type.text = item.toItemType?.type
        thumbnail.image = item.toImage?.image as? UIImage
    }
}

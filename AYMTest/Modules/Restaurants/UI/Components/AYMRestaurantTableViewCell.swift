//
//  AYMRestaurantTableViewCell.swift
//  AYMTest
//
//  Created by Norbert Nemes on 2018. 08. 17..
//  Copyright © 2018. Norbert Nemes. All rights reserved.
//

import UIKit
import SDWebImage

class AYMRestaurantTableViewCell: UITableViewCell {

    let thumbnailImageView: UIImageView!
    let nameLabel: UILabel!
    let addressLabel: UILabel!
    let ratingLabel: UILabel!
    
    var restaurant: AYMRestaurant? {
        didSet {
            nameLabel.text = restaurant?.name
            addressLabel.text = restaurant?.address
            ratingLabel.text = String(restaurant?.rating ?? 0.0)
            
            if let imageURL = restaurant?.imageURL {
                thumbnailImageView.sd_setImage(with: imageURL)
            }
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        thumbnailImageView = UIImageView()
        nameLabel = UILabel()
        nameLabel.textAlignment = .left
        nameLabel.textColor = .darkGray
        nameLabel.font = .systemFont(ofSize: 15.0)
        addressLabel = UILabel()
        addressLabel.textAlignment = .left
        addressLabel.textColor = .gray
        addressLabel.font = .systemFont(ofSize: 12.0)
        ratingLabel = UILabel()
        ratingLabel.textColor = .black
        ratingLabel.font = .boldSystemFont(ofSize: 24.0)
        ratingLabel.textAlignment = .center
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(thumbnailImageView)
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(addressLabel)
        self.contentView.addSubview(ratingLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let thumbnailSize: CGFloat = 40.0
        let ratingSize: CGFloat = 40.0
        let padding: CGFloat = 20.0

        
        thumbnailImageView.frame = CGRect(x: padding, y: padding, width: thumbnailSize, height: thumbnailSize)
        nameLabel.frame = CGRect(x: thumbnailImageView.frame.maxX + padding, y: 20.0, width: self.frame.width - thumbnailImageView.frame.maxX - ratingSize - 3.0 * padding, height: 20.0)
        addressLabel.frame = CGRect(x: nameLabel.frame.minX, y: nameLabel.frame.maxY, width: nameLabel.frame.width, height: 20.0)
        ratingLabel.frame = CGRect(x: nameLabel.frame.maxX + padding, y: (self.frame.height - ratingSize) / 2.0, width: ratingSize, height: ratingSize)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

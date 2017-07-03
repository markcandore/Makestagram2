//
//  PostActionCell.swift
//  Makestagram2
//
//  Created by Mark Wang on 7/3/17.
//  Copyright © 2017 Make School. All rights reserved.
//

import UIKit

protocol PostActionCellDelegate: class {
    func didTapLikeButton(_ likeButton: UIButton, on cell: PostActionCell)
}

class PostActionCell: UITableViewCell{
    
    static let height: CGFloat = 46
    
    @IBOutlet weak var likeButton: UIButton!
    
    @IBOutlet weak var likeCountLabel: UILabel!
    
    @IBOutlet weak var timeAgoLabel: UILabel!
    
    weak var delegate: PostActionCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBAction func likeButtonTapped(_ sender: UIButton) {
        delegate?.didTapLikeButton(sender, on: self)
    }
    
}

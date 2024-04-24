//
//  TitleCollectionViewCell.swift
//  Netflix Clone
//
//  Created by Moamen on 07/04/2024.
//

import UIKit
import SDWebImage


class TitleCollectionViewCell: UICollectionViewCell {
    static let identifer = "TitleCollectionViewCell"
    
    let posterImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(posterImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        posterImageView.frame = contentView.bounds
    }
    
    public func Configurate(with model : String){
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model)") else {return}
        posterImageView.sd_setImage(with: url, completed: nil)
    }
}

//
//  FtuxViewCell.swift
//  Siniar
//
//  Created by Bayu Yasaputro on 02/08/22.
//

import UIKit

class FtuxViewCell: UICollectionViewCell {
    weak var imageView: UIImageView!
    weak var titleLabel: UILabel!
    weak var subtitleLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        backgroundColor = .Siniar.brand2
        
        let imageView = UIImageView(frame: .zero)
        contentView.addSubview(imageView)
        self.imageView = imageView
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        let subtitleLabel = UILabel(frame: .zero)
        contentView.addSubview(subtitleLabel)
        self.subtitleLabel = subtitleLabel
        subtitleLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        subtitleLabel.textColor = .white
        subtitleLabel.numberOfLines = 0
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subtitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            subtitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),
            subtitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -236)
        ])
        
        let titleLabel = UILabel(frame: .zero)
        contentView.addSubview(titleLabel)
        self.titleLabel = titleLabel
        titleLabel.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),
            titleLabel.bottomAnchor.constraint(equalTo: subtitleLabel.topAnchor, constant: -4)
        ])
    }
}

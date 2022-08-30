//
//  PodcastDetailViewCell.swift
//  Siniar
//
//  Created by Bayu Yasaputro on 23/08/22.
//

import UIKit

class PodcastDetailViewCell: UITableViewCell {
    weak var artworkImageView: UIImageView!
    weak var titleLabel: UILabel!
    weak var subtitleLabel: UILabel!
    weak var descTextView: UILabel!
    weak var genreLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setup()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setup() {
        selectionStyle = .none
        backgroundColor = UIColor.clear
        
        let imageView = UIImageView(frame: .zero)
        contentView.addSubview(imageView)
        self.artworkImageView = imageView
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 200),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 44)
        ])
        
        let titleLabel = UILabel(frame: .zero)
        contentView.addSubview(titleLabel)
        self.titleLabel = titleLabel
        titleLabel.textColor = UIColor.Siniar.neutral1
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 48),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -48),
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 24),
        ])
        
        let subtitleLabel = UILabel(frame: .zero)
        contentView.addSubview(subtitleLabel)
        self.subtitleLabel = subtitleLabel
        subtitleLabel.textColor = UIColor.Siniar.neutral2
        subtitleLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        subtitleLabel.textAlignment = .center
        subtitleLabel.numberOfLines = 0
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subtitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 48),
            subtitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -48),
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
        ])
        
        let descTextView = UILabel(frame: .zero)
        contentView.addSubview(descTextView)
        self.descTextView = descTextView
        descTextView.textColor = UIColor.Siniar.neutral1
        descTextView.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        descTextView.textAlignment = .left
        descTextView.numberOfLines = 0
        descTextView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            descTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            descTextView.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 24),
        ])
        
        let genreLabel = UILabel(frame: .zero)
        contentView.addSubview(genreLabel)
        self.genreLabel = genreLabel
        genreLabel.textColor = UIColor.Siniar.neutral2
        genreLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        genreLabel.textAlignment = .left
        genreLabel.numberOfLines = 1
        genreLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            genreLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            genreLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            genreLabel.topAnchor.constraint(equalTo: descTextView.bottomAnchor, constant: 16),
            genreLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24)
        ])
    }
}

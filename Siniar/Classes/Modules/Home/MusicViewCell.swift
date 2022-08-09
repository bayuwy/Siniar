//
//  MusicViewCell.swift
//  Siniar
//
//  Created by Bayu Yasaputro on 09/08/22.
//

import UIKit

protocol MusicViewCellDelegate: NSObjectProtocol {
    func musicViewCellMoreButtonTapped(_ cell: MusicViewCell)
}

class MusicViewCell: UITableViewCell {
    weak var contentStackView: UIStackView!
    weak var noLabel: UILabel!
    weak var thumbImageView: UIImageView!
    weak var titleStackView: UIStackView!
    weak var titleLabel: UILabel!
    weak var subtitleLabel: UILabel!
    weak var moreButton: UIButton!
    
    weak var delegate: MusicViewCellDelegate?
    
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
        backgroundColor = .clear
        selectionStyle = .none
        
        let contentStackView = UIStackView()
        contentView.addSubview(contentStackView)
        self.contentStackView = contentStackView
        contentStackView.axis = .horizontal
        contentStackView.alignment = .fill
        contentStackView.distribution = .fill
        contentStackView.spacing = 20
//        contentStackView.isUserInteractionEnabled = false
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            contentStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            contentStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            contentStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
        
        let noLabel = UILabel(frame: .zero)
        contentStackView.addArrangedSubview(noLabel)
        self.noLabel = noLabel
        noLabel.textColor = .white
        noLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        noLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        let thumbImageView = UIImageView(frame: .zero)
        contentStackView.addArrangedSubview(thumbImageView)
        self.thumbImageView = thumbImageView
        thumbImageView.contentMode = .scaleAspectFill
        thumbImageView.layer.cornerRadius = 3
        thumbImageView.layer.masksToBounds = true
        NSLayoutConstraint.activate([
            thumbImageView.widthAnchor.constraint(equalToConstant: 32),
            thumbImageView.heightAnchor.constraint(equalToConstant: 32)
        ])
        
        let titleStackView = UIStackView()
        contentStackView.addArrangedSubview(titleStackView)
        self.titleStackView = titleStackView
        titleStackView.axis = .vertical
        titleStackView.alignment = .fill
        titleStackView.distribution = .fill
        titleStackView.spacing = 4
        
        let titleLabel = UILabel(frame: .zero)
        titleStackView.addArrangedSubview(titleLabel)
        self.titleLabel = titleLabel
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        titleLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        let subtitleLabel = UILabel(frame: .zero)
        titleStackView.addArrangedSubview(subtitleLabel)
        self.subtitleLabel = subtitleLabel
        subtitleLabel.textColor = UIColor(rgb: 0x817A7A)
        subtitleLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        subtitleLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
    
        let moreButton = UIButton(type: .system)
        contentStackView.addArrangedSubview(moreButton)
        self.moreButton = moreButton
        moreButton.tintColor = .white
        moreButton.setImage(UIImage(named: "btn_more"), for: .normal)
        moreButton.setTitle(nil, for: .normal)
        moreButton.widthAnchor.constraint(equalToConstant: 24).isActive = true
        moreButton.addTarget(self, action: #selector(self.moreButtonTapped(_:)), for: .touchUpInside)
    }
    
    @objc func moreButtonTapped(_ sender: Any) {
        delegate?.musicViewCellMoreButtonTapped(self)
    }
}

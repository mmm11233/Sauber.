//
//  MoviesListTableViewCell.swift
//  Sauber
//
//  Created by Mariam Joglidze on 06/09/2024.
//

import UIKit

class MoviesListTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    private var moviesTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = .darkGray
        label.text = "Top rated"
        label.translatesAutoresizingMaskIntoConstraints =  false
        
        return label
    }()
    
    private var moviesRatingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = .darkGray
        label.text = "Top rated"
        label.translatesAutoresizingMaskIntoConstraints =  false
        
        return label
    }()
    
    private var moviesOverviewLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = .darkGray
        label.text = "Top rated"
        label.translatesAutoresizingMaskIntoConstraints =  false
        
        return label
    }()

    private let moviesImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.image = UIImage(named: "red")
        image.layer.cornerRadius = 10
        image.layer.masksToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    private func setUpSubView() {
        contentView.addSubview(moviesTitleLabel)
        contentView.addSubview(moviesRatingLabel)
        contentView.addSubview(moviesOverviewLabel)
        contentView.addSubview(moviesImage)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
        
        ])
    }
}

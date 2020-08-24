//
//  VehicleCell.swift
//  ParqueaderoCeiba
//
//  Created by Brayam Alberto Mora Arias - Ceiba Software on 23/08/20.
//  Copyright © 2020 Brayam Alberto Mora Arias - Ceiba Software. All rights reserved.
//

import UIKit

class VehicleCell: UITableViewCell {
    
    var vehicle: Vehicle? {
        didSet {
            guard let vehicleItem = vehicle else {return}
            profileImageView.image = vehicleItem.type == Constants.car ? UIImage(named: "car") : UIImage(named: "motorbike")
            numberPlateLabel.text = "Number Plate: \(vehicleItem.numberPlate)"
            entryDateLabel.text = "Entry Date: \(formatDate(vehicleItem.date))"
        }
    }
    
    let profileImageView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill // image will never be strecthed vertially or horizontally
        img.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
        img.layer.cornerRadius = 5
        img.clipsToBounds = true
       return img
    }()
    
    let numberPlateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let entryDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .black
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true // this will make sure its children do not go out of the boundary
        return view
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupViews() {
        contentView.addSubview(profileImageView)
        containerView.addSubview(numberPlateLabel)
        containerView.addSubview(entryDateLabel)
        contentView.addSubview(containerView)
    }
    
    private func setupConstraints() {
        
        // profile image
        profileImageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        profileImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant:10).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant:70).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant:70).isActive = true
        
        // container view
        containerView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: self.profileImageView.trailingAnchor, constant:10).isActive = true
        containerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant:-10).isActive = true
        containerView.heightAnchor.constraint(equalToConstant:40).isActive = true
        
        // number plate
        numberPlateLabel.topAnchor.constraint(equalTo: self.containerView.topAnchor).isActive = true
        numberPlateLabel.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor).isActive = true
        numberPlateLabel.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor).isActive = true
        
        // entry date
        entryDateLabel.topAnchor.constraint(equalTo: self.numberPlateLabel.bottomAnchor).isActive = true
        entryDateLabel.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor).isActive = true
        entryDateLabel.topAnchor.constraint(equalTo: self.numberPlateLabel.bottomAnchor).isActive = true
    }
    
    private func formatDate (_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, h:mm a"
        return dateFormatter.string(from: date)
    }
    
}

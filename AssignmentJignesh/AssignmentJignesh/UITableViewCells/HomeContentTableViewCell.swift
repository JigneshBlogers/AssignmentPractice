import UIKit

class HomeContentTableViewCell: UITableViewCell {
    
    // MARK:- Subivew And Declarations
    var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: Constants.FontSize.titleLabelOFCanadaCell, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        return label
    }()
    
    var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.contentMode = .topLeft
        label.font = UIFont.systemFont(ofSize: Constants.FontSize.descriptionLabelOFCanadaCell)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        return label
    }()
    
    var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = #imageLiteral(resourceName: "PhotoPlaceholder")
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubviews(profileImageView, titleLabel, descriptionLabel)
        addConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
          super.init(coder: aDecoder)
    }
      
    override func prepareForReuse() {
        self.profileImageView.image = #imageLiteral(resourceName: "PhotoPlaceholder")
        self.titleLabel.text =  nil
        self.descriptionLabel.text = nil
    }
    
    // MARK:- Setting Anchors
    fileprivate func addConstraints() {
        
        let marginGuide = contentView.layoutMarginsGuide
            
        profileImageView.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        profileImageView.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        profileImageView.trailingAnchor.constraint(equalTo:marginGuide.trailingAnchor).isActive = true
        
        titleLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
    }
}

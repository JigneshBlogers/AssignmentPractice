import UIKit

class HomeContentTableViewCell: UITableViewCell {
    
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
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = #imageLiteral(resourceName: "PhotoPlaceholder")
        return imageView
    }()
    
    var mainView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = UIColor.lightText
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(mainView)
        mainView.addSubviews(profileImageView, titleLabel, descriptionLabel)
        addConstraints()
    }
    
    override func prepareForReuse() {
        self.profileImageView.image = #imageLiteral(resourceName: "PhotoPlaceholder")
    }
    
    fileprivate func addConstraints() {
        let views: [String: Any] = ["titleLabel":titleLabel,"descriptionLabel":descriptionLabel,"profileImageView":profileImageView,"mainView":mainView]
        var allConstraints: [NSLayoutConstraint] = []
        
        allConstraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-[mainView]-|", options: [], metrics: nil, views: views)
        allConstraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-[mainView]-|", options: [], metrics: nil, views: views)
        
        allConstraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-[profileImageView(125)]-[titleLabel]-|", options: [], metrics: nil, views: views)
        allConstraints += NSLayoutConstraint.constraints(withVisualFormat: "H:[profileImageView]-[descriptionLabel]-|", options: [], metrics: nil, views: views)
        allConstraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-[profileImageView(125)]->=5-|", options: [], metrics: nil, views: views)
        
        allConstraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-[titleLabel]-4-[descriptionLabel]->=4-|", options: [], metrics: nil, views: views)
        
        NSLayoutConstraint.activate(allConstraints)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

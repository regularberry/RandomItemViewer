import Foundation
import UIKit

class ItemCell: UICollectionViewCell {
    var item: Item?
    weak var itemDeleter: ItemDeleter?
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .title1)
        label.textColor = .label
        label.numberOfLines = 1
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .label
        label.numberOfLines = 0
        return label
    }()
    
    lazy var deleteButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Delete", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = .preferredFont(forTextStyle: .title3)
        button.titleLabel?.textAlignment = .right
        button.addTarget(self, action: #selector(tappedDelete), for: .touchUpInside)
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(deleteButton)
        NSLayoutConstraint.activate([
            deleteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4.0),
            deleteButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4.0),
            deleteButton.widthAnchor.constraint(equalToConstant: 70.0),
        ])
        
        contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4.0),
            titleLabel.trailingAnchor.constraint(equalTo: deleteButton.leadingAnchor, constant: -4.0),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4.0),
        ])
        
        contentView.addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4.0),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4.0),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4.0),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4.0),
        ])
        
        contentView.bringSubviewToFront(deleteButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(_ item: Item) {
        self.item = item
        titleLabel.text = item.title
        descriptionLabel.text = item.description
    }
    
    @objc func tappedDelete() {
        guard let item = self.item else { return }
        itemDeleter?.delete(item: item)
    }
}

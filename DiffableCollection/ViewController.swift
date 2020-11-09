import UIKit

class ViewController: UIViewController, ItemDeleter {
    enum Section {
        case main
    }
    
    var items: [Item] = []
    var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    
    let collectionView: UICollectionView = {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(50.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(50.0)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let registration = UICollectionView.CellRegistration<ItemCell, Item> { cell, indexPath, item in
            cell.configure(item)
        }
        
        self.dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView) { collectionView, indexPath, item in
            let itemCell = collectionView.dequeueConfiguredReusableCell(using: registration, for: indexPath, item: item)
            itemCell.itemDeleter = self
            return itemCell
        }
        
        collectionView.dataSource = dataSource
        
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem))
        
        title = "Random Item Viewer"
    }
    
    @objc func addItem() {
        var desc: String = ""
        let random = Int.random(in: 0...20)
        for _ in 0...random {
            desc += "word "
        }
        let item = Item(title: "RANDOM ITEM", description: desc)
        items.append(item)
        applySnapshot()
    }
    
    func delete(item: Item) {
        self.items = self.items.filter( { $0 != item })
        applySnapshot()
    }
    
    func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.main])
        snapshot.appendItems(items)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

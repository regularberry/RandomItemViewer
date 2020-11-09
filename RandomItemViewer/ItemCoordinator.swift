import Foundation
import UIKit

protocol ItemCoordinator: class {
    func addItem()
    func deleteItem(_ item: Item)
    func viewDidLoad()
}

class DefaultItemCoordinator: ItemCoordinator {
    let vc: ViewController
    var items: [Item] = []
    
    init() {
        vc = ViewController()
        vc.coordinator = self
    }
    
    private func createRandomItem() -> Item {
        var desc: String = ""
        let random = Int.random(in: 0...20)
        for _ in 0...random {
            desc += "word "
        }
        return Item(title: "RANDOM ITEM", description: desc)
    }
    
    func addItem() {
        items.append(createRandomItem())
        applySnapshot()
    }
    
    func deleteItem(_ item: Item) {
        self.items = self.items.filter( { $0 != item })
        applySnapshot()
    }
    
    func viewDidLoad() {
        for _ in 0...Int.random(in: 0...10) {
            items.append(createRandomItem())
        }
        applySnapshot()
    }
    
    func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<ViewController.Section, Item>()
        snapshot.appendSections([.main])
        snapshot.appendItems(items)
        vc.dataSource.apply(snapshot, animatingDifferences: true)
    }
}

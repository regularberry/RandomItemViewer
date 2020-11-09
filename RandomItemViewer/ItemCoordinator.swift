//
//  ItemCoordinator.swift
//  RandomItemViewer
//
//  Created by Develoment on 09/11/2020.
//

import Foundation
import UIKit

protocol ItemCoordinator: class {
    func addItem()
    func delete(item: Item)
    func viewDidLoad()
}
class DefaultItemCoordinator: ItemCoordinator {
    let itemViewController: ItemViewController
    
    var items: [Item] = []
    
    init() {
        self.itemViewController = ItemViewController()
        self.itemViewController.coordinator = self
    }
    
    func addItem() {
        items.append(createRandomItem())
        applySnapshot()
    }
    
    func delete(item: Item) {
        self.items = self.items.filter( { $0 != item })
        applySnapshot()
    }
    
    private func createRandomItem() -> Item {
        var desc: String = ""
        let random = Int.random(in: 0...20)
        for _ in 0...random {
            desc += "word "
        }
        return Item(title: "RANDOM ITEM", description: desc)
    }

    private func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<ItemViewController.Section, Item>()
        snapshot.appendSections([.main])
        snapshot.appendItems(items)
        self.itemViewController.dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    func viewDidLoad() {
        items = []
        for _ in 0...Int.random(in: 0...8) {
            items.append(createRandomItem())
        }
        self.applySnapshot()
    }
}

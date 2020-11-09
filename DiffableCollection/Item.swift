import Foundation

struct Item: Hashable, Equatable {
    let id: UUID = UUID()
    let title: String
    let description: String
}

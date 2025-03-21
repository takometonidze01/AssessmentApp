//
//  CustomCollectionViewDataSource.swift
//  Presentation
//
//  Created by Tako Metonidze on 3/21/25.
//

import UIKit

public class CustomCollectionViewDataSource<
  SectionIdentifierType: Sendable, ItemIdentifierType: Sendable>: UICollectionViewDiffableDataSource<SectionIdentifierType, ItemIdentifierType
> where SectionIdentifierType: ListSectionProvidable, ItemIdentifierType: ListItemProvidable, SectionIdentifierType.ID == ItemIdentifierType.SectionIdentifierType {
  public typealias CellRegistration = CustomCollectionView.CellRegistration<CustomCollectionViewCell, ItemIdentifierType>
  public typealias CellRegistrations = [ListItemType: CellRegistration]

  private var cellRegistrations: CellRegistrations

  public init(
    collectionView view: CustomCollectionView,
    cellRegisrations: CellRegistrations = [:]
  ) {
    self.cellRegistrations = cellRegisrations

    super.init(collectionView: view) { collectionView, indexPath, itemIdentifier in
      guard let cellRegistrationProvider = cellRegisrations[itemIdentifier.type] else {
        fatalError("CustomCollectionViewDataSource cellRegisrtation missing for: \(itemIdentifier.type)")
      }

      return collectionView.dequeueConfiguredReusableCell(
        using: cellRegistrationProvider,
        for: indexPath,
        item: itemIdentifier
      )
    }
  }

  deinit {
    print("⬅️🗑 deinit CustomCollectionViewDataSource")
  }
}

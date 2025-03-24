//
//  DetailsViewModel.swift
//  AssessmentApp
//
//  Created by Tako Metonidze on 3/24/25.
//

import RxSwift
import RxCocoa
import UIKit
import Domain
import Networking
import Presentation

@MainActor
final class DetailsViewModel: DetailsViewModelInputs, DetailsViewModelOutputs {
  typealias CollectionViewDataSource = CustomCollectionViewDataSource<ListSection<String>, ListItem<String>>
  typealias ListSectionIdentifierType = ListSection<String>
  typealias ListItemIdentifierType = ListItem<String>
  typealias SnapshotType = NSDiffableDataSourceSnapshot<ListSectionIdentifierType, ListItemIdentifierType>

  private var dataSource: CollectionViewDataSource?

  let actions: Driver<DetailsView.ViewActions>

  private let actionsSubject: PublishSubject<DetailsView.ViewActions> = PublishSubject<DetailsView.ViewActions>()

  private var imageData: ImageQuestion

  var serviceLocator: DetailsServiceLocatorProtocol

  init(
    imageData: ImageQuestion,
    serviceLocator: DetailsServiceLocatorProtocol
  ) {
    self.imageData = imageData
    self.serviceLocator = serviceLocator

    actions = actionsSubject
      .asDriver(onErrorJustReturn: .idle)
  }

  func setCollectionView(collectionView: CustomCollectionView) {
    dataSource = makeDataSource(for: collectionView)
  }

  private func makeDataSource(for collectionView: CustomCollectionView) -> CollectionViewDataSource? {
    let cellRegistrations: CollectionViewDataSource.CellRegistrations = [
      .imageItem: getImageCell()
    ]

    dataSource = CollectionViewDataSource(collectionView: collectionView, cellRegisrations: cellRegistrations)

    Task { [weak self] in
      guard let self else { return }
      self.updateDataSource()
    }
    return dataSource
  }

  private func getImageCell() -> CollectionViewDataSource.CellRegistration {
    CollectionViewDataSource.CellRegistration { [weak self] cell, _, _ in
      guard let self else { return }

      let configuration = DetailContentConfiguration(
        image: self.imageData.src,
        title: self.imageData.title
      )

      cell.contentConfiguration = configuration
    }
  }

  @MainActor
  private func updateDataSource() {
    var snapshot = SnapshotType()
    let imageSection = ListSectionIdentifierType(id: "image-section", title: "")
    let imageItem = ListItemIdentifierType(id: UUID().uuidString, sectionIdentifier: imageSection.id, type: .imageItem)

    snapshot.appendSections([imageSection])
    snapshot.appendItems([imageItem], toSection: imageSection)

    dataSource?.apply(snapshot, animatingDifferences: false)
  }
}

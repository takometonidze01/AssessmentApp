//
//  MainViewModel.swift
//  AssessmentApp
//
//  Created by Tako Metonidze on 3/23/25.
//

import RxSwift
import RxCocoa
import UIKit
import Domain
import Networking
import Presentation

@MainActor
final class MainViewModel: MainViewModelInputs, MainViewModelOutputs {
  typealias CollectionViewDataSource = CustomCollectionViewDataSource<ListSection<String>, ListItem<String>>
  typealias ListSectionIdentifierType = ListSection<String>
  typealias ListItemIdentifierType = ListItem<String>
  typealias SnapshotType = NSDiffableDataSourceSnapshot<ListSectionIdentifierType, ListItemIdentifierType>

  private var dataSource: CollectionViewDataSource?

  let actions: Driver<MainView.ViewActions>

  private let actionsSubject: PublishSubject<MainView.ViewActions> = PublishSubject<MainView.ViewActions>()

  init() {
    actions = actionsSubject
      .asDriver(onErrorJustReturn: .idle)
  }

  func viewDidLoad() {
//    Task {
//      do {
//        let repository = FormRepository(service: CustomRestApi(baseURL: URL(string: "https://run.mocky.io")!))
//        let formData = try await repository.fetchFormData()
//        print("✅ API Success: \(formData)")
//      } catch {
//        print("❌ API Error: \(error.localizedDescription)")
//      }
//    }
  }

  func setCollectionView(collectionView: CustomCollectionView) {
    dataSource = makeDataSource(for: collectionView)
  }

  private func makeDataSource(for collectionView: CustomCollectionView) -> CollectionViewDataSource? {
    let cellRegistrations: CollectionViewDataSource.CellRegistrations = [
      .page: getTextCell(for: .page),
      .sectionTitle: getTextCell(for: .sectionTitle),
      .subtitle: getTextCell(for: .subtitle)
    ]

    dataSource = CollectionViewDataSource(collectionView: collectionView, cellRegisrations: cellRegistrations)

    Task { [weak self] in
      guard let self else {
        return
      }

      self.updateDataSource()
    }
    return dataSource
  }

  private func getTextCell(for type: ListItemType) -> CollectionViewDataSource.CellRegistration {
    CollectionViewDataSource.CellRegistration { cell, _, _ in
      let font: UIFont = type.associatedFont
      let configuration = TextContentConfiguration(title: "Introduction", font: font)
      cell.contentConfiguration = configuration
    }
  }

  @MainActor
  private func updateDataSource() {
    var snapshot = SnapshotType()

    let section = ListSectionIdentifierType(id: "section1", title: "")
    let item = ListItemIdentifierType(id: "item1", sectionIdentifier: section.id, type: .page)

    snapshot.appendSections([section])
    snapshot.appendItems([item], toSection: section)

    dataSource?.apply(snapshot, animatingDifferences: false)
  }
}

private extension ListItemType {
  var associatedFont: UIFont {
    switch self {
    case .page:
      return .h1
    case .sectionTitle:
      return .body1
    case .subtitle:
      return .body2
      // Handle any additional or new cases gracefully:
    default:
      return .systemFont(ofSize: 17, weight: .regular)
    }
  }
}

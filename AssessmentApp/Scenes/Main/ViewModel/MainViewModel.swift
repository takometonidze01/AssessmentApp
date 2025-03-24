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

  private var formData: PageItem?

  init() {
    actions = actionsSubject
      .asDriver(onErrorJustReturn: .idle)
  }

  func viewDidLoad() {
    fetchFormData()
  }

  func setCollectionView(collectionView: CustomCollectionView) {
    dataSource = makeDataSource(for: collectionView)
  }

  private func makeDataSource(for collectionView: CustomCollectionView) -> CollectionViewDataSource? {
    let cellRegistrations: CollectionViewDataSource.CellRegistrations = [
      .page: getTextCell(for: .page),
      .sectionTitle: getTextCell(for: .sectionTitle),
      .subtitle: getTextCell(for: .subtitle),
      .imageItem: getImageCell()
    ]

    dataSource = CollectionViewDataSource(collectionView: collectionView, cellRegisrations: cellRegistrations)
    return dataSource
  }

  private func fetchFormData() {
    Task { [weak self] in
      guard let self else { return }
      do {
        let repository = FormRepository(service: CustomRestApi(baseURL: URL(string: "https://run.mocky.io")!))
        let formData = try await repository.fetchFormData()
        self.formData = formData

        self.updateDataSource()
      } catch {
        print("❌ API Error: \(error.localizedDescription)")
      }
    }
  }

  private func getTextCell(for type: ListItemType) -> CollectionViewDataSource.CellRegistration {
    CollectionViewDataSource.CellRegistration { cell, _, identifier in
      let font: UIFont = type.associatedFont
      let configuration = TextContentConfiguration(title: identifier.id, font: font)
      cell.contentConfiguration = configuration
    }
  }

  private func getImageCell() -> CollectionViewDataSource.CellRegistration {
    CollectionViewDataSource.CellRegistration { [weak self] cell, _, identifier in
      guard let self, let rootItems = self.formData?.items,
        let item = flatten(items: rootItems).first(where: {
          if case let .image(image) = $0 {
            return image.title == identifier.id
          }
          return false
        }), case let .image(imageData) = item else { return }
      let configuration = ImageContentConfiguration(image: imageData.src, title: imageData.title)
      cell.contentConfiguration = configuration
    }
  }

  @MainActor
  private func updateDataSource() {
    guard let rootPage = self.formData else { return }

    var snapshot = SnapshotType()

    let mainSection = ListSectionIdentifierType(id: rootPage.title, title: rootPage.title)
    snapshot.appendSections([mainSection])

    let mainTitleItem = ListItemIdentifierType(
      id: rootPage.title,
      sectionIdentifier: mainSection.id,
      type: .page
    )
    snapshot.appendItems([mainTitleItem], toSection: mainSection)

    processItems(formData?.items ?? [], into: &snapshot, parentSection: mainSection)

    dataSource?.apply(snapshot, animatingDifferences: false)
  }

  private func processItems(
    _ items: [FormItem],
    into snapshot: inout SnapshotType,
    parentSection: ListSectionIdentifierType
  ) {
    processItemsRecursively(items, into: &snapshot, parentSection: parentSection)
  }

  private func processItemsRecursively(
    _ items: [FormItem],
    into snapshot: inout SnapshotType,
    parentSection: ListSectionIdentifierType
  ) {
    for item in items {
      switch item {
      case .section(let sectionItems):
        let sectionItem = ListItemIdentifierType(
          id: sectionItems.title,
          sectionIdentifier: sectionItems.title,
          type: .sectionTitle
        )
        snapshot.appendItems([sectionItem], toSection: parentSection)
        processItemsRecursively(
          sectionItems.items,
          into: &snapshot,
          parentSection: parentSection
        )
      case .page(let pageItem):
        let listSection = ListSectionIdentifierType(
          id: pageItem.title,
          title: pageItem.title
        )
        let listItem = ListItemIdentifierType(
          id: pageItem.title,
          sectionIdentifier: pageItem.title,
          type: .page
        )
        snapshot.appendSections([listSection])
        snapshot.appendItems([listItem], toSection: listSection)
        processItemsRecursively(pageItem.items, into: &snapshot, parentSection: listSection)
      case .text(let textItem):
        let listItem = ListItemIdentifierType(
          id: textItem.title,
          sectionIdentifier: parentSection.id,
          type: .subtitle
        )
        snapshot.appendItems([listItem], toSection: parentSection)
      case .image(let imageItem):
        let listItem = ListItemIdentifierType(
          id: imageItem.title,
          sectionIdentifier: parentSection.id,
          type: .imageItem
        )
        snapshot.appendItems([listItem], toSection: parentSection)
      }
    }
  }

  private func flatten(items: [FormItem]) -> [FormItem] {
    var result: [FormItem] = []

    for item in items {
      result.append(item)

      switch item {
      case .section(let section):
        result.append(contentsOf: flatten(items: section.items))
      case .page(let page):
        result.append(contentsOf: flatten(items: page.items))
      default:
        break
      }
    }

    return result
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
    default:
      return .systemFont(ofSize: 17, weight: .regular)
    }
  }
}

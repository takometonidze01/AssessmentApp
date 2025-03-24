//
//  MainView.swift
//  AssessmentApp
//
//  Created by Tako Metonidze on 3/23/25.
//

import RxSwift
import UIKit
import Presentation

class MainView: UIView {
  private var disposeBag = DisposeBag()

  var viewModel: MainViewModelType

  private lazy var collectionView: CustomCollectionView = {
    let layout = UICollectionViewCompositionalLayout { [weak self] index, _ -> NSCollectionLayoutSection? in
      guard let self else {
        return nil
      }

      return self.titleSection()
    }

    let config = UICollectionViewCompositionalLayoutConfiguration()
    config.interSectionSpacing = CGFloat.spacing8
    layout.configuration = config
    let view = CustomCollectionView(collectionViewLayout: layout)
    view.backgroundColor = .green
    view.contentInset = .init(top: CGFloat.spacing6, left: 0, bottom: 0, right: 0)

    return view
  }()

  // MARK: - Init

  init(viewModel: MainViewModelType) {
    self.viewModel = viewModel
    super.init(frame: .zero)
    setup()
  }

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Private Implementations

  private func didReceive(newAction action: ViewActions) {
    switch action {
    case .idle:
      break
    }
  }

  private func setup() {
    backgroundColor = .red

    addSubview(collectionView)

    layout()
    bind()
  }

  private func layout() {
    collectionView.snp.remakeConstraints { make in
      make.edges.equalToSuperview()
    }
  }

  private func titleSection() -> NSCollectionLayoutSection {
    let itemSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1.0),
      heightDimension: .absolute(150)
    )

    let item = NSCollectionLayoutItem(layoutSize: itemSize)

    let verticalGroup = NSCollectionLayoutGroup.vertical(layoutSize: itemSize, subitems: [item])

    let section = NSCollectionLayoutSection(group: verticalGroup)
    section.interGroupSpacing = 16.0
    section.contentInsets = NSDirectionalEdgeInsets(
      top: 0,
      leading: 16.0,
      bottom: 0,
      trailing: 16.0
    )

    return section
  }

  private func bind() {
    disposeBag = DisposeBag()
    viewModel.outputs.actions
      .drive(with: self, onNext: { owner, action in
        owner.didReceive(newAction: action)
      })
      .disposed(by: disposeBag)
    viewModel.inputs.setCollectionView(collectionView: collectionView)
  }
}

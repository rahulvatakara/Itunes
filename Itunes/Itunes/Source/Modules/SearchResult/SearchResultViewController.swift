//
//  HomeViewController.swift
//  Itunes
//
//  Created by Rahul C K on 09/12/22.
//

import UIKit

protocol SearchResultUILogic: AnyObject {
    var interactor: SearchResultBussinessLogic? { get set }
    var router: SearchResultRoutingLogic? { get set }
    func onLayoutChanged(newLayout: SearchResultViewLayout)
}
enum SearchResultViewLayout {
    case grid
    case list
}
private enum SearchResultViewConstants {
    static let gridCellWidthPadding: CGFloat = 20
    static let cellHeight: CGFloat = 110
}
class SearchResultViewController: UIViewController {
    @IBOutlet private var collectionView: UICollectionView!
    @IBOutlet private var segmentControl: UISegmentedControl!
    var currentLayout: SearchResultViewLayout = .grid
    var interactor: SearchResultBussinessLogic?
    var router: SearchResultRoutingLogic?

    static func instantiateViewController() -> SearchResultViewController? {
        UIStoryboard.main().instantiateViewController(withIdentifier: SearchResultViewController.className)
        as? SearchResultViewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupStrings()
    }

    private func setupStrings() {
        self.title = ItunesStrings.searchResult.localized
    }

    @IBAction func layoutChangedAction(_ sender: AnyObject) {
        interactor?.onLayoutChangedAction(currentLayout: currentLayout)
    }
}
extension SearchResultViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        interactor?.numberOfSearchResultItem(for: section) ?? 0
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        interactor?.numberOfSection() ?? 0
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        (currentLayout == .grid) ? gridViewCell(indexPath: indexPath) : listViewCell(indexPath: indexPath)
    }

    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        (kind == UICollectionView.elementKindSectionHeader) ? headerView(indexPath: indexPath) :
        UICollectionReusableView()
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        cellSize(for: currentLayout)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 40)
    }

    private func gridViewCell(indexPath: IndexPath) -> UICollectionViewCell {
        let searchItem = interactor?.searchResultItemAt(section: indexPath.section,
                                                        index: indexPath.row)
        let gridViewcell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultGridViewCell.className,
                                                              for: indexPath)
        if let gridViewcell = gridViewcell as? SearchResultGridViewCell,
           let searchItem = searchItem {
            let imageUrl = searchItem.imageUrl()
            gridViewcell.configure(imageUrl: imageUrl, title: searchItem.title())
        }
        return gridViewcell
    }

    private func listViewCell(indexPath: IndexPath) -> UICollectionViewCell {
        let searchItem = interactor?.searchResultItemAt(section: indexPath.section,
                                                        index: indexPath.row)
        let listViewcell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultListViewCell.className,
                                                              for: indexPath)
        if let listViewcell = listViewcell as? SearchResultListViewCell,
           let searchItem = searchItem {
            let imageUrl = searchItem.imageUrl()
            listViewcell.configure(imageUrl: imageUrl,
                                   title: searchItem.title(),
                                   description: searchItem.subTitle())
        }
        return listViewcell
    }

    private func headerView(indexPath: IndexPath) -> UICollectionReusableView {
        let identifier = SearchResultHeaderView.className
        let kind = UICollectionView.elementKindSectionHeader
        let headerCell = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                         withReuseIdentifier: identifier,
                                                                         for: indexPath)
        if let headerCell = headerCell as? SearchResultHeaderView,
           let title = interactor?.title(for: indexPath.section) {
            headerCell.configure(title: title)
        }
        return headerCell
    }

    private func cellSize(for layout: SearchResultViewLayout) -> CGSize {
        switch layout {
        case .grid:
            let width = (UIScreen.main.bounds.width / 3) - SearchResultViewConstants.gridCellWidthPadding
            return CGSize(width: width,
                          height: SearchResultViewConstants.cellHeight)

        case .list:
            return CGSize(width: collectionView.frame.width,
                          height: SearchResultViewConstants.cellHeight)
        }
    }
}
extension SearchResultViewController: SearchResultUILogic {
    func onLayoutChanged(newLayout: SearchResultViewLayout) {
        currentLayout = newLayout
        collectionView.reloadData()
    }
}

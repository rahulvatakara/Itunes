//
//  HomeViewController.swift
//  Itunes
//
//  Created by Rahul C K on 09/12/22.
//

import UIKit

protocol HomeViewUILogic: AnyObject {
    var interactor: HomeViewBussinessLogic? { get set }
    var router: HomeViewRoutingLogic? { get set }
    func showSearchResults(items: [String: [SearchItem]])
    func updateUIFor(isLoading: Bool)
    func showSeachFailedError()
}
class HomeViewController: UIViewController {
    @IBOutlet private var activityView: UIActivityIndicatorView!
    @IBOutlet private var termField: UITextField!
    @IBOutlet private var mediaTypesLabel: UILabel!
    @IBOutlet private var searchDescripLabel: UILabel!
    @IBOutlet private var searchDescripFieldLabel: UILabel!

    var interactor: HomeViewBussinessLogic?
    var router: HomeViewRoutingLogic?
    var selectedMediaTypes: [String] = []

    static func instantiateViewController() -> HomeViewController? {
        UIStoryboard.main().instantiateViewController(withIdentifier: HomeViewController.className)
        as? HomeViewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        doInitalSetup()
    }

    func doInitalSetup() {
        HomeViewRouter.createHomeViewModule(homeviewRef: self)
        setupStrings()
    }

    func setupStrings() {
        searchDescripLabel.text = ItunesStrings.homeSearchDescrip.localized
        searchDescripFieldLabel.text = ItunesStrings.homeSearchFieldDescrip.localized
        self.title = ItunesStrings.itunes.localized
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    func showSearchResults(items: [String: [SearchItem]]) {
        router?.showSearchResultView(sourceView: self, searchResults: items)
    }

    @IBAction func searchButtonAction(_ sender: AnyObject) {
        interactor?.searchItems(term: termField.text, mediaTypes: selectedMediaTypes)
    }

    @IBAction func addMediaTypeAction(_ sender: AnyObject) {
        router?.showMediaTypePicker(sourceView: self)
    }
}
extension HomeViewController: HomeViewUILogic {
    func updateUIFor(isLoading: Bool) {
        if isLoading {
            activityView.startAnimating()
        } else {
            activityView.stopAnimating()
        }
    }
}
extension HomeViewController: MediaTypePickerViewDelegate {
    func didSelect(mediaTypes: [String]) {
        selectedMediaTypes = mediaTypes
        mediaTypesLabel.text = "  " + mediaTypes.joined(separator: ", ")
    }

    func showSeachFailedError() {
        let dialogMessage = UIAlertController(title: ItunesStrings.homeSearchFailedTitle.localized,
                                              message: ItunesStrings.homeSearchFailedMessage.localized,
                                              preferredStyle: .alert)
        dialogMessage.addAction(UIAlertAction(title: ItunesStrings.okay.localized, style: .default))
        self.present(dialogMessage, animated: true, completion: nil)
    }
}
extension HomeViewController: UITextViewDelegate {
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

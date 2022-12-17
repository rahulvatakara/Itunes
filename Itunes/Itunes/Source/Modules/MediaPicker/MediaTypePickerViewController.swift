//
//  MediaTypePickerViewController.swift
//  Itunes
//
//  Created by Rahul C K on 13/12/22.
//

import UIKit

protocol MediaTypePickerViewDelegate: AnyObject {
    func didSelect(mediaTypes: [String])
}
class MediaTypePickerViewController: UIViewController {
    @IBOutlet private var tableView: UITableView!
    weak var delegate: MediaTypePickerViewDelegate?
    var items: [String] =  ["album", "artist", "movie", "podcast", "musicVideo"]
    var selectedItems: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }

    static func instantiateViewController() -> MediaTypePickerViewController? {
        UIStoryboard.main().instantiateViewController(withIdentifier: MediaTypePickerViewController.className)
        as? MediaTypePickerViewController
    }

    func initialSetup() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done,
                                                            target: self,
                                                            action: #selector(doneButtonAction))
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: UITableViewCell.className)
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.5803921569, green: 0.09019607843, blue: 0.3176470588, alpha: 1)
    }

   @objc func doneButtonAction() {
       self.navigationController?.popViewController(animated: true)
       self.delegate?.didSelect(mediaTypes: selectedItems)
    }
}
extension MediaTypePickerViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        let item = items[indexPath.row]
        if let index = self.selectedItems.firstIndex(of: item) {
            self.selectedItems.remove(at: index)
            cell.accessoryType = .none
        } else {
            self.selectedItems.append(item)
            cell.accessoryType = .checkmark
        }
    }
}

extension MediaTypePickerViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.className,
                                                 for: indexPath)
        let item = items[indexPath.row]
        cell.textLabel?.text = item
        if selectedItems.contains(item) {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
}

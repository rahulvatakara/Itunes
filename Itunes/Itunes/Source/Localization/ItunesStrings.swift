//
//  ItunesStrings.swift
//  Itunes
//
//  Created by RAHUL CK on 12/17/22.
//

import Foundation

enum ItunesStrings: String {
    case itunes = "itunes.itunes"
    case searchResult = "itunes.searchResult"

    // Home
    case homeSearchFailedTitle = "home.failedalert.title"
    case homeSearchFailedMessage = "home.failedalert.message"
    case homeSearchDescrip = "home.screen.descrip"
    case homeSearchFieldDescrip = "home.screen.field.descrip"

    // Generic
    case okay = "generic.okay"

    var localized: String {
        return NSLocalizedString(self.rawValue, comment: "")
    }
}

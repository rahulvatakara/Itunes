//  NSObjectExtension.swift
//  Itunes
//
//  Created by Rahul C K on 09/12/22.
//
import UIKit

extension NSObject {

    class var className: String {
        return String(describing: self)
    }
}

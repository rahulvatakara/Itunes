//
//  MockNavigationController.swift
//  ItunesTests
//
//  Created by RAHUL CK on 12/17/22.
//

import UIKit
class MockNavigationController: UINavigationController {
    public var pushedController: UIViewController?

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        self.pushedController = viewController
        super.pushViewController(viewController, animated: animated)
    }
}

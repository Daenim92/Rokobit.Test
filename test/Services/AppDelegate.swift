//
//  AppDelegate.swift
//  test
//
//  Created by Daenim on 9/7/18.
//  Copyright © 2018 rokobit. All rights reserved.
//

import UIKit
import PluggableApplicationDelegate

@UIApplicationMain
class AppDelegate: PluggableApplicationDelegate {
    override var services: [ApplicationService] {
        return [
            NetworkService.shared,
            PersistenceService.shared
        ]
    }
}


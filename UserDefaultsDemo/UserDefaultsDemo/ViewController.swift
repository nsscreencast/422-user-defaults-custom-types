//
//  ViewController.swift
//  UserDefaultsDemo
//
//  Created by Ben Scheirman on 12/5/19.
//  Copyright © 2019 NSScreencast. All rights reserved.
//

import UIKit

extension UserDefaults.Key where Value == String {
    static let theme = UserDefaults.Key<String>(name: "theme")
}

enum Theme : String {
    case light
    case dark
}

class ViewController: UIViewController {
    @IBOutlet weak var themeSwitch: UISwitch!

    override func viewDidLoad() {
        super.viewDidLoad()
        updateForTheme()
    }

    @IBAction func themeChanged(_ sender: UISwitch) {
        let theme: Theme = sender.isOn ? .light : .dark
        UserDefaults.standard.set(theme.rawValue, for: .theme)
        updateForTheme()
    }

    private func updateForTheme() {
        let isDark = UserDefaults.standard.value(for: .theme) == Theme.dark.rawValue
        themeSwitch.isOn = !isDark
        if isDark {
            view.backgroundColor = UIColor(white: 0.2, alpha: 1.0)
        } else {
            view.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
        }
    }
}


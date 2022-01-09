//
//  VC-D.swift
//  Rx
//
//  Created by Андрей Балобанов on 03.01.2022.
//
//Лейбл и кнопку. В лейбле выводится значение counter (по умолчанию 0), при нажатии counter увеличивается на 1.

import UIKit
import Bond

class VC_D: UIViewController {

    @IBOutlet weak var buttonOutlet: UIButton!
    @IBOutlet weak var label: UILabel!
    
    var counter = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonOutlet.reactive.tap.map{_ in "кнопка нажата: \(self.counter) раз(a)"}.bind(to: label)
        buttonOutlet.reactive.tap.observeNext { _ in
            self.counter += 1
        }
    }
}

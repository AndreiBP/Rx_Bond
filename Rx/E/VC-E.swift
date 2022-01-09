//
//  VC-E.swift
//  Rx
//
//  Created by Андрей Балобанов on 06.01.2022.
//
// Две кнопки и лейбл. Когда на каждую кнопку нажали хотя бы один раз, в лейбл выводится: «Ракета запущена».



import UIKit
import Bond
import ReactiveKit

class VC_E: UIViewController {

    @IBOutlet weak var raketaLabel: UILabel!
        @IBOutlet weak var goOneButton: UIButton!
        @IBOutlet weak var goTwoButton: UIButton!
    
    var tap1 = Observable(false)
    var tap2 = Observable(false)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        combineLatest(goOneButton.reactive.tap, goTwoButton.reactive.tap).map{ _ in "ракета запущена"}.bind(to: raketaLabel)
        
    }
    
}
   

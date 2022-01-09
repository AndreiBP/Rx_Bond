//
//  VC-B.swift
//  Rx
//
//  Created by Андрей Балобанов on 02.01.2022.
//


//Текстовое поле для ввода поисковой строки. Реализуйте симуляцию «отложенного» серверного запроса при вводе текста: если не было внесено никаких изменений в текстовое поле в течение 0,5 секунд, то в консоль должно выводиться: «Отправка запроса для <введенный текст в текстовое поле>».

import UIKit
import Bond

class VC_B: UIViewController {

    @IBOutlet weak var searchTextField: UITextField!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _ = searchTextField.reactive.text.debounce(for: 0.5).observeNext{ text in
            print("Отправка запроса для \(String(describing: text))")
        }
    }

}

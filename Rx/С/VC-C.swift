//
//  VC-C.swift
//  Rx
//
//  Created by Андрей Балобанов on 02.01.2022.
//

//UITableView с выводом 20 разных имён людей и две кнопки. Одна кнопка добавляет новое случайное имя в начало списка, вторая — удаляет последнее имя. Список реактивно связан с UITableView.
// Для задачи «c» добавьте поисковую строку. При вводе текста в поисковой строке, если текст не изменялся в течение двух секунд, выполните фильтрацию имён по введённой поисковой строке (с помощью оператора throttle). Такой подход применяется в реальных приложениях при поиске, который отправляет поисковый запрос на сервер, — чтобы не перегружать сервер и поисковая строка отправлялась на сервер, только когда пользователь закончит ввод (или сделает паузу во вводе).

import UIKit
import Foundation
import Bond

class VC_C: UIViewController {
    
    @IBOutlet weak var deleteButtonOutlet: UIButton!
    @IBOutlet weak var addButtonOutlet: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    
    var arrayName = MutableObservableArray(["A1", "A2", "A3", "A4", "B5", "B6", "B7", "B8", "B9", "C10", "C11", "C12", "C13", "Q14", "Q15", "Q16", "Q17", "Q18", "W19", "W20"])
    var arrayName2 = ["Andrei", "Maks", "Alex", "Bred", "Jon"]
    var rootArray = MutableObservableArray([""])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rootArray.bind(to: tableView) { (dataSourse, indexPath, tableView) -> UITableViewCell in
                let cell = tableView.dequeueReusableCell(withIdentifier: "TV_CCell") as! TV_CCell
                    cell.labelCell.text? = dataSourse[indexPath.row]
                return cell }
        _ = searchTextField.reactive.text.throttle(for: 0).observeNext{ [self] text in
                    if searchTextField.hasText == true {
                        _ = arrayName.filterCollection{ $0.contains(text!)}.bind(to: rootArray)
                    } else { arrayName.bind(to: rootArray)}
            }
        
    }
   
    @IBAction func addButton(_ sender: Any) {
        if let randomElement = arrayName2.randomElement() {
            rootArray.insert(randomElement, at: 0)
        }
    }
    
    @IBAction func deleteButton(_ sender: Any) {
        rootArray.removeLast()
    }
}


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
    
    var arrayName = MutableObservableArray(["Андрей", "Андрей2", "Андрей3", "Андрей4", "Андрей5", "Андрей6", "Андрей7", "Андрей8", "Андрей9", "Андрей10", "Андрей11", "Андрей12", "Андрей13", "Андрей14", "Андрей15", "Андрей16", "Андрей17", "Андрей18", "Андрей19", "Андрей20"])
    var arrayName2 = ["Andrei", "Maks", "Alex", "Bred", "Jon"]
    
    let searchString = Observable("")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // тут не могу понять что писать
        _ = searchTextField.reactive.text.throttle(for: 2).observeNext { [self] text in
              let A = text!.components(separatedBy: " ")
            let all = A.reduce(true) { acc, item in return acc && arrayName.collection.contains(item) }
//            let matches = A.map { arrayName.collection.contains($0)}
//            if matches == [true] {
//
//                print(text)
//                }
            print(all)
        }
        
        arrayName.bind(to: tableView) { (dataSourse, indexPath, tableView) -> UITableViewCell in
            let cell = tableView.dequeueReusableCell(withIdentifier: "TV_CCell") as! TV_CCell
            cell.labelCell.text = dataSourse[indexPath.row]
            return cell
        
        }
    }
    
   
    @IBAction func addButton(_ sender: Any) {
        if let randomElement = arrayName2.randomElement() {
            arrayName.insert(randomElement, at: 0)
        }
    }
    
    @IBAction func deleteButton(_ sender: Any) {
        arrayName.removeLast()
    }
    
}


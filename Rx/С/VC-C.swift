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
    
    var arrayName = MutableObservableArray(["A1", "A2", "A3", "A4", "A5", "A6", "A7", "A8", "A9", "A10", "A11", "A12", "A13", "A14", "A15", "A16", "A17", "A18", "A19", "A20"])
    var arrayName2 = ["Andrei", "Maks", "Alex", "Bred", "Jon"]
    var nowArrayName = MutableObservableArray([""])
    var rootArray = MutableObservableArray([""])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let searchString = searchTextField.reactive.text.throttle(for: 0).filter{ [self] text in arrayName.collection.contains(text!) }
//
//        _ = searchString.observeNext { [self] text in
//           // nowArrayName.append(text!)
//           print(text)
//            nowArrayName.bind(to: arrayName)
//        }
        
       _ = searchTextField.reactive.text.throttle(for: 0).filter{ [self] text in arrayName.collection.contains(text!) }.observeNext{ [self] text in nowArrayName.append(text!)
            nowArrayName.bind(to: arrayName)
           //tableView.reloadData()
        }
        
        arrayName.bind(to: tableView) { (dataSourse, indexPath, tableView) -> UITableViewCell in
            let cell = tableView.dequeueReusableCell(withIdentifier: "TV_CCell") as! TV_CCell
            
//            let cell = tableView.dequeueReusableCell(withIdentifier: "TV_CCell", for: indexPath)
//            if cell.editingStyle == .delete {
//                    print("Deleted")
//                self.arrayName.remove(at: indexPath.row) //Remove element from your array
//                    self.tableView.deleteRows(at: [indexPath], with: .automatic)
//                tableView.reloadData()
//            }
            
                cell.labelCell.text? = dataSourse[indexPath.row]
                return cell }
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


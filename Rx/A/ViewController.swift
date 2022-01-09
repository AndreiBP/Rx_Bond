//
//  ViewController.swift
//  Rx
//
//  Created by Андрей Балобанов on 12.12.2021.
//

import UIKit
import Bond
import ReactiveKit

//a) Два текстовых поля. Логин и пароль, под ними лейбл и ниже кнопка «Отправить». В лейбл выводится «некорректная почта», если введённая почта некорректна. Если почта корректна, но пароль меньше шести символов, выводится: «Слишком короткий пароль». В противном случае ничего не выводится. Кнопка «Отправить» активна, если введена корректная почта и пароль не менее шести символов

class ViewController: UIViewController {

    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var infoLoginPasswordLabel: UILabel!
    @IBOutlet weak var goButtonOutlet: UIButton!
    
    
    let errorLogin = "Некорректная почта"
    let errorPassword = "Слишком короткий пароль"
  
    var login = Observable("")
    var password = Observable("")
    var loginBool = Observable(false)
    var passBool = Observable(false)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //проверка почты на валидность
        _ = loginTextField.reactive.text.observeNext { [self] stringLogin in
            login.value = stringLogin ?? ""
            
            let vEmail = isValidEmailAddress(emailAddressString: login.value)
            if vEmail == false {
                login.value = errorLogin
                loginBool.value = false
            } else { login.value = ""
                loginBool.value = true }
            login.bind(to: infoLoginPasswordLabel)
        }
        
        //проверка пароля на минимальное количество символов
        _ = passwordTextField.reactive.text.map{ $0!.count > 5 }.observeNext { [self] boolPassword in
            if boolPassword == true {
                password.value = ""
                    passBool.value = true
            } else { password.value = errorPassword }
                password.bind(to: infoLoginPasswordLabel)
    }
        
        combineLatest(loginBool, passBool) { log, pass in
            return log == true && pass == true }.bind(to: goButtonOutlet.reactive.isEnabled)
            
        }

    //функция проверки введенной строки на формат почты
    func isValidEmailAddress(emailAddressString: String) -> Bool {

     var returnValue = true
     let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"

     do {
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let nsString = emailAddressString as NSString
            let results = regex.matches(in: emailAddressString, range: NSRange(location: 0, length: nsString.length))

            if results.count == 0
            {
                returnValue = false
            }

        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }

        return  returnValue
    }

}


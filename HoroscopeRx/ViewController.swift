//
//  ViewController.swift
//  HoroscopeRx
//
//  Created by Pedro Alonso on 5/21/18.
//  Copyright © 2018 Pedro Alonso. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var cityOfBirthTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var womanButton: UIButton!
    @IBOutlet weak var manButton: UIButton!
    @IBOutlet weak var checkHoroscopeButton: UIButton!
    @IBOutlet var tapGestureRecognizer: UITapGestureRecognizer!
    
    var userEmail = Variable<String>("")
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        fullNameTextField.layer.borderWidth = 1
        emailTextField.layer.borderWidth = 1
        cityOfBirthTextField.layer.borderWidth = 1
        
        fullNameTextField.rx.text.orEmpty
            .subscribe(onNext: {
                print($0)
                
                let valid = DataValidator.validName(name: $0)
                
                if valid {
                    print("Valid")
                    self.fullNameTextField.layer.borderWidth = 1
                    self.fullNameTextField.layer.borderColor = UIColor.green.cgColor
                } else {
                    print("Not Valid")
                    self.fullNameTextField.layer.borderWidth = 2
                    self.fullNameTextField.layer.borderColor = UIColor.red.cgColor
                }
                
            }, onError: {
                error in
                print(error)
            }, onCompleted: {
                print("Completed")
            }, onDisposed: {
                print("Disposed")
            }).disposed(by: disposeBag)
        
        emailTextField.rx.text.orEmpty
            .subscribe(onNext: {
                print($0)
                
                let valid = DataValidator.validEmail(email: $0)
                
                if valid {
                    print("email Valid")
                    self.emailTextField.layer.borderWidth = 1
                    self.emailTextField.layer.borderColor = UIColor.green.cgColor
                } else {
                    print("email Not Valid")
                    self.emailTextField.layer.borderWidth = 2
                    self.emailTextField.layer.borderColor = UIColor.red.cgColor
                }
                
            }, onError: {
                error in
                print(error)
            }, onCompleted: {
                print("Completed")
            }, onDisposed: {
                print("Disposed")
            }).disposed(by: disposeBag)
        
        cityOfBirthTextField.rx.text.orEmpty
            .subscribe(onNext: {
                print($0)
                
                let valid = DataValidator.validName(name: $0)
                
                if valid {
                    print("city Valid")
                    self.cityOfBirthTextField.layer.borderWidth = 1
                    self.cityOfBirthTextField.layer.borderColor = UIColor.green.cgColor
                } else {
                    print("city Not Valid")
                    self.cityOfBirthTextField.layer.borderWidth = 2
                    self.cityOfBirthTextField.layer.borderColor = UIColor.red.cgColor
                }
                
            }, onError: {
                error in
                print(error)
            }, onCompleted: {
                print("Completed")
            }, onDisposed: {
                print("Disposed")
            }).disposed(by: disposeBag)
        
        tapGestureRecognizer.rx.event.subscribe(onNext: {
            print($0, "tap")
            self.view.endEditing(true)
        }, onError: { (error) in
            print(error)
        }, onCompleted: {
            print("Completed")
        }, onDisposed: {
            print("Disposed")
        }).disposed(by: disposeBag)
        
        Observable.combineLatest(fullNameTextField.rx.text.asObservable(), emailTextField.rx.text.asObservable(), cityOfBirthTextField.rx.text.asObservable(), resultSelector: {
            (name, email, city) -> Void in
            print(name!, city!, email!, "combine latest")
            
            self.checkHoroscopeButton.isEnabled = (DataValidator.validName(name: name!)) && (DataValidator.validName(name: city!)) && (DataValidator.validEmail(email: email!))
            
        }).subscribe(onNext: { () in
            print("Typing")
        }, onError: { (error) in
            print(error)
        }, onCompleted: {
            print("Completed")
        }, onDisposed: {
            print("Disposing")
            
        }).disposed(by: disposeBag)
        
        datePicker.rx.date.skip(1)
            .subscribe(onNext: { (date) in
                print(date.description(with: Locale(identifier: "MX")), "Date here")
                self.datePicker.date = date
                self.datePicker.layer.borderWidth = 1
                self.datePicker.layer.borderColor = UIColor.green.cgColor
                
            }, onError: { (error) in
                print(error)
            }, onCompleted: {
                print("Completed")
            }, onDisposed: {
                print("Disposing")
            }).disposed(by: disposeBag)
        
        womanButton.rx.tap.asObservable().skip(1)
            .subscribe(onNext: {
                
                print("Tap", $0)
                
                self.manButton.isEnabled = false
                
            }, onError: {
                error in
                print(error)
            }, onCompleted: {
                print("Completed")
            }, onDisposed: {
                print("Disposing")
            }).disposed(by: disposeBag)
        
        manButton.rx.tap.asObservable().skip(1)
            .subscribe(onNext: {
                
                print("Tap", $0)
                
                self.womanButton.isEnabled = false
                
            }, onError: {
                error in
                print(error)
            }, onCompleted: {
                print("Completed")
            }, onDisposed: {
                print("Disposing")
            }).disposed(by: disposeBag)
        
        Observable.combineLatest(datePicker.rx.date.asObservable().skip(1), womanButton.rx.tap.asObservable().skip(1), manButton.rx.tap.asObservable().skip(1), resultSelector: {
            (date, man, woman) -> Void in
//            print(name!, city!, email!, "combine latest")
            
//            self.checkHoroscopeButton.isEnabled =
            print(date, man, woman, "All checks out")
        })
        
        checkHoroscopeButton.rx.tap.asObservable()
        .subscribe(onNext: {
            let alert = UIAlertController(title: "Horoscope", message: "You will have  wonderful day", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }, onError: {
            error in
            print(error)
        }, onCompleted: {
            print("Completed")
        }, onDisposed: {
            print("Disposing")
        }).disposed(by: disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


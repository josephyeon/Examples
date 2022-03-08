//
//  ViewController.swift
//  RxSwiftExample
//
//  Created by Hyeon on 2022/03/07.
//

import UIKit
import RxSwift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.example(of: "just, of, from") {
            let one = 1
            let two = 2
            let three = "3"
            
            // MARK: just, of, from
            let observable = Observable<Int>.just(one) // just
            let observable2_1 = Observable.of([one, two], [three]) // of
            let observable4 = Observable.from([one, two, three])
            
            observable.subscribe { event in
                print("just: \(event)")
            }
            
            observable2_1.subscribe { event in
                print("of: \(event)")
            }
            
            observable4.subscribe { event in
                print("from: \(event)")
            }
            
        }
        
        // MARK: create
        self.example(of: "create") {
            let disposeBag = DisposeBag()
            
            let observable = Observable<String>.create({ (observer) -> Disposable in

                observer.onNext("1")
                
                observer.onCompleted()
                
                observer.onNext("?") // 앞에서 이미 종료되었기 때문에 next 이벤트 발생 안함
                
                return Disposables.create()
            })

            // MARK: subscribe
            // observable 내부의 event들을 방출해줌
            observable.subscribe{(event) in
                print(event)
            }
            /* prints
                next(1)
                completed
             */

            
            // MARK: subscribe(onNext: { ... } )
            observable.subscribe(onNext: { element in
                print("onNext: ", element)
                
                /* prints
                 onNext:  1
                 */
            })
        }
        
        //MARK: empty로 설정된 Observable()
        // completed만 출력함
        example(of: "empty") {
            let observable = Observable<Void>.empty()
            
            observable.subscribe(
                
                onNext: { (element) in
                    print(element)
            },
                
                onCompleted: {
                    print("onCompleted")
            }
            )
        }
        
        /* Prints:
         onCompleted
        */
        
        // MARK: never로 설정된 Observable()
        // 아무것도 출력시키지 않음!
        example(of: "never") {
            let observable = Observable<Any>.never()
            
            observable
                .subscribe(
                    onNext: { (element) in
                        print(element)
                },
                    onCompleted: {
                        print("Completed")
                }
            )
        }
        
        // MARK: range()로 설정된 Observable
        // range를 이용해 subscribe를 하면 for 문의 i처럼 활용할 수 있음
        example(of: "range") {
            
            let observable = Observable<Int>.range(start: 1, count: 10)
            
            observable
                .subscribe(onNext: { (i) in
                    print("i: \(i)")
                    let n = Double(i)
                    let fibonacci = Int(((pow(1.61803, n) - pow(0.61803, n)) / 2.23606).rounded())
                    print("fibonacci: \(fibonacci)")
                })
        }
        
        // MARK: Disposing
        // Subscribe 취소
        // Observable의 Event가 무한대로 등록된 경우에는 일정 수준까지만 dispose 실시하고 completed 출력
        // 아래 예시는 이벤트가 10개 있어서 10개 다 출력 후 completed 출력
        example(of: "dispose") {
             
            let observable = Observable.of("A", "B", "C")
             
             let subscription = observable.subscribe({ (event) in
                 
                 print(event)
             })
             
             subscription.dispose()
         }
        
        // MARK: disposeBag
        // dispose에 대한 리턴 값을 담는 객체
        // disposed(by: disposeBag 이름)을 이용해 추가
        example(of: "DisposeBag") {
            
            let disposeBag = DisposeBag()
            
            Observable.of("A", "B", "C")
                .subscribe{
                    print($0)
                }
                .disposed(by: disposeBag) // subscribe로부터 방출된 리턴 값을 disposeBag에 추가
            
            print(disposeBag)
            // prints : RxSwift.DisposeBag
        }
        
        // MARK: Obervable.create에서의 dispose
        // completed는 동작하지 않음
        enum MyError: Error {
             case anError
         }
         
         example(of: "Obervable.create ") {
             let disposeBag = DisposeBag()
             
             Observable<String>.create({ (observer) -> Disposable in
                 observer.onNext("1")
                 
                 observer.onError(MyError.anError)
                 
                 observer.onCompleted()
                 
                 observer.onNext("?")
                 
                 return Disposables.create()
             })
                 .subscribe(
                     onNext: { print($0) },
                     onError: { print($0) },
                     onCompleted: { print("Completed") },
                     onDisposed: { print("Disposed") }
             ).disposed(by: disposeBag) // 이 구문이 있는 이유 : 메로리 제거함으로써 메모리 효율확보
         }
        
        example(of: "Single") {
             
             let disposeBag = DisposeBag()
             
             enum FileReadError: Error {
                 case fileNotFound, unreadable, encodingFailed
             }
             
             func loadText(from name: String) -> Single<String> {

                 return Single.create{ single in
                     
                     let disposable = Disposables.create()
                     
                     guard let path = Bundle.main.path(forResource: name, ofType: "txt") else {
                         single(.error(FileReadError.fileNotFound))
                         return disposable
                     }
                     
                     guard let data = FileManager.default.contents(atPath: path) else {
                         single(.error(FileReadError.unreadable))
                         return disposable
                     }
                     
                     guard let contents = String(data: data, encoding: .utf8) else {
                         single(.error(FileReadError.encodingFailed))
                         return disposable
                     }
                     
                     single(.success(contents))
                     return disposable
                 }
             }
            
            // test
            loadText(from: "myFile")
                   .subscribe{
                       switch $0 {
                       case .success(let string):
                           print(string)
                       case .error(let error):
                           print(error)
                       }
                   }
                   .disposed(by: disposeBag)
            
            // prints: fileNotFound
            
         }
        example(of: "never") {
            let observable = Observable<Any>.never()
            
            let disposeBag = DisposeBag()
            
            // 구독했음을 알리는 print("Subscribed")
            observable.do(
                onSubscribe: { print("Subscribed")}
                ).subscribe(
                    onNext: { (element) in
                        print(element)
                },
                    onCompleted: {
                        print("Completed")
                }
            )
            .disposed(by: disposeBag)
        }
        example(of: "never") {
            let observable = Observable<Any>.never()
            let disposeBag = DisposeBag()
            
            observable
                .debug("never 확인")
                .subscribe()
                .disposed(by: disposeBag)
            
            /* prints
             2020-05-21 19:46:23.534: never 확인 -> subscribed
             2020-05-21 19:46:23.536: never 확인 -> isDisposed
             */
        }
    
    }
    
    public func example(of description: String, action: () -> Void) {
        print("\n--- Example of:", description, "---")
        action()
    }
}


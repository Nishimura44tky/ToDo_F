//
//  SplashViewController.swift
//  ToDo_F
//
//  Created by 西村拓也 on 2021/09/08.
//

import UIKit
import Firebase

class SplashViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    // ①アイコンを小さくする
        UIView.animate(withDuration: 0.5, delay: 0, animations: {
            self.imageView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }) { bool in
        // ②アイコンを大きくする
            UIView.animate(withDuration: 0.2, delay: 0, animations: {
                self.imageView.transform = CGAffineTransform(scaleX: 20, y: 20)
            }) { bool in
            // ③ログイン状態によって、遷移先の選択
                if Auth.auth().currentUser != nil {
                    let storyboard: UIStoryboard = self.storyboard!
                    let next = storyboard.instantiateViewController(withIdentifier: "TodoListViewController")
                    self.present(next, animated: true, completion: nil)
                } else {
                    let storyboard: UIStoryboard = self.storyboard!
                    let next = storyboard.instantiateViewController(withIdentifier: "ViewController")
                    self.present(next, animated: true, completion: nil)
                }
            }
        }
    }
}


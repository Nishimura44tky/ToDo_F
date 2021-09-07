//
//  TodoAddViewController.swift
//  ToDo_F
//
//  Created by 西村拓也 on 2021/09/02.
//

import UIKit
import Firebase

class TodoAddViewController: UIViewController {
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var detailTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        // TextViewのレイアウトをTextField似合わせるためのコード
        detailTextView.layer.borderWidth = 1.0
        detailTextView.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).cgColor
        detailTextView.layer.cornerRadius = 5.0
        detailTextView.layer.masksToBounds = true
    }
    
    @IBAction func tapAddButton(_ sender: Any) {
        if let title = titleTextField.text,
            let detail = detailTextView.text {
            // ②ログイン済みか確認
            if let user = Auth.auth().currentUser {
                // ③FirestoreにTodoデータを作成する
                let createdTime = FieldValue.serverTimestamp()
                Firestore.firestore().collection("users/\(user.uid)/todos").document().setData(
                    [
                     "title": title,
                     "detail": detail,
                     "isDone": false,
                     "createdAt": createdTime,
                     "updatedAt": createdTime
                    ],merge: true
                    ,completion: { error in
                        if let error = error {
                            // ③が失敗した場合
                            print("TODO作成失敗: " + error.localizedDescription)
                            let dialog = UIAlertController(title: "TODO作成失敗", message: error.localizedDescription, preferredStyle: .alert)
                            dialog.addAction(UIAlertAction(title: "OK", style: .default))
                            self.present(dialog, animated: true, completion: nil)
                        } else {
                            print("TODO作成成功")
                            // ④Todo一覧画面に戻る
                            self.dismiss(animated: true, completion: nil)
                        }
                })
            }
        }
    }
}

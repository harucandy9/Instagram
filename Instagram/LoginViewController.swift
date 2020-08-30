//
//  LoginViewController.swift
//  Instagram
//
//  Created by h_nagao on 2020/08/23.
//  Copyright © 2020 haruka.nagao. All rights reserved.
//

import UIKit
import Firebase


class LoginViewController: UIViewController {

    @IBOutlet weak var mailAdressTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var displayNameTextField: UITextField!
    
    //ログイン時
    @IBAction func handleLoginButton(_ sender: Any) {
    }
    //アカウント作成時
    @IBAction func handleCreateAccountButton(_ sender: Any) {
        if let address = mailAdressTextField.text, let password = passwordTextField.text,
            let displayName = displayNameTextField.text{
            if address.isEmpty || password.isEmpty || displayName.isEmpty{
                print("DEBUG_PRINT: 何かが空文字です。")
                return
            }
            
            //アドレスとパスワードでユーザ作成。
            Auth.auth().createUser(withEmail: address, password: password){ authResult, error in
                if let error = error {
                    print("DEBUG_PRINT: " + error.localizedDescription)
                    return
                }
                print("DEBUG_PRINT: ユーザー作成に成功しました。")
                
                //表示名を設定する
                let user = Auth.auth().currentUser
                if let user = user {
                    let changeRequest = user.createProfileChangeRequest()
                    changeRequest.displayName = displayName
                    changeRequest.commitChanges { error in
                        if let error = error {
                            //プロフィールの更新でエラーが発生
                            print("DEBUG_PRINT: " + error.localizedDescription)
                            return
                        }
                        print("DEBUG_PRINT: [displayName = \(user.displayName!)]の設定に成功しました。")
                        
                        //画面を閉じてタブ画面に戻る
                        self.dismiss(animated: true, completion: nil)
                    }
                }
                
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

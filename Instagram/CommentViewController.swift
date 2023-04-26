//
//  CommentViewController.swift
//  Instagram
//
//  Created by yamadakota on 2023/04/15.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage
import SVProgressHUD

class CommentViewController: UIViewController {
    
    @IBOutlet weak var commentTextField: UITextField!
    
    var postData: PostData!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // 投稿ボタンをタップしたときに呼ばれるメソッド
    @IBAction func handleCommentPostButton(_ sender: Any) {
        
        if let unwrappedPostData = postData {
            // commentデータの保存場所を定義する
            let postRef = Firestore.firestore().collection(Const.PostPath).document(unwrappedPostData.id)
            // FireStoreに投稿データを保存する
            let commentName = Auth.auth().currentUser?.displayName
            let commentDic = [
                "commentName": commentName!,
                "commentCaption": self.commentTextField.text!,
            ] as [String : String]
            // 更新データを作成する
            var updateValue: FieldValue
            updateValue = FieldValue.arrayUnion([commentDic])
            // commentsに更新データを書き込む
            postRef.updateData(["comments": updateValue])
        }
        
        // HUDで投稿完了を表示する
        SVProgressHUD.showSuccess(withStatus: "投稿しました")
        // 投稿処理が完了したので先頭画面に戻る
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    // キャンセルボタンをタップしたときに呼ばれるメソッド
    @IBAction func handleCommentCancelButton(_ sender: Any) {
        // ホーム画面に戻る
        self.dismiss(animated: true, completion: nil)
    }
}

//
//  PostTableViewCell.swift
//  Instagram
//
//  Created by yamadakota on 2023/04/14.
//

import UIKit
import FirebaseStorageUI

class PostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var commentButtonOutlet: UIButton!
    @IBOutlet weak var commentLabel: UILabel!
    
    
    // PostDataの内容をセルに表示
    func setPostData(_ postData: PostData) {
        // 画像の表示
        postImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        let imageRef = Storage.storage().reference().child(Const.ImagePath).child(postData.id + ".jpg")
        postImageView.sd_setImage(with: imageRef)
        
        // キャプションの表示
        self.captionLabel.text = "\(postData.name) : \(postData.caption)"
        
        // 日時の表示
        self.dateLabel.text = postData.date
        
        // いいね数の表示
        let likeNumber = postData.likes.count
        likeLabel.text = "\(likeNumber)"
        
        // いいねボタンの表示
        if postData.isLiked {
            let buttonImage = UIImage(named: "like_exist")
            self.likeButton.setImage(buttonImage, for: .normal)
        } else {
            let buttonImage = UIImage(named: "like_none")
            self.likeButton.setImage(buttonImage, for: .normal)
        }
        
        // コメントの表示
        var commentText = ""
        for comment in postData.commentData {
            if let uCommentName = comment["commentName"], let uCommentcaption = comment["commentCaption"] {
                commentText += "\(uCommentName) : \(uCommentcaption)\n"
            }
        }

        self.commentLabel.numberOfLines = 0
        self.commentLabel.text = commentText
        self.commentLabel.sizeToFit()
//        if let uCommentName = postData.commentData[0]["commentName"]{
////            self.commentLabel.text = "\(postData.commentData[0]["commentName"])"
//            self.commentLabel.text = "\(uCommentName)"
//        }
        
        
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

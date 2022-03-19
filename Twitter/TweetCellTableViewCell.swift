//
//  TweetCellTableViewCell.swift
//  Twitter
//
//  Created by Alex Kim on 3/15/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit

class TweetCellTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var tweetContent: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    
    var favorited: Bool = false
    var tweetID: Int = -1
    
    @IBAction func retweet(_ sender: Any) {
        TwitterAPICaller.client?.retweet(tweetID: tweetID, success: {
            self.setRetweeted(true)
        }, failure: { error in
            print("Error in retweeting: \(error)")
        })
    }
    
    func setRetweeted(_ isRetweeted: Bool){
        if isRetweeted {
            retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: UIControl.State.normal)
            retweetButton.isEnabled = false
        } else {
            retweetButton.setImage(UIImage(named: "retweet-icon"), for: UIControl.State.normal)
            retweetButton.isEnabled = true
        }
    }
    @IBAction func favoriteTweet(_ sender: Any) {
        let tobeFavorited = !favorited
        if tobeFavorited {
            TwitterAPICaller.client?.favoriteTweet(tweetID: tweetID, success: {
                self.setFavorite(true)
            }, failure: { error in
                print("Favorite did not succeed \(error)")
            })
        } else {
            TwitterAPICaller.client?.unfavoriteTweet(tweetID: tweetID, success: {
                self.setFavorite(false)
            }, failure: { error in
                print("Unfavorite did not succeed \(error)")
            })
        }
    }

    
    
    func setFavorite(_ isFavorited:Bool){
        favorited = isFavorited
        if favorited {
            likeButton.setImage(UIImage(named: "favor-icon-red"), for: UIControl.State.normal)
        }
        else {
            likeButton.setImage(UIImage(named: "favor-icon"), for: UIControl.State.normal)
        }
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

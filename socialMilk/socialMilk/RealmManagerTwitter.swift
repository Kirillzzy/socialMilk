//
//  RealmManagerTwitter.swift
//  socialMilk
//
//  Created by Kirill Averyanov on 21/12/2016.
//  Copyright © 2016 Kirill Averyanov. All rights reserved.
//

import Foundation
import RealmSwift


final class RealmManagerTwitter{
    static func printRealmPath(){
        let realm = try! Realm()
        print(realm.configuration.fileURL!)
    }
}


// MARK: - Working with TweetPosts
extension RealmManagerTwitter{
    static func saveNewTweetPost(tweet: TweetPostRealm){
        let realm = try! Realm()
        let tweets = realm.objects(TweetPostRealm.self).filter({$0.userId == tweet.userId})
        if tweets.count >= 1000 && tweets.count > 0{
            let minTweets = tweets.sorted(by: {$0.date < $1.date})
            for i in 0 ..< 500{
                try! realm.write {
                    realm.delete(minTweets[i])
                }
            }
        }
        try! realm.write {
            realm.add(tweet)
        }
    }
    
    static func getTweetPosts() -> Results<TweetPostRealm>{
        let realm = try! Realm()
        let tweets = realm.objects(TweetPostRealm.self)
        return tweets
    }
    
    static func encodeTweetPostToRealm(tweet: TweetPost) -> TweetPostRealm{
        let newTweet = TweetPostRealm()
        newTweet.text = tweet.text
        newTweet.date = tweet.date
        newTweet.id = tweet.id
        newTweet.hasLink = tweet.hasLink
        newTweet.hasPhoto = tweet.hasPhoto
        newTweet.hasVideo = tweet.hasVideo
        newTweet.linkLink = tweet.linkLink
        newTweet.photoLink = tweet.photoLink
        newTweet.videoLink = tweet.videoLink
        newTweet.url = tweet.url
        newTweet.userTitle = tweet.user.title
        newTweet.userId = tweet.user.id
        newTweet.userPhotoLink = tweet.user.photoLink
        newTweet.userScreenName = tweet.user.screenName
        newTweet.userDescription = tweet.user.description
        newTweet.hasLike = tweet.hasLike
        newTweet.hasRepost = tweet.hasRepost
        return newTweet
    }
    
    static func encodeRealmTweetPostToJust(tweet: TweetPostRealm) -> TweetPost{
        let user = TwitterChooseGroupClass(title: tweet.userTitle,
                                            photoLink: tweet.userPhotoLink,
                                            id: tweet.userId,
                                            description: tweet.userDescription,
                                            screenName: tweet.userScreenName)
        return TweetPost(user: user,
                         text: tweet.text,
                         date: tweet.date,
                         id: tweet.id,
                         hasLink: tweet.hasLink,
                         hasPhoto: tweet.hasPhoto,
                         hasVideo: tweet.hasVideo,
                         linkLink: tweet.linkLink,
                         photoLink: tweet.photoLink,
                         videoLink: tweet.videoLink,
                         hasLike: tweet.hasLike,
                         hasRepost: tweet.hasRepost)
    }
    
    
    static func deleteTweetPosts(){
        let realm = try! Realm()
        let tweetsToDelete = realm.objects(TweetPostRealm.self)
        for tweet in tweetsToDelete{
            try! realm.write {
                realm.delete(tweet)
            }
        }
    }



}



// MARK: - Working with TweetCheckedPosts
extension RealmManagerTwitter{
    static func saveNewCheckedPost(tweet: TweetCheckedPostRealm){
        let realm = try! Realm()
        try! realm.write {
            realm.add(tweet)
        }
    }
    

    static func updateTweetCheckedPost(tweet: TweetCheckedPostRealm,
                                       newLastCheckedTweetId: String,
                                       newUserTitle: String,
                                       newUserPhotoLink: String,
                                       newUserId: String,
                                       newUserDescription: String,
                                       newUserScreenName: String){
        let realm = try! Realm()
        let updatingTweet = encodeTweetCheckedPostToRealm(tweet:
            TweetCheckedPost(lastCheckedTweetId: newLastCheckedTweetId,
                             user: TwitterChooseGroupClass(title: newUserTitle,
                                                           photoLink: newUserPhotoLink,
                                                           id: newUserId,
                                                           description: newUserDescription,
                                                           screenName: newUserScreenName)))
        let deleting = realm.objects(TweetCheckedPostRealm.self).filter({$0.userId == tweet.userId})
        try! realm.write {
            realm.delete(deleting)
            realm.add(updatingTweet)
        }
    }
    
    
    static func getTweetCheckedPost(userId: String) -> TweetCheckedPost{
        let realm = try! Realm()
        let tweet = realm.objects(TweetCheckedPostRealm.self).filter("userId == \(userId)")
        return encodeRealmTweetCheckedPostToJust(tweet: tweet[tweet.count - 1])
    }
    
    
    static func getTweetCheckedPosts() -> [TweetCheckedPost]{
        let realm = try! Realm()
        let tweets = realm.objects(TweetCheckedPostRealm.self)
        var newTweets = [TweetCheckedPost]()
        for tweet in tweets{
            newTweets.append(encodeRealmTweetCheckedPostToJust(tweet: tweet))
        }
        return newTweets
    }
    
    
    static func encodeTweetCheckedPostToRealm(tweet: TweetCheckedPost) -> TweetCheckedPostRealm{
        let newTweet = TweetCheckedPostRealm()
        newTweet.lastCheckedTweetId = tweet.lastCheckedTweetId
        newTweet.userTitle = tweet.user.title
        newTweet.userPhotoLink = tweet.user.photoLink
        newTweet.userId = tweet.user.id
        newTweet.userDescription = tweet.user.description
        newTweet.userScreenName = tweet.user.screenName
        return newTweet
    }
    
    static func encodeRealmTweetCheckedPostToJust(tweet: TweetCheckedPostRealm) -> TweetCheckedPost{
        let user = TwitterChooseGroupClass(title: tweet.userTitle,
                                           photoLink: tweet.userPhotoLink,
                                           id: tweet.userId,
                                           description: tweet.userDescription,
                                           screenName: tweet.userScreenName)
        return TweetCheckedPost(lastCheckedTweetId: tweet.lastCheckedTweetId, user: user)
    }
    
    
    static func deleteTweetCheckedPosts(){
        let realm = try! Realm()
        let tweetsToDelete = realm.objects(TweetCheckedPostRealm.self)
        for tweet in tweetsToDelete{
            try! realm.write {
                realm.delete(tweet)
            }
        }
    }
}





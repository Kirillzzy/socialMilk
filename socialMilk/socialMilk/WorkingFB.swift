//
//  WorkingFB.swift
//  socialMilk
//
//  Created by Kirill Averyanov on 03/01/2017.
//  Copyright © 2017 Kirill Averyanov. All rights reserved.
//

import Foundation

class WorkingFB{
    
    static var sources = [FBCheckedPost]()
    
    static func updateSources(){
        RealmManagerFB.deleteFBCheckedPosts()
        for post in sources{
            RealmManagerFB.saveNewCheckedPost(post: RealmManagerFB.encodeFBCheckedPostToRealm(post: post))
        }
    }
    
    
//    static func translateFBTimeToUnix(time: String) -> String{
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "E MMM d HH:mm:ss Z yyyy"
//        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
//        let date: Date = dateFormatter.date(from: time)!
//        return String(Int(date.timeIntervalSince1970))
//    }
//    
//    static func checkNewTweets() -> [TweetPost]{
//        var lastTweets: [TweetPost] = [TweetPost]()
//        var count = 0
//        for source in sources{
//            TwitterManager.loadTweetsByUser(user: source.user, callback: { tweets in
//                if tweets != nil{
//                    var twees = tweets!
//                    twees.sort(by: {tweet1, tweet2 in Int(tweet1.date)! > Int(tweet2.date)!})
//                    if source.lastCheckedTweetId != "0"{
//                        for tweet in twees{
//                            if tweet.id == source.lastCheckedTweetId{
//                                break
//                            }
//                            lastTweets.append(tweet)
//                        }
//                    }
//                    if twees.count > 0{
//                        RealmManagerTwitter.updateTweetCheckedPost(tweet: RealmManagerTwitter.encodeTweetCheckedPostToRealm(tweet: source),
//                                                                   newLastCheckedTweetId: twees[0].id,
//                                                                   newUserTitle: source.user.title,
//                                                                   newUserPhotoLink: source.user.photoLink,
//                                                                   newUserId: source.user.id,
//                                                                   newUserDescription: source.user.description,
//                                                                   newUserScreenName: source.user.screenName)
//                        source.lastCheckedTweetId = twees[0].id
//                    }
//                }
//                count += 1
//            })
//        }
//        while(count != sources.count){}
//        for tweet in lastTweets{
//            RealmManagerTwitter.saveNewTweetPost(tweet: RealmManagerTwitter.encodeTweetPostToRealm(tweet: tweet))
//        }
//        lastTweets.sort(by: {tweet1, tweet2 in Int(tweet1.date)! < Int(tweet2.date)!})
//        return lastTweets
//    }
//    
//    static func getOldTweets() -> [TweetPost]{
//        let oldRealmTweets = RealmManagerTwitter.getTweetPosts()
//        var oldTweets = [TweetPost]()
//        for tweet in oldRealmTweets{
//            oldTweets.append(RealmManagerTwitter.encodeRealmTweetPostToJust(tweet: tweet))
//        }
//        oldTweets.sort(by: {tweet1, tweet2 in Int(tweet1.date)! < Int(tweet2.date)!})
//        return oldTweets
//    }
//    
//    static func getTweets() -> [TweetPost]{
//        var oldTweets = getOldTweets()
//        oldTweets.append(contentsOf: checkNewTweets())
//        oldTweets.sort(by: {tweet1, tweet2 in Int(tweet1.date)! < Int(tweet2.date)!})
//        return oldTweets
//    }
//    
//    
//    static func encodePostsToMessages(posts: [FBPost]) -> [MessageClass]{
//        var mess = [MessageClass]()
//        for post in posts{
//            let message = MessageClass(head: post.user.title,
//                                       message: post.text,
//                                       timeNSDate: WorkingVk.translateUnixTime(time: Int(tweet.date)!),
//                                       url: post.url,
//                                       tweet: post)
//            
//            mess.append(message)
//        }
//        return mess
//    }
//    
//    
//    static func createChatByMessages() -> [MessageClass]{
//        return encodePostsToMessages(posts: getPosts())
//    }
//    
    

}

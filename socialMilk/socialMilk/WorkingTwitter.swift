//
//  WorkingTwitter.swift
//  socialMilk
//
//  Created by Kirill Averyanov on 21/12/2016.
//  Copyright © 2016 Kirill Averyanov. All rights reserved.
//

import Foundation


class WorkingTwitter{
    static var sources = [TweetCheckedPost]()
    
    static func updateSources(){
        RealmManagerTwitter.deleteTweetCheckedPosts()
        for tweet in sources{
            RealmManagerTwitter.saveNewCheckedPost(tweet: RealmManagerTwitter.encodeTweetCheckedPostToRealm(tweet: tweet))
        }
    }
    
    //Sat Aug 25 17:26:51 +0000 2012
    
    static func translateTwitterTimeToString(time: String) -> String{
        var date = time.components(separatedBy: " ")
        let concreteTime: String = date[3]
        date = concreteTime.components(separatedBy: ":")
        return "\(date[0]):\(date[1])"
    }
    
    static func checkNewTweets() -> [TweetPost]{
        var lastTweets: [TweetPost] = [TweetPost]()
        var count = 0
        for source in sources{
            TwitterManager.loadTweetsByUser(user: source.user, callback: { tweets in
                if tweets != nil{
                    var twees = tweets!
                    twees.sort(by: {tweet1, tweet2 in tweet1.date > tweet2.date})
                    if source.lastCheckedTweetId != "0"{
                        for tweet in twees{
                            if tweet.id == source.lastCheckedTweetId{
                                break
                            }
                            lastTweets.append(tweet)
                        }
                    }
                    if twees.count > 0{
                        RealmManagerTwitter.updateTweetCheckedPost(tweet: RealmManagerTwitter.encodeTweetCheckedPostToRealm(tweet: source),
                                                                   newLastCheckedTweetId: twees[0].id,
                                                                   newUserTitle: source.user.title,
                                                                   newUserPhotoLink: source.user.photoLink,
                                                                   newUserId: source.user.id,
                                                                   newUserDescription: source.user.description,
                                                                   newUserScreenName: source.user.screenName)
                        source.lastCheckedTweetId = twees[0].id
                    }
                }
                count += 1
            })
        }
        while(count != sources.count){}
        for tweet in lastTweets{
            RealmManagerTwitter.saveNewTweetPost(tweet: RealmManagerTwitter.encodeTweetPostToRealm(tweet: tweet))
        }
        return lastTweets
    }
    
    
    static func getTweets() -> [TweetPost]{
        let oldRealmTweets = RealmManagerTwitter.getTweetPosts()
        var oldTweets = [TweetPost]()
        for tweet in oldRealmTweets{
            oldTweets.append(RealmManagerTwitter.encodeRealmTweetPostToJust(tweet: tweet))
        }
        oldTweets.append(contentsOf: checkNewTweets())
        oldTweets.sort(by: {tweet1, tweet2 in tweet1.date < tweet2.date})
        return oldTweets
    }
    
    
    
    
    static func createChatByMessages() -> [MessageClass]{
        var mess = [MessageClass]()
        let tweets = WorkingTwitter.getTweets()
        for tweet in tweets{
            let message = MessageClass(head: tweet.user.title,
                                       message: tweet.text,
                                       timeString: tweet.date,
                                       url: tweet.url,
                                       tweet: tweet)
            //            if post.hasPhoto {
            //                message.message += "\nHas Photo"
            //            }
            //            if post.hasLink {
            //                message.message += "\nHas Link"
            //            }
            //            if post.hasVideo {
            //                message.message += "\nHas Video"
            //            }
            message.message += "\n" + tweet.url
            mess.append(message)
        }
        return mess
    }

    

}

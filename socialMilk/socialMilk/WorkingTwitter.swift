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
    
    
    static func translateTwitterTimeToUnix(time: String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale!
        dateFormatter.dateFormat = "EEE MMM dd HH:mm:ss Z yyyy"
        let date: Date = dateFormatter.date(from: time)!
        return String(Int(date.timeIntervalSince1970))
    }
    
    static func checkNewTweets() -> [TweetPost]{
        var lastTweets: [TweetPost] = [TweetPost]()
        var count = 0
        for source in sources{
            TwitterManager.loadTweetsByUser(user: source.user, callback: { tweets in
                if tweets != nil{
                    var twees = tweets!
                    twees.sort(by: {tweet1, tweet2 in Int(tweet1.date)! > Int(tweet2.date)!})
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
        lastTweets.sort(by: {tweet1, tweet2 in Int(tweet1.date)! < Int(tweet2.date)!})
        return lastTweets
    }
    
    static func getOldTweets() -> [TweetPost]{
        let oldRealmTweets = RealmManagerTwitter.getTweetPosts()
        var oldTweets = [TweetPost]()
        for tweet in oldRealmTweets{
            oldTweets.append(RealmManagerTwitter.encodeRealmTweetPostToJust(tweet: tweet))
        }
        oldTweets.sort(by: {tweet1, tweet2 in Int(tweet1.date)! < Int(tweet2.date)!})
        return oldTweets
    }
    
    static func getTweets() -> [TweetPost]{
        var oldTweets = getOldTweets()
        oldTweets.append(contentsOf: checkNewTweets())
        oldTweets.sort(by: {tweet1, tweet2 in Int(tweet1.date)! < Int(tweet2.date)!})
        return oldTweets
    }
    
    
    static func encodeTweetsToMessages(tweets: [TweetPost]) -> [MessageClass]{
        var mess = [MessageClass]()
        for tweet in tweets{
            let message = MessageClass(head: tweet.user.title,
                                       message: tweet.text,
                                       timeNSDate: WorkingVk.translateUnixTime(time: Int(tweet.date)!),
                                       url: tweet.url,
                                       tweet: tweet)
            
            mess.append(message)
        }
        return mess
    }
    
    
    static func createChatByMessages() -> [MessageClass]{
        return encodeTweetsToMessages(tweets: getTweets())
    }


}

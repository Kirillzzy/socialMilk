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
    
    static let months = [
        "Jan": "01",
        "Feb": "02",
        "Mar": "03",
        "Apr": "04",
        "May": "05",
        "Jun": "06",
        "Jul": "07",
        "Aug": "08",
        "Sep": "09",
        "Oct": "10",
        "Nov": "11",
        "Dec": "12"
    ]
    
    static func translateTwitterTimeToString(time: String) -> String{
        var date = time.components(separatedBy: " ")
        let month: String = months[date[1]]!
        var day: String = date[2]
        let concreteTime: String = date[3]
        var time = concreteTime.components(separatedBy: ":")
        var hours = Int(time[0])! + 3
        if hours > 23{
            hours = hours - 24
            day = String(Int(day)! + 1)
        }
        var stringHours = String(hours)
        
        if day.characters.count == 1{
            day = "0" + day
        }
        if stringHours.characters.count == 1{
            stringHours = "0" + stringHours
        }
        return "\(month).\(day) \(stringHours):\(time[1])"
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
        return oldTweets
    }
    
    
    
    
    static func createChatByMessages() -> [MessageClass]{
        var mess = [MessageClass]()
        let tweets = WorkingTwitter.getTweets()
        for tweet in tweets{
            let message = MessageClass(head: tweet.user.title,
                                       message: tweet.text,
                                       timeString: WorkingTwitter.translateTwitterTimeToString(time: tweet.date),
                                       url: tweet.url,
                                       tweet: tweet)

            mess.append(message)
        }
        mess.sort(by: {tweet1, tweet2 in tweet1.timeString < tweet2.timeString})
        return mess
    }

    

}

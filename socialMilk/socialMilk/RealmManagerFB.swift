//
//  RealmManagerFB.swift
//  socialMilk
//
//  Created by Kirill Averyanov on 03/01/2017.
//  Copyright © 2017 Kirill Averyanov. All rights reserved.
//

import Foundation
import RealmSwift


final class RealmManagerFB{
    static func printRealmPath(){
        let realm = try! Realm()
        print(realm.configuration.fileURL!)
    }
}


// MARK: - Working with FBPosts
extension RealmManagerFB{
    static func saveNewFBPost(post: FBPostRealm){
        let realm = try! Realm()
        let posts = realm.objects(FBPostRealm.self).filter({$0.groupId == post.groupId})
        if posts.count >= 1000 && posts.count > 0{
            let minPosts = posts.sorted(by: {$0.date < $1.date})
            for i in 0 ..< 500{
                try! realm.write {
                    realm.delete(minPosts[i])
                }
            }
        }
        try! realm.write {
            realm.add(post)
        }
    }
    
    static func getFBPosts() -> Results<FBPostRealm>{
        let realm = try! Realm()
        let posts = realm.objects(FBPostRealm.self)
        return posts
    }
    
    static func encodeFBPostToRealm(post: FBPost) -> FBPostRealm{
        let newPost = FBPostRealm()
        newPost.text = post.text
        newPost.date = post.date
        newPost.id = post.id
        newPost.hasLink = post.hasLink
        newPost.hasPhoto = post.hasPhoto
        newPost.hasVideo = post.hasVideo
        newPost.linkLink = post.linkLink
        newPost.photoLink = post.photoLink
        newPost.videoLink = post.videoLink
        newPost.url = post.url
        newPost.groupTitle = post.group.title
        newPost.groupId = post.group.id
        newPost.groupPhotoLink = post.group.photoLink
        newPost.groupScreenName = post.group.screenName
        newPost.groupDescription = post.group.description
        newPost.hasLike = post.hasLike
        newPost.hasRepost = post.hasRepost
        return newPost
    }
    
    static func encodeRealmFBPostToJust(post: FBPostRealm) -> FBPost{
        let group = FBChooseGroupClass(title: post.groupTitle,
                                       id: post.groupId,
                                       photoLink: post.groupPhotoLink,
                                       description: post.groupDescription,
                                       screenName: post.groupScreenName)
        return FBPost(group: group,
                         text: post.text,
                         date: post.date,
                         id: post.id,
                         url: post.url,
                         hasLink: post.hasLink,
                         hasPhoto: post.hasPhoto,
                         hasVideo: post.hasVideo,
                         linkLink: post.linkLink,
                         photoLink: post.photoLink,
                         videoLink: post.videoLink,
                         hasLike: post.hasLike,
                         hasRepost: post.hasRepost)
    }
    
    
    static func deleteFBPosts(){
        let realm = try! Realm()
        let postsToDelete = realm.objects(FBPostRealm.self)
        for post in postsToDelete{
            try! realm.write {
                realm.delete(post)
            }
        }
    }
    
    
    
}



// MARK: - Working with FBCheckedPosts
extension RealmManagerFB{
    
    static func saveNewCheckedPost(post: FBCheckedPostRealm){
        let realm = try! Realm()
        try! realm.write {
            realm.add(post)
        }
    }
    
    
    static func updateFBCheckedPost(post: FBCheckedPostRealm,
                                       newLastCheckedPostId: String,
                                       newGroupTitle: String,
                                       newGroupPhotoLink: String,
                                       newGroupId: String,
                                       newGroupDescription: String,
                                       newGroupScreenName: String){
        let realm = try! Realm()
        let updatingPost = encodeFBCheckedPostToRealm(post:
            FBCheckedPost(lastCheckedPostId: newLastCheckedPostId,
                          group: FBChooseGroupClass(title: newGroupTitle,
                                                    id: newGroupId,
                                                    photoLink: newGroupPhotoLink,
                                                    description: newGroupDescription,
                                                    screenName: newGroupScreenName)))
        let deleting = realm.objects(FBCheckedPostRealm.self).filter({$0.groupId == post.groupId})
        try! realm.write {
            realm.delete(deleting)
            realm.add(updatingPost)
        }
    }
    
    
    static func getFBCheckedPost(groupId: String) -> FBCheckedPost{
        let realm = try! Realm()
        let posts = realm.objects(FBCheckedPostRealm.self).filter("groupId == \(groupId)")
        return encodeRealmFBCheckedPostToJust(post: posts[posts.count - 1])
    }
    
    
    static func getFBCheckedPosts() -> [FBCheckedPost]{
        let realm = try! Realm()
        let posts = realm.objects(FBCheckedPostRealm.self)
        var newPosts = [FBCheckedPost]()
        for post in posts{
            newPosts.append(encodeRealmFBCheckedPostToJust(post: post))
        }
        return newPosts
    }
    
    
    static func encodeFBCheckedPostToRealm(post: FBCheckedPost) -> FBCheckedPostRealm{
        let newPost = FBCheckedPostRealm()
        newPost.lastCheckedPostId = post.lastCheckedPostId
        newPost.groupTitle = post.group.title
        newPost.groupPhotoLink = post.group.photoLink
        newPost.groupId = post.group.id
        newPost.groupDescription = post.group.description
        newPost.groupScreenName = post.group.screenName
        return newPost
    }
    
    static func encodeRealmFBCheckedPostToJust(post: FBCheckedPostRealm) -> FBCheckedPost{
        let group = FBChooseGroupClass(title: post.groupTitle,
                                       id: post.groupId,
                                       photoLink: post.groupPhotoLink,
                                       description: post.groupDescription,
                                       screenName: post.groupScreenName)
        return FBCheckedPost(lastCheckedPostId: post.lastCheckedPostId, group: group)
    }
    
    
    static func deleteFBCheckedPosts(){
        let realm = try! Realm()
        let postsToDelete = realm.objects(FBCheckedPostRealm.self)
        for post in postsToDelete{
            try! realm.write {
                realm.delete(post)
            }
        }
    }
}





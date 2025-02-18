
//
//  RealmManagerVk.swift
//  socialMilk
//
//  Created by Kirill Averyanov on 05/12/2016.
//  Copyright © 2016 Kirill Averyanov. All rights reserved.
//

import Foundation
import RealmSwift


final class RealmManagerVk{
    static func printRealmPath(){
        let realm = try! Realm()
        print(realm.configuration.fileURL!)
    }
}


// MARK: - Working with VKPost
extension RealmManagerVk{
    static func saveNewVKPost(post: VKPostRealm){
        let realm = try! Realm()
        let posts = realm.objects(VKPostRealm.self).filter({$0.groupId == post.groupId})
        if posts.count >= 1000{
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
    
    static func getVKPosts() -> Results<VKPostRealm>{
        let realm = try! Realm()
        let posts = realm.objects(VKPostRealm.self)
        return posts
    }
    
    static func encodeVKPostToRealm(post: VKPost) -> VKPostRealm{
        let newPost = VKPostRealm()
        newPost.id = post.id
        newPost.date = post.date
        newPost.hasLink = post.hasLink
        newPost.hasVideo = post.hasVideo
        newPost.groupId = post.group.id
        newPost.groupTitle = post.group.title
        newPost.groupIsGroup = post.group.isGroup
        newPost.groupPhotoLink = post.group.photoLink
        newPost.hasPhoto = post.hasPhoto
        newPost.text = post.text
        newPost.url = post.url
        newPost.linkLink = post.linkLink
        newPost.photoLink = post.photoLink
        newPost.videoLink = post.videoLink
        newPost.hasLike = post.hasLike
        newPost.hasRepost = post.hasRepost
        return newPost
    }
    
    static func encodeRealmVkPostToJust(post: VKPostRealm) -> VKPost{
        let group = VKChooseGroupClass(title: post.groupTitle,
                                     photoLink: post.groupPhotoLink,
                                     id: post.groupId,
                                     isGroup: post.groupIsGroup)
        return VKPost(id: post.id,
                      text: post.text,
                      date: post.date,
                      group: group,
                      hasLink: post.hasLink,
                      hasVideo: post.hasVideo,
                      hasPhoto: post.hasPhoto,
                      linkLink: post.linkLink,
                      photoLink: post.photoLink,
                      videoLink: post.videoLink,
                      hasLike: post.hasLike,
                      hasRepost: post.hasRepost)
    }
    
    
    static func deleteVKPosts(){
        let realm = try! Realm()
        let postsToDelete = realm.objects(VKPostRealm.self)
        for post in postsToDelete{
            try! realm.write {
                realm.delete(post)
            }
        }
    }
}



// MARK: - Working with VKCheckedPost
extension RealmManagerVk{
    static func saveNewCheckedPost(post: VKCheckedPostRealm){
        let realm = try! Realm()
        try! realm.write {
            realm.add(post)
        }
    }
    
    
    static func updateVKCheckedPost(post: VKCheckedPostRealm, newLastCheckedPostId: String,
                                    newGroupId: String,
                                    newGroupTitle: String,
                                    newGroupPhotoLink: String,
                                    newGroupIsGroup: Bool){
        let realm = try! Realm()
        let updatingPost = encodeVKCheckedPostToRealm(post: VKCheckedPost(lastCheckedPostId: newLastCheckedPostId,
                                                                          group: VKChooseGroupClass(title: newGroupTitle,
                                                                                                  photoLink: newGroupPhotoLink,
                                                                                                  id: newGroupId,
                                                                                                  isGroup: newGroupIsGroup)))
        let deleting = realm.objects(VKCheckedPostRealm.self).filter({$0.groupId == post.groupId})
        try! realm.write {
            realm.delete(deleting)
            realm.add(updatingPost)
        }
    }
    
    
    static func getVKCheckedPost(groupId: String) -> VKCheckedPost{
        let realm = try! Realm()
        let post = realm.objects(VKCheckedPostRealm.self).filter("groupId == \(groupId)")
        return encodeRealmVkCheckedPostToJust(post: post[post.count - 1])
    }
    
    
    static func getVKCheckedPosts() -> [VKCheckedPost]{
        let realm = try! Realm()
        let posts = realm.objects(VKCheckedPostRealm.self)
        var newPosts = [VKCheckedPost]()
        for post in posts{
            newPosts.append(encodeRealmVkCheckedPostToJust(post: post))
        }
        return newPosts
    }
    
    
    static func encodeVKCheckedPostToRealm(post: VKCheckedPost) -> VKCheckedPostRealm{
        let newPost = VKCheckedPostRealm()
        newPost.lastCheckedPostId = post.lastCheckedPostId
        newPost.groupId = post.group.id
        newPost.groupTitle = post.group.title
        newPost.groupIsGroup = post.group.isGroup
        newPost.groupPhotoLink = post.group.photoLink
        return newPost
    }
    
    static func encodeRealmVkCheckedPostToJust(post: VKCheckedPostRealm) -> VKCheckedPost{
        let group = VKChooseGroupClass(title: post.groupTitle,
                                     photoLink: post.groupPhotoLink,
                                     id: post.groupId,
                                     isGroup: post.groupIsGroup)
        return VKCheckedPost(lastCheckedPostId: post.lastCheckedPostId, group: group)
    }
    
    
    static func deleteVKCheckedPosts(){
        let realm = try! Realm()
        let postsToDelete = realm.objects(VKCheckedPostRealm.self)
        for post in postsToDelete{
            try! realm.write {
                realm.delete(post)
            }
        }
    }
    
}


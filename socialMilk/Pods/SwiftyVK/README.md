# SwiftyVK [![Swift](https://img.shields.io/badge/Swift-3.0.1-orange.svg?style=flat)](https://developer.apple.com/swift/) [![VK API](https://img.shields.io/badge/VK_API-5.60-blue.svg?style=flat)](https://vk.com/dev/versions) [![Platform](https://img.shields.io/cocoapods/p/SwiftyVK.svg?style=flat)](http://cocoadocs.org/docsets/SwiftyVK) [![Build Status](https://travis-ci.org/WE-St0r/SwiftyVK.svg?branch=swift-3-v2)](https://travis-ci.org/WE-St0r/SwiftyVK) [![CocoaPods Compatible](https://img.shields.io/cocoapods/v/SwiftyVK.svg?style=flat)](https://cocoapods.org/pods/SwiftyVK) [![Carthage Compatible](https://img.shields.io/badge/Carthage-✔️-brightgreen.svg)](https://github.com/WE-St0r/SwiftyVK) [![GitHub license](https://img.shields.io/badge/license-MIT-lightgrey.svg)](https://raw.githubusercontent.com/WE-St0r/SwiftyVK/master/LICENSE)

SwiftyVK makes it easy to interact with social network "VKontakte" API for iOS and OSX.

On this page:

* [Requirements](#requirements)
* [Integration](#integration)
  * [Manually](#manually)
  * [CocoaPods](#cocoapods)
  * [Carthage](#carthage)
* [Getting started](#getting-started)
  * [Import and implementation](#import-and-implementation)
  * [Initialization](#initialization)
  * [User authorization](#user-authorization)
  * [Authorization with VK App](#authorization-with-vk-app)
* [API Requests](#api-requests)
  * [Syntax](#syntax)
  * [Custom requests](#custom-requests)
  * [Request properties](#request-properties)
  * [Default properties](#default-properties)
* [Parsing response](#parsing-response)
* [Error handling](#error-handling)
* [Upload files](#upload-files)
* [Longpoll](#longpoll)

##**Requirements**
* Swift 3.0+
* iOS 8.0+ / OSX 10.10+
* Xcode 8.0+

##**Integration**
###Manually
1. Just drag **SwiftyVK.framework** or include the whole **SwiftyVK.xcodeproj** to project
2. Link SwiftyVK.framework to application in **Target preferences -> General -> Embedded binaries**.



###CocoaPods
You can use [CocoaPods](https://github.com/CocoaPods/CocoaPods) to install `SwiftyVK` by adding it to `Podfile`:

```ruby
use_frameworks!

target 'MyApp' do
pod 'SwiftyVK', :git => 'https://github.com/WE-St0r/SwiftyVK.git'
end
```

###Carthage
You can use [Carthage](https://github.com/Carthage/Carthage) to install `SwiftyVK` by adding it to `Cartfile`:
```
github "WE-St0r/SwiftyVK"
```

##**Getting started**
###Import and implementation

Import **SviftyVK** to Swift file:
```swift
import SwiftyVK
```

Implement `VKDelegate` protocol and **all its functions** in custom class. For example:

```swift
class YourClass: Superclass, VKDelegate {

  func vkWillAuthorize() -> Set<VK.Scope> {
    //Called when SwiftyVK need authorization permissions.
    return //an set of application permissions
  }

  func vkDidAuthorizeWith(parameters: Dictionary<String, String>) {
    //Called when the user is log in.
    //Here you can start to send requests to the API.
  }

  func vkAutorizationFailedWith(error: AuthError) {
   //Called when SwiftyVK could not authorize. To let the application know that something went wrong.
  }

  func vkDidUnauthorize() {
    //Called when user is log out.
  }

  func vkShouldUseTokenPath() -> String? {
    // ---DEPRECATED. TOKEN NOW STORED IN KEYCHAIN---
    //Called when SwiftyVK need know where a token is located.
    return //Path to save/read token or nil if should save token to UserDefaults
  }

  func vkWillPresentView() -> UIViewController {
    //Only for iOS!
    //Called when need to display a view from SwiftyVK.
    return //UIViewController that should present authorization view controller
  }

  func vkWillPresentView() -> NSWindow? {
    //Only for OSX!
    //Called when need to display a window from SwiftyVK.
    return //Parent window for modal view or nil if view should present in separate window
  }
}
```
*See full implementation in Example project*

###**Initialization**

1. [Create new standalone application](https://vk.com/editapp?act=create) and get `application ID`
2. Init **SwiftyVK** with `application ID` and `VKDelegate` object:

```swift
VK.configure(withAppId: applicationID, delegate: <VKDelegate_OBJECT>)
```

###**User authorization**
* Implement `vkWillAuthorize()` function in `VKDelegate` and return [application  permissions](https://vk.com/dev/permissions).
* Just call:


```swift
VK.logIn()
```
* And user will see authorization dialog.

After this, you will check VK state:
```swift
VK.state // will be unknown, configured, authorized
```

And if state == authorized, send your requests to API (:

###**Authorization with VK App**
For authorization with official VK application for iOS, you need:

*1. In Xcode -> Target -> Info*

* Add new URL Type with URL identifier to **URL Types** `vk$YOUR_APP_ID$` (e.g. vk1234567890)
* Add app schemas to Info.plist file:
```html
<key>LSApplicationQueriesSchemes</key>
  <array>
    <string>vkauthorize</string>
    <string>vk$YOUR_APP_ID$</string>
  </array>
```
*2. In https://vk.com/apps?act=manage -> Edit App -> Settings*

* Set `App Bundle ID for iOS` to your `App Bundle` in Xcode -> Target -> Bundle Identifier (e.g. com.developer.applicationName)

*3. Add this code to AppDelegate*
```swift
func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
    let app = options[.sourceApplication] as? String
    VK.process(url: url, sourceApplication: app)
    return true
}
```
*4. Test it!*


***If user deny authorization with VK App, SwiftyVK show standart authorization WebView in your app.***


##**API Requests**
###Syntax
The call requests is as follows **VK.methodGroup.methodName**.

For example, send request with parameters and response processing:
```swift
//Init
var preparedReq = VK.API.Users.get()

//Add parameters
preparedReq.add(parameters: [VK.Arg.userId : "1"])

//Add next request after this (optional)
preparedReq. next {response in
  return //Configured next request
}

//Send
let sendedReq = preparedReq.send(
    onSuccess: {response in print(response)},
    onError: {error in print(error)}
)

//Get request status
print(sendedeReq.status)
// -> created, sended, successed, errored, cancelled

//Cancel request
sendedReq.cancel()

```

Or a bit shorter:
```swift
VK.API.Users.get([VK.Arg.userId : "1"]).send(
    onSuccess: {response in print(response)},
    onError: {error in print(error)}
)
```
###Custom requests
You may also send special requests, such as:

* Request with custom method path:
```swift
VK.API.custom(method: "users.get", parameters: [VK.Arg.userId : "1"])
```
* [Execute request](https://vk.com/dev/execute) returns "Hello World":
```swift
VK.API.execute("return \"Hello World\"")
```
* Remote execute stored application code:
```swift
VK.API.remote(method: "YourRemoteMethodName")
```
###Request properties

The requests have several properties that control their behavior. Their names speak for themselves, but just in case I describe them:

Property | Default | Description
:------------- | ------------- | :-------------
`timeout` | 10 | How long in seconds a request will wait for a response from the server. If the wait is longer this value, the generated request error.
`maxAttempts` | 3 | The number of times can be resend the request automatically, if during its execution the error occurred. **0 == infinity attempts**.
`HttpMethod`| .GET | HTTP protocol method.
`parameters`| [VK.Arg : String] | Request API parameters
`catchErrors` | true | Whether to attempt **SwiftyVK** to handle some query errors automatically. Among these errors include the required authentication, captcha, exceeding the limit of requests per second.
`logToConsole`| false | Allows print log messages on this request to console

###Default properties

In addition to the settings of each individual request, you can set global settings for **SwiftyVK**. You need to contact structure `VK.config`. Some fields completely duplicate the properties of requests and will be assigned to the request when it is initialized, and the other presented only in a global context.

Property | Default | Description
:------------- | ------------- | :-------------
`apiVersion`| >5.60 | Returns used VK API version
`useSendLimit`| true | Need limit requests per second or not. See next property for more information.
`sendLimit` | 3 | The maximum number of requests that can be sent per second. Here you can [read more](https://vk.com/dev/api_requests) in the section "Limitations and recommendations".
`language`| system | This language will be used in responses from VK

##**Parsing response**

Responses to requests come in the form of text in [JSON](https://en.wikipedia.org/wiki/JSON) format. To present the data as objects, **SwiftyVK** uses the [SwiftyJSON](https://github.com/SwiftyJSON/SwiftyJSON) library. You can refer to the documentation of the library. Here I'll describe only a short example.

In our request example about the syntax that will return the response:
```JSON
[
  {
    "id" : 1,
    "first_name" : "Pavel",
    "last_name" : "Durov"
  }
]
```

It contains an array of users which we have access to 3 fields. Suppose that we want to get all user data into separate variable. We can do this:
```swift
var id = response[0,"id"].intValue //1
var firstName = response[0,"first_name"].stringValue //Pavel
var lastName = response[0,"last_name"].stringValue //Durov
```
And that's all You need. If You want to learn more, check out the [SwiftyJSON documentation](https://github.com/SwiftyJSON/SwiftyJSON).

##**Error handling**

In the process of request execution something can go wrong, as expected. In this case, an error is generated. **SwiftyVK** offers two ways of working with errors:

* `catchErrors == false`: SwiftyVK is **always** called the block error handling and you get to decide what to do with the error.

But sometimes it so happens that the query is executed when the user is **not authorized, requires validation / captcha entering, or simply exceeded the number of requests per second**. To automatically resolve these errors is second case.

* `catchErrors == true`: SwiftyVK **first try to handle the error**. If it contains [codes](https://vk.com/dev/errors) 5, 14, 17, which arise in the above cases, the **user will see a dialogue** offering to authorize, validate, or enter the captcha. If the error persists, and the number of resends of request more than `maxAttempts`, it will **call the error block**.

##**Upload files**

**SwiftyVK** allows you to easily upload files in one request by combining standard requests to VK API. Use methods in `VK.Upload` section. Let's see how you can quickly upload photos to an album:

```swift
//Get data of image
let data = NSData(contentsOfFile: NSBundle.mainBundle().pathForResource("image", ofType: "jpg")!)!
//Crete Media object to upload
let Media = Media(imageData: data, type: .JPG)
//Upload image to wall        
VK.API.Upload.Photo.toWall.toUser(media, userId: "4680178").send(
    onSuccess: {response in printresponse)},
    onError: {error in print(error)},
    onProgress: {done, total in print("send \(done) of \(total)")}
)
```

This way you can download all the other supported Vkontakte file types. Can see the implementation of other types of loading in the library tests.

Keep in mind that in some cases, such as uploading photos to a message, using this method, you just load the file to the server and get its ID. To send a message with photo, you need to add photo ID to the message.

##**Longpoll**

If you want to use Longpoll to receive updates, **SwiftyVK** allows you to easily do this, as it contains tool for working with Longpoll.

**VK.LP** sends requests **every 25 seconds** and waits for a response. When the response is received, VK.LP **send a notification** and send next request. If the device goes to sleep, the app becomes inactive, or is lost the network, VK.LP stops and again starts working when the state is changed to the opposite. This process is fully automatic. All you need are two methods and one parameter:

```swift
VK.LP.start() //Start updating
VK.LP.isActive //Longpoll status
VK.LP.stop() //Stop updating
```

And notifications types in `VK.LP.notifications` whose codes correspond to the [codes here](https://vk.com/dev/using_longpoll)

To subscribe to the notification you just need to use standard observer:

```swift
NotificationCenter.default.addObserver(self, selector: #selector(UPDATE), name: VK.LP.notifications.type4, object: nil)
```

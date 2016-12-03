extension _VKAPI {
  ///Methods for working with notifications. More - https://vk.com/dev/notifications
  public struct Notifications {



    ///Returns a list of notifications about other users' feedback to the current user's wall posts. More - https://vk.com/dev/notifications.get
    public static func get(_ parameters: [VK.Arg : String] = [:]) -> RequestConfig {
      return RequestConfig(method: "notifications.get", parameters: parameters)
    }



    ///Resets the counter of new notifications about other users' feedback to the current user's wall posts. 
    ///More - https://vk.com/dev/notifications.markAsViewed
    public static func markAsViewed(_ parameters: [VK.Arg : String] = [:]) -> RequestConfig {
      return RequestConfig(method: "notifications.markAsViewed", parameters: parameters)
    }
  }
}

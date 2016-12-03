extension _VKAPI {
  ///Methods for working with user status. More - https://vk.com/dev/status
  public struct Status {



    ///Returns data required to show the status of a user or community. More - https://vk.com/dev/status.get
    public static func get(_ parameters: [VK.Arg : String] = [:]) -> RequestConfig {
      return RequestConfig(method: "status.get", parameters: parameters)
    }



    ///Sets a new status for the current user. More - https://vk.com/dev/status.set
    public static func set(_ parameters: [VK.Arg : String] = [:]) -> RequestConfig {
      return RequestConfig(method: "status.set", parameters: parameters)
    }
  }
}

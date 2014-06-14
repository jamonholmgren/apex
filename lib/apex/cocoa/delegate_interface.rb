module Apex
  module DelegateInterface

    def applicationDidFinishLaunching(notification)
      on_launch
      true
    end

  end
end

module Pundit
  class PolicyFinder

    # Override Pundit method so we can use a more reasonable setup for policy scopes
    def scope
      [policy.name, "Scope"].join.constantize if policy
    rescue NameError
      nil
    end

    def scope!
      raise NotDefinedError, "unable to find policy scope of nil" if object.nil?
      scope or raise NotDefinedError, "unable to find scope `#{find}Scope` for `#{object.inspect}`"
    end

  end
end

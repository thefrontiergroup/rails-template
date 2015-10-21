module Controller
  module DescribeAssignsSupport
    def describe_assign(var_name, options={}, &block)
      describe "@#{var_name}" do

        # Mangle the name of subject in such a way that we are very unlikely to change
        # what it is. Object ID returns the unique ID of the current object. In this case the
        # class which defines the current example group.
        mangled_subject = "#{object_id}_subject"
        alias_method(mangled_subject, :subject)

        options[:as] ||= var_name unless instance_methods.include?(var_name.to_sym)
        options[:as] ||= "#{object_id}_imp_subject"

        subject(options[:as]) do
          __send__(mangled_subject)
          assigns[var_name]
        end

        instance_eval &block
      end
    end
  end
end
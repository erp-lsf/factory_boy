require "factory_boy/version"


module FactoryBoy
  @@registered_classes = {}

  def self.registered_classes
    @@registered_classes
  end

  def self.register(object, params={})
    @@registered_classes[object] = params
  end

  def self.clear!
    @@registered_classes = {}
  end

  def self.registered_class?(object)
    @@registered_classes.include?(object)
  end

  def self.default_params(object)
    @@registered_classes[object]
  end

  def self.create(object, params={}, &block)
    string = object.to_s.capitalize
    cls = Object.const_get(string)

    return unless registered_class?(cls)

    obj = cls.new.tap do |obj|
      assign_values(obj, default_params(cls))
      assign_values(obj, params)
    end

    if block_given?
      obj.instance_eval(&block)
    end
    obj
  end

  def self.assign_values(obj, hash)
    hash.each do |attr, value|
      attr_setter_sym = "#{attr}="
      obj.send(attr_setter_sym, value)
    end
  end
end

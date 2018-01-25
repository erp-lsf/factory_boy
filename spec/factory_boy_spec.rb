require 'spec_helper'

describe FactoryBoy do


  it 'has a version number' do
    expect(FactoryBoy::VERSION).not_to be nil
  end

  it 'unregisters a class' do
    FactoryBoy.register(User)
    FactoryBoy.clear!
    expect(FactoryBoy.registered_classes).eql? []
  end

  it 'registers a class from constant' do
    FactoryBoy.register(User)
    expect(FactoryBoy.registered_class?(User)).eql? be_truthy
    FactoryBoy.clear!
  end

  it 'registers a class from symbol' do
    FactoryBoy.register(:user)
    expect(FactoryBoy.registered_class?(:user)).eql? be_truthy
    FactoryBoy.clear!
  end

  it 'registers a class from string' do
    FactoryBoy.register('user')
    expect(FactoryBoy.registered_class?('user')).to be_truthy
    FactoryBoy.clear!
  end

  it "returns new instance of registered class" do
    FactoryBoy.register(User)
    expect(FactoryBoy.create(User)).to be_kind_of(User)
    FactoryBoy.clear!

  end

  it "returns new instance of registered class string" do
    FactoryBoy.register(User)
    expect(FactoryBoy.create('user')).to be_kind_of(User)
    FactoryBoy.clear!
  end

  it "returns new instance of registered class symbol" do
    FactoryBoy.register(User)
    expect(FactoryBoy.create(:user)).to be_kind_of(User)
    FactoryBoy.clear!
  end

  it 'accepts parameters' do
    FactoryBoy.register(User)
    object = FactoryBoy.create(:user, name: 'John')
    expect(object.name).to eq('John')
    FactoryBoy.clear!
  end

  it 'uses default parameters' do
    FactoryBoy.register(User, surname: 'Doe')
    object = FactoryBoy.create(:user, name: 'John')
    expect(object.name).to eq('John')
    expect(object.surname).to eq('Doe')
    FactoryBoy.clear!
  end

  it 'create parameters precendence' do
    FactoryBoy.register(User, surname: 'Doe')
    object = FactoryBoy.create(:user, surname: 'Not Doe')
    expect(object.surname).to eq('Not Doe')
    FactoryBoy.clear!
  end

  it 'accepts blocks' do
    FactoryBoy.register(User)
    object = FactoryBoy.create(:user, name: 'Not Doe') do
      surname 'Doe'
    end
    expect(object.surname).to eq('Doe')
    expect(object.name).to eq('Not Doe')
    FactoryBoy.clear!
  end
end

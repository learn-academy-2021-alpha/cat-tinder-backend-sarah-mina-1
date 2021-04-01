require 'rails_helper'

RSpec.describe Cat, type: :model do
  it 'should have a valid name' do
    cat = Cat.create(age: 4, enjoys: 'walks on the beach')
    expect(cat.errors[:name]).to include "can't be blank"
  end

  it 'should have a valid age' do
    cat = Cat.create(name: 'Daria', enjoys: 'walks on the beach')
    expect(cat.errors[:age]).to include "can't be blank"
  end

  it 'should have a valid enjoys description' do
    cat = Cat.create(name: 'Daria', age: 4)
    expect(cat.errors[:enjoys]).to include "can't be blank"
  end

  it 'should have an enjoys description with at least 10 chars' do
    cat = Cat.create(name: 'Daria', age: 4, enjoys: 'napping')
    expect(cat.errors[:enjoys]).to include "is too short (minimum is 10 characters)"
  end
end

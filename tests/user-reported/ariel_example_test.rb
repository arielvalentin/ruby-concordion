require 'test_helper'
require 'concordion_test_case'
require 'user'

class SomeEntity
  attr_accessor :nombre, :deleted
  def initialize(nombre)
    @nombre = nombre
    @deleted = false
  end
end

class ArielExampleTest < ConcordionTestCase

  def setup_user(name)
    User.new(name, "whatever")
  end
  
  def setup_entity(user, entity_name)
    entity = SomeEntity.new(entity_name)
    user.other = entity
    
    entity
  end
  
  def delete_users_entity(user, entity)
    if user.other.nombre == entity.nombre
      user.other.deleted = true
    end
  end
  
  def is_deleted?(entity)
    entity.deleted
  end
end


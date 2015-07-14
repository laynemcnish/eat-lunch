class ServiceResponse
  attr_reader :success, :errors
  attr_accessor :entity

  def initialize(entity: nil, success:, errors: [])
    @entity = entity
    @success = success
    @errors = errors
  end

  def self.build_success(entity)
    new(entity: entity, success: true)
  end

  def self.build_error(error, entity = nil)
    new(errors: [error], success: false, entity: entity)
  end
end
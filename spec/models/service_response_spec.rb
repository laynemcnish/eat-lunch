require "rails_helper"

describe ServiceResponse do

  let(:service) {ServiceResponse}
  let(:entity) {{some: "thing"}}
  let(:error) {"some error"}

  describe ".build_success" do
    it "returns a successful service response" do
      success_response = service.build_success(entity)

      expect(success_response.success).to eq true
      expect(success_response.entity).to eq entity
      expect(success_response.errors).to eq []
    end
  end

  describe ".build_error" do
    it "returns an unsuccessful response with errors" do
      error_response = service.build_error(error, entity)

      expect(error_response.success).to eq false
      expect(error_response.entity).to eq entity
      expect(error_response.errors).to eq ["some error"]
    end

    it "does not require an entity" do
      error_response = service.build_error(error)

      expect(error_response.success).to eq false
      expect(error_response.entity).to eq nil
      expect(error_response.errors).to eq ["some error"]
    end
  end
end
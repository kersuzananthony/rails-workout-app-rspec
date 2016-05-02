require 'rails_helper'
require 'shoulda-matchers'

RSpec.describe User, type: :model do

  it { should respond_to :email }
  it { should respond_to :first_name }
  it { should respond_to :last_name }
  it { should respond_to :full_name }

  # Validation
  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }
end

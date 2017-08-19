require 'test_helper'

class HoldingTest < ActiveSupport::TestCase
  setup do
    @holding = holdings(:one)
    @holding.save
  end
  

  # test "the truth" do
  #   assert true
  # end
  
  test "cost_basis should equal correct amount" do
    byebug
    assert @holding.cost_basis.eql?(286) 
  end
end

require 'test_helper'

class PortfolioTest < ActiveSupport::TestCase
  setup do
    @portfolio = portfolios(:one)
    @portfolio.save
  end
  
  # test "the truth" do
  #   assert true
  # end
  
  test "total value should equal correct amount" do
    assert @portfolio.total_value.eql?(30) 
  end

end

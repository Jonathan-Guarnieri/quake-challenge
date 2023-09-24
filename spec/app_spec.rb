require_relative '../app'

describe "Initial test" do
  it "I should pass this test and be hired" do
    i_was_hired = true

    expect(i_was_hired).to eq(true)
  end
end

shared_examples_for "Permits Loader" do
  it "should load a permits file" do
    loader.permits.should_not be_empty
  end
end

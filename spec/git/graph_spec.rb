require "spec_helper"
require "tmpdir"

describe Git::Graph do
  it "has a VERSION" do
    Git::Graph::VERSION.should =~ /^[\.\da-z]+$/
  end

  context "CLI" do
    def run(command, options={})
      result = `#{command}`
      raise "FAILED #{command}\n#{result}" if $?.success? == !!options[:fail]
      result
    end

    def graph(command)
      run "ruby #{Bundler.root.join("bin/git-graph")} #{command}"
    end

    before :all do
      run("rm -rf #{Bundler.root.join("tmp/parallel")}")
      run("cd #{Bundler.root.join("tmp")} && git clone git@github.com:grosser/parallel.git 2>&1")
    end

    around do |example|
      Dir.chdir(Bundler.root.join("tmp/parallel")) do
        run("git co master")
        example.call
      end
    end

    it "graphs days in csv" do
      result = graph("--start 2013-01-01 --output csv --interval day 'cat lib/parallel.rb | wc -l' 2>/dev/null")
      result.should == <<-EXPECTED.gsub(/^\s+/, "")
        Date,value
        2013-01-01,331
        2012-01-02,280
        2011-01-02,258
        2010-01-02,116
      EXPECTED
    end

    it "graphs weeks in csv" do
      result = graph("--start 2013-01-01 --end 2012-10-01 --output csv --interval week 'cat lib/parallel.rb | wc -l' 2>/dev/null")
      result.should == <<-EXPECTED.gsub(/^\s+/, "")
        Date,value
        2013-01-01,331
        2012-12-25,331
        2012-12-18,331
        2012-12-11,310
        2012-12-04,310
        2012-11-27,310
        2012-11-20,301
        2012-11-13,296
        2012-11-06,296
        2012-10-30,296
        2012-10-23,296
        2012-10-16,296
        2012-10-09,296
        2012-10-02,289
      EXPECTED
    end

    it "returns to original commit after run" do

    end
  end
end

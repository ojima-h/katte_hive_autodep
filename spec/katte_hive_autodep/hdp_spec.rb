require 'spec_helper'
require 'tempfile'

require 'katte_hive_autodep/hdp'

module KatteHiveAutodep
  describe HDP do
    before :all do
      @path = Tempfile.open('hdp_spec') do |f|
        f.puts "select * from a.b"
        f.path
      end
    end
    after(:all) { File.delete @path }

    it "parse hive query and return json" do
      hdp = HDP.new

      dep = hdp.run @path
      
      expect(dep).to have_key "sources"
      expect(dep["sources"]).to eq ["a.b"]
    end
  end
end

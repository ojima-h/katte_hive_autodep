module KatteHiveAutodep
  describe Resolver do
    before :all do
      queries_root = File.expand_path("../../recipes", __FILE__)

      node_factory = Katte::Recipe::NodeFactory.new
      @node_collection = Katte::Node::Collection.new
      @node_collection << node_factory.create(name: 'one', path: File.join(queries_root, 'one.sql'), file_type: Katte::Plugins::FileType.find('sql'))
      @node_collection << node_factory.create(name: 'two', path: File.join(queries_root, 'two.sql'), file_type: Katte::Plugins::FileType.find('sql'))
    end

    describe "#resolve" do
      it "detect hive queries dependencies" do
        resolver = KatteHiveAutodep::Resolver.new
        resolver.call(@node_collection)

        expect(@node_collection.find('one').requires).to include "two"
      end
    end
  end
end

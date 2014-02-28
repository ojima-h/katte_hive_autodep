require "katte_hive_autodep/hdp"

module KatteHiveAutodep
  class Resolver
    def initialize
      @table_node_mapping = {}
      @dependency_mapping = {}
    end

    def self.call(nodes)
      new.call(nodes)
    end
    def call(nodes)
      hive_nodes = find_hive_nodes(nodes)

      load_all(hive_nodes)

      resolve
    end

    private
    def add_table(node, hive_table)
      (@table_node_mapping[hive_table] ||= []) << node
    end
    def add_dependency(node, hive_table)
      (@dependency_mapping[node] ||= []) << hive_table
    end

    def load(node)
      dependency = HDP.new.run(node.path)

      dependency["sources"].each do |src|
        add_dependency(node, src)
      end
      dependency["destinations"].each do |dst|
        add_table(node, dst)
      end
    end
    def load_all(nodes)
      nodes.each {|node| load node }
    end
    def find_hive_nodes(nodes)
      nodes.select {|node|
        node.file_type.extname == 'sql'
      }
    end

    def resolve
      @dependency_mapping.each {|node, hive_tables|
        hive_tables.each {|hive_table|
          next unless @table_node_mapping[hive_table]
          
          @table_node_mapping[hive_table].each do |depending_node|
            next unless depending_node.is_a? Katte::Node::Base
          
            node.requires << depending_node.name
          end
        }
      }
    end
  end
end

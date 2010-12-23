# Replica set configuration
# find all nodes running mongo in this environment
mongo_nodes = search(:node, %Q{run_list:"recipe[mongodb::configure]" AND environment:#{node.environment}})

replica_sets = []
mongo_nodes.uniq.compact.each do |mongo_node|
  mongo_node.mongodb.mongods.uniq.compact.each do |mongo|
    this_replica_host = {"#{mongo["replication_set"]}" => {"host" => "#{mongo_node["hostname"]}",        
                                                           "port" => "#{mongo["port"]}"}}
    replica_sets.push(this_replica_host)
  end
end

template "/home/mongodb/replica_sets.js.example" do
  mode "0777"
  variables(
    :mongo_nodes => mongo_nodes,
    :replica_sets => replica_sets.uniq.compact
  )
  source "replica_sets.erb"
end

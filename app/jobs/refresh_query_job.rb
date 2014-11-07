class RefreshQueryJob
  include SuckerPunch::Job

  def perform(query_id)
    ActiveRecord::Base.connection_pool.with_connection do
      Query.with_advisory_lock("refresh-#{query_id}", 0) do
        query = Query.find(query_id)
        puts "Querying query #{query_id}"
        uri = URI.parse(ENV["QUERY_DB"] || 'postgres://localhost/notableapidev')
        config = {}    
        config['dbname'] = (uri.path || "").split("/")[1]
        config['user'] = uri.user
        config['password'] = uri.password

        config['host'] = uri.host
        config['port'] = uri.port
        config.delete_if { |k, v| v.nil? }

        conn = PG::Connection.new(config)
        start = Time.now
        r = conn.exec(query.query)
        finish = Time.now
        execution_time = finish - start

        query_result = {
          fields: r.fields,
          values: r.values
        }
        r.clear()
        conn.close()

        result = Result.new
        result.query = query
        result.result = query_result.to_yaml
        result.execution_time = execution_time
        result.save!
        puts "Finished query #{query_id}"
      end
    end
  end
end

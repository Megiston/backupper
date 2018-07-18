module DumpCommand

  def self.mysql(database:, username: 'root', password: nil, dump_options: nil, outfile:)
    params = []
    params << "--databases '#{database}'" if database && database != "all-databases"
    params << "-u#{username}"
    params << "-p#{password}" if password
    params << dump_options if dump_options
    params << "--all-databases" if database && database == "all-databases"
    return "mysqldump #{params.join(' ')} | bzip2 > '#{outfile}'"
  end

  def self.postgresql(database:, username: 'root', password: nil, dump_options: nil, outfile:)
    params = []
    params << "-U #{username}"
    params << "'#{database}'"
    params << dump_options if dump_options
    return "PGPASSWORD=#{password} pg_dump #{params.join(' ')} | bzip2 > '#{outfile}'"
  end

end
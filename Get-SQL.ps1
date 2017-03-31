function Get-SQL{
	param(
		[Parameter(Mandatory=$True, Position=1)]
		[string]$SQLServer,

		[Parameter(Mandatory=$True, Position=2)]
		[string]$SQLDBName,

		[Parameter(Mandatory=$True, Position=3)]
		[string]$SQLQuery
	)

	# Make SQL Connection
	try{
		$SQLConnection = New-Object System.Data.SQLClient.SQLConnection
		$SQLConnection.ConnectionString = "Server = $SQLServer; Database = $SQLDBName; `
			Integrated Security = True;"
		$SQLCmd = New-Object System.Data.SQLClient.SQLCommand
		$SQLCmd.CommandText = $SQLQuery
		$SQLCmd.Connection = $SQLConnection
		$SQLAdapter = New-Object System.Data.SQLClient.SQLDataAdapter
		$SQLAdapter.SelectCommand = $SQLCmd
		$DataSet = New-Object System.Data.DataSet
	}catch{
		write-error "Failed to make SQL connection!"
		return -1
	}
  # Run Query
  try{
  	if($SQLAdapter.Fill($DataSet)){
			return $DataSet.Tables[0]
  	}
  }catch{
  	write-error "Invalid SQL Query!"
		return -1
  }
}

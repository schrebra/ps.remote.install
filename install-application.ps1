Copy code
Param (
	[Parameter(Position = 0)]
	[String]$ComputerName,
	[Parameter(Position = 1)]
	[String]$ApplicationPath
)

# Test the connection to the remote computer
If (Test-Connection -ComputerName $ComputerName -Quiet)
{
	# Copy the installation file to the remote computer's temp directory
	copy $ApplicationPath "\\$ComputerName\c$\temp\"

	# Install the application on the remote computer
	Invoke-Command -ComputerName $ComputerName -ScriptBlock {
		C:\Windows\System32\msiexec.exe /i C:\temp\application.msi /qn
	}
}
Else
{
	Write-Host "$ComputerName Offline" -ForegroundColor Red
}

Write-Host "$ComputerName Completed"

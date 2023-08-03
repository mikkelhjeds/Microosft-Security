Install-Script -Name Invoke-ConditionalAccessDocumentation -Scope CurrentUser

"C:\Users\%USERNAME%\Documents\WindowsPowerShell\Scripts"

Connect-Graph -Scopes "Application.Read.All", "Group.Read.All", "Policy.Read.All", "RoleManagement.Read.Directory", "User.Read.All" -ContextScope Process

Invoke-ConditionalAccessDocumentation.ps1
Import-Module ActiveDirectory

$filepath = Read-Host -Prompt "csv filepath"

$users = Import-Csv $filepath

ForEach ($user in $users) {
    $loginname = $user.username + "@sapb1mm.com"
    $fname = $user.firstname
    $lname = $user.lastname
    $uname = $user.username
    $password = $user.password
    $OU = $user.ou
    New-ADUser `
    -Name "$fname $lname" `
    -SamAccountName $uname `
    -GivenName $fname `
    -Surname $lname `
    -UserPrincipalName $loginname `
    -Path $OU `
    -AccountPassword (ConvertTo-SecureString $password -AsPlainText -Force) `
    -ChangePasswordAtLogon $False `
    -CannotChangePassword $True `
    -PasswordNeverExpires $True `
    -Enable $True

}
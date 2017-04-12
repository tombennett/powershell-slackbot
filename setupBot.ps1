<#$backendConfig = @{Name = 'SlackBackend'; Token = 'xoxb-167529691185-iyp3czBiHtXmEA6S8YWS1mTe' }

$pbc = New-PoshBotConfiguration -BotAdmins @(‘U024R6SBR’) -BackendConfiguration $backendConfig

Save-PoshBotConfiguration -InputObject $pbc -Path .\PoshBotConfig.psd1 -Force

$pbc = Get-PoshBotConfiguration -Path .\PoshBotConfig.psd1 
$backend = New-PoshBotSlackBackend -Configuration $pbc.BackendConfiguration
$bot = New-PoshBotInstance -Configuration $pbc -Backend $backend
$bot.start #>


$botParams = @{
    Name = $env:BOT_NAME
    BotAdmins = @($env:BOT_ADMINS)
    CommandPrefix = '!'
    LogLevel = $env:BOT_LOGLEVEL
    LogDirectory = 'C:\bot'
    BackendConfiguration = @{
        Name = 'SlackBackend'
        Token = $env:SLACK_TOKEN
    }
    AlternateCommandPrefixes = 'bender', 'hal'
}

Write-Host "Bot Name: $env:BOT_NAME"
Write-Host "Bot LogLevel: $env:BOT_LOGLEVEL"
Write-Host "Bot Admins: $env:BOT_ADMINS"
#Write-Host "Slack Token: $env:SLACK_TOKEN"

$myBotConfig = New-PoshBotConfiguration @botParams

# Start a new instance of PoshBot interactively or in a job.
Start-PoshBot -Configuration $myBotConfig #-AsJob
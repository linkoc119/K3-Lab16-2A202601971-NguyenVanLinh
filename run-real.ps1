$ErrorActionPreference = "Stop"
$repoRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$envFile = Join-Path $repoRoot ".arena-env.ps1"
$runner = Join-Path $repoRoot "scripts\run_practice.py"
$practiceArgs = $args

if (-not (Test-Path -LiteralPath $envFile)) {
    throw "Missing $envFile. Restore it and add your API key."
}

. $envFile

if (
    [string]::IsNullOrWhiteSpace($env:ARENA_API_KEY) -or
    $env:ARENA_API_KEY -eq "<PASTE_OPENAI_API_KEY_HERE>"
) {
    throw "Open .arena-env.ps1 and replace <PASTE_OPENAI_API_KEY_HERE>."
}

$runnerArgs = @(
    "-X", "utf8",
    $runner,
    "--model", "real",
    "--prompt-addendum",
    "--layers", "all",
    "--max-tokens-param", "max_completion_tokens",
    "--temperature", "1"
) + $PracticeArgs

& python @runnerArgs
exit $LASTEXITCODE

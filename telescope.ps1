param($command, $term)

import-module .\modules\ConvertFrom-JSON.psm1
function search {
	param($term)
	$i = 0
	$j = & .\tools\curl -s0 "http://github.com/api/v2/json/repos/search/$term" | ConvertFrom-JSON
	$j.repositories | Foreach {++$i; display_repo_output $_ $i;}
}

function search_user_repos {
	param($term)
	$i = 0
	$j = & .\tools\curl -k -s0 "https://api.github.com/users/$term/repos"
	$j = [String]::Join('', $j) | ConvertFrom-JSON
	$j | Foreach {++$i; display_user_repo_output $_ $i;}
}

function display_repo_output {
	param([PSObject] $obj, [int] $i)
	
	$header = "" + $i + ") " + $obj.url
	
	Write-Host $header
	Write-Host "    "$obj.description
	Write-Host "     is_a_fork:" $obj.fork " forks:" $obj.forks " watchers:" $obj.watchers
	Write-Host ""
}

function display_user_repo_output {
	param([PSObject] $obj, [int] $i)
	
	#$header = "" + $i + ") " + $obj.name
	
	#Write-Host $header
	Write-Host "    "$obj.ssh_url
	Write-Host "    "$obj.clone_url
	Write-Host ""
}

if($command -eq "repos") { search $term }
if($command -eq "user_repos") { search_user_repos $term }

remove-module ConvertFrom-JSON

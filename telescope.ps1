param($search)

import-module .\modules\JSON\JSON
function search {
	param($term)
	$i = 0
	$j = & .\tools\curl -s0 "http://github.com/api/v2/json/repos/search/$term" | ConvertFrom-JSON  -Type PSObject
	$j.repositories | Foreach {++$i; display_output $_ $i;}
}

function display_output
{
	param([PSObject] $obj, [int] $i)
	
	$header = "" + $i + ") " + $obj.url
	
	Write-Host $header
	Write-Host "    "$obj.description
	Write-Host "     is_a_fork:" $obj.fork " forks:" $obj.forks " watchers:" $obj.watchers
	Write-Host ""
}

search $search

remove-module JSON
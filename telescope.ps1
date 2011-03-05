param($search)

import-module .\modules\JSON\JSON
function search {
	param($term)
	$i = 0
	$j = & .\tools\curl -s0 "http://github.com/api/v2/json/repos/search/$term" | ConvertFrom-JSON  -Type PSObject
	$j.repositories | Foreach { "" + ++$i + ") " + $_.url}
}

search $search

remove-module JSON
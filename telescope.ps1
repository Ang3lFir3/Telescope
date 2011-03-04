param($search)

import-module .\modules\JSON\JSON

$j = & .\tools\curl "http://github.com/api/v2/json/repos/search/$search" | ConvertFrom-JSON  -Type PSObject
$j.repositories | Foreach { $_.url}

remove-module JSON
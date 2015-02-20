<!-- Initialize parameters for Submit Form -->

<#assign status="new"/>
<#assign error = "" />
<#assign validate = page.params.validate!"0">
<#assign act = page.params.action ! "" />
<#assign fn = page.params.first! "" />
<#assign ln = page.params.last! "" />
<#assign sa = page.params.street! "" />
<#assign cy = page.params.city! "" />
<#assign st = page.params.state! "" />
<#assign zp = page.params.zip! "" />
<#assign db = page.params.dob! "" />
<#assign ph = page.params.phone!"" />
<#assign em = page.params.email! "" />
<#assign ok = page.params.terms! "" />
<#assign ag = page.params.age! "" />
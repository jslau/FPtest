<!-- Used to submit entry to database via web service. NOTE: When creating a new sweeps, the 'uuid' must be changed here. -->
<#attempt>
     <#assign url ="http://syndication.eonline.com/syndication/feeds/partners/mobile/iloop/sweepsentry.jsp?fn=${fn?url}&ln=${ln?url}&sa=${sa?url}&cy=${cy?url}&st=${st?url}&zp=${zp?url}&db=${db?url}&ph=${ph?url}&em=${em?url}&uuid=1111" />

<#assign response = tool.content.urlToString(url) />
     <#assign status="success" />
<#recover>
</#attempt>
${tool.util.getSession().put("accepted", "0")}
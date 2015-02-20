<@editor.page>
<#attempt>

     <#assign feed=tool.content.getRssFeed("http://syndication.eonline.com/syndication/feeds/partners/mobile/iloop/sweepsentry.jsp?fn=suntaetest&ln=kim&sa=abc&cy=abc&st=ca&zp=95131&db=06/11/1984&ph=555-555-5555&em=suntae.kim@iloopmobile.com&uuid=2281") />

     <#assign status="success" />
<#recover>
</#attempt>
${tool.util.getSession().put("accepted", "0")}
</@editor.page>
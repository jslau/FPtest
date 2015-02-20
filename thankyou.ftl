<@editor.page title="${site.name}" showheader=true showfooter=true>

<#assign send_url = page.params.send_url/>
<#assign ur_name=page.params.sendermsisdn/>
<#assign friend_number=page.params.msisdn/>
<#assign short_code=page.params.shortcode/>
<#assign key_word=page.params.keyword/>
<#assign user_token=page.params.usertoken/>


<#assign feed=tool.content.parseXML("http://demo.ficussoft.com:8180/eonline/sendsms?shortCode=${short_code?url}&keyword=${key_word?url}&userToken=${user_token?url}&recipientMsisdn=${friend_number?url}&senderName=${ur_name?url}&viewlink=${send_url?url}")/>

<#if feed.response.result == "SUCCESS">

<div class="spacer"><img src="images/spacer.gif" height="1" width="1" border="0"/></div>
<@editor.paragraph text="Thank you for sending." class="normal_text"/>
<div class="spacer"><img src="images/spacer.gif" height="1" width="1" border="0"/></div>
<@editor.paragraph text="Send to Another Friend" class="deepblue_bold_center" href="sendtofriend.ftl?url=${send_url}&urname=${ur_name}"/>

<#else>

<div class="spacer"><img src="images/spacer.gif" height="1" width="1" border="0"/></div>
<@editor.paragraph text="Error in message Sending!" class="normal_text"/>
<div class="spacer"><img src="images/spacer.gif" height="1" width="1" border="0"/></div>
<@editor.paragraph text="Send Again" class="deepblue_bold_center" href="sendtofriend.ftl?url=${send_url}&urname=${ur_name}"/>

</#if>
</@editor.page>
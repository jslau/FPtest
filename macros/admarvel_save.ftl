<#-- Admarvel macro -->

<#macro admarvel
partner_id='' 
site_id='' 
version='' 
phone_headers='' 
msisdn = '' 
carrier = ''
age = ''
dob = ''
area_code = ''
postal_code = ''
unique_id = ''
gender = ''
geolocation = ''
dma = ''
ethnicity = ''
seeking = ''
income = ''
marital = ''
education = ''
keywords = ''
markup = 'xhtml'
encoding = 'UTF-8'
javascript = 'no'
type = ''
width = ''
height = ''
category_id = ''
response_type = 'xhtml'
>

<#-- Get APIUrl from messages.properties -->
<#assign APIUrl = tool.text.adMarvel.APIUrl />

<#-- Enable javascript if device supports it -->
<#if tool.device.ua?contains('iPhone') || tool.device.ua?contains('Android')>
   <#assign javascript = 'yes' />
<#else>
   <#assign javascript = 'no' />
</#if>

<#-- Build optional target parameter string -->
<#assign targetParams = 
  'MSISDN=' + msisdn
+ '&CARRIER=' + carrier
+ '&&AGE=' + age
+ '&DOB=' + dob
+ '&AREA_CODE=' +area_code
+ '&POSTAL_CODE=' + postal_code
+ '&UNIQUE_ID=' + unique_id
+ '&GENDER=' + gender
+ '&GEOLOCATION=' + geolocation
+ '&DMA=' + dma
+ '&ETHNICITY=' + ethnicity
+ '&SEEKING=' + seeking
+ '&INCOME=' + income
+ '&MARITAL=' + marital
+ '&EDUCATION=' + education
+ '&KEYWORDS=' + keywords
+ '&MARKUP=' + markup
+ '&ENCODING=' + encoding
+ '&JAVASCRIPT=' + javascript
+ '&TYPE=' + type
+ '&WIDTH=' + width
+ '&HEIGHT=' + height
+ '&CATEGORY_ID=' + category_id
+ '&RESPONSE_TYPE=' + response_type
/>



<#-- Build phone_headers -->
<#assign ph = '' />
<#list page.request.getHeaderNames() as headerName>
  <#assign ph = ph + "${headerName}=>${page.request.getHeader(headerName)!''}">
  <#if headerName_has_next>
    <#assign ph = ph + "||">
  </#if>
</#list>
<#assign ph = ph?replace('user-agent','HTTP_USER_AGENT') />

<#--
<@editor.paragraph text='${ph}' />
-->

<#-- Build full parameter string -->
<#assign requestParam = 
  'site_id=' + site_id?url
+ '&partner_id=' + partner_id?url
+ '&timeout=5000'
+ '&version=' + version?url
+ '&language='
+ '&format='
+ '&phone_headers=' + ph?url
+ '&target_params=' + targetParams?url
/>

<#--
<#assign requestParam = 
  'site_id=' + site_id?url
+ '&partner_id=' + partner_id?url
+ '&timeout=5000'
+ '&version=' + version?url
+ '&language=php'
+ '&format=wap'
+ '&phone_headers=' + ph?url
+ '&target_params=' + targetParams?url
/>
-->

<#assign url = APIUrl + '?' + requestParam />

<#--
<@editor.paragraph text='${url}' />
<#assign feed = tool.content.parseXML(url) />
-->
<#assign response = tool.content.urlToString(url) />
${response}

<#--
<#assign feed = tool.content.parseXML("http://dev.eproto.mtiny.com/xml/admarvelresponse.xml") />
-->

<#-- Initialize
<#assign adError = false/>
 -->
<#-- Check for error -->
<#--
<#list feed.ad as r >
   <@editor.paragraph text='${r.@type}' />
   <#if r.@type == 'error'>
      <#assign adError = true />
      <@editor.paragraph text='errorCode=${r.errorCode} errorReason=${r.errorReason}' />
   </#if>
</#list>

-->
<#-- Display Ad -->
<#--
<#if !adError >
  <#list feed.ad as r >
   <#if r.@type == 'text'>
      <@editor.paragraph text='${r.text}' href='${r.clickurl}' />
      <#list r.pixels.pixel as p>
         <@editor.paragraph text='${p}' />
      </#list>
      <@editor.paragraph text='${r.xhtml}' />
   </#if>

   <#if r.@type == 'image'>
      <@editor.image src='${r.image.url}' href='${r.clickurl}' alt='${r.image.alt}' width='${r.image.width}' height='${r.image.height}'/>
      <#list r.pixels.pixel as p>
         <@editor.paragraph text='${p}' />
      </#list>
      <@editor.paragraph text='${r.xhtml}' />
   </#if>

   <#if r.@type == 'javascript'>
      <@editor.paragraph text='${r.xhtml}' />
   </#if>
  </#list>
</#if>
-->
</#macro>


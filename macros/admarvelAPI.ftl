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

<#attempt>

<#-- Get APIUrl from messages.properties -->
<#assign APIUrl = tool.text.adMarvel.APIUrl />

<#-- Enable javascript if device supports it -->
<#-- Javascript support is mandatory for this site. -->
<#--
<#if tool.device.ua?contains('iPhone')
  || tool.device.ua?contains('iPad')
  || tool.device.ua?contains('Android')>
   <#assign javascript = 'yes' />
<#else>
   <#assign javascript = 'no' />
</#if>
-->
<#assign javascript = 'yes' />

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
  <#assign ph = ph + "${headerName?upper_case}=>${page.request.getHeader(headerName)!''}">
  <#if headerName_has_next>
    <#assign ph = ph + "||">
  </#if>
</#list>
<#assign ph = ph?replace('USER-AGENT','HTTP_USER_AGENT') />
<#assign ph = ph?replace('X-FORWARDED-FOR','X_FORWARDED_FOR') />
<#assign ph = ph?replace('ACCEPT-LANGUAGE','HTTP_ACCEPT_LANGUAGE')/>
<#assign ph = "REMOTE_ADDR=>${tool.text.iloop.external.IPAddr}||${ph}" />



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

<#assign url = APIUrl + '?' + requestParam />

<#-- Request Ad -->
<#assign response = tool.content.urlToString(url) />

<#-- Display Ad, only if the returned response contains a clickable link. -->
<#if response?contains("a href")>
 <div class="ad1 marketingBrick">
  <center>
  <#-- <div class="spacer"><img src="/images/spacer.gif" height="1" width="1" border="0"/></div> -->
  ${response}
  <#-- <div class="spacer marketingBrick"><img src="/images/spacer.gif" height="1" width="1" border="0"/></div> -->
  </center>
 </div>
</#if>
<#recover>
Error Displaying Ad
</#attempt>

</#macro>


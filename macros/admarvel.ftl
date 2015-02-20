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

<#-- Begin smriti.rastogi@comcastnets.com 2/28/2011 -->
<#--Ad marvel wants user's JsessionId in params -->
<#attempt>
       <#assign unique_id = page.request.getSession().getId()/>
    <#recover>
        <#assign unique_id =""/>
</#attempt>
<#-- End smriti.rastogi@comcastnets.com 2/28/2011 -->


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

<#-- Begin smriti.rastogi@comcastnets.com 2/28/2011
The Ad marvel needs phone header to be HTTP_X_FORWARDED_FOR -->
  <#-- <#assign ph = ph?replace('X-FORWARDED-FOR','X_FORWARDED_FOR') /> -->
  <#assign ph = ph?replace('X-FORWARDED-FOR','HTTP_X_FORWARDED_FOR') />
<#-- End smriti.rastogi@comcastnets.com 2/28/2011-->

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

<#-- Display Ad -->
${response}


</#macro>


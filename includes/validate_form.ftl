<#if ln=="" || fn=="">
     <#assign status="error"/>
     <@editor.paragraph text="* First or last name missing" class="error_red"/>
</#if>

<#if sa=="">
     <#assign status="error"/>
     <@editor.paragraph text="* Street address missing" class="error_red"/>
</#if>


<#if cy=="">
     <#assign status="error"/>
     <@editor.paragraph text="* City missing" class="error_red"/>
</#if>

<#if st=="">
     <#assign status="error"/>
     <@editor.paragraph text="* State missing" class="error_red"/>
</#if>

<#assign zipvalidated=0 />
<!-- if zip code is not passed, return error-->
<#if !(zp?length == 5) >
     <@editor.paragraph text="* Invalid zip" class="error_red"/>
     <#assign status="error"/>
</#if>

<#if db=="">
     <#assign status="error"/>
     <@editor.paragraph text="* Date of Birth missing. Use format mmddyyyy" class="error_red"/>
</#if>

<#if !(ph?length == 10)>
     <@editor.paragraph text="* Invalid phone #. Use format 2223334444" class="error_red"/>
     <#assign status="error"/>
</#if>

<#assign validEmail = s.checkemailaddress (em) />
<#if validEmail!="">
     <@editor.paragraph text="* Invalid email address" class="error_red"/>
     <#assign status="error"/>
</#if>

<#if ok != "1">
     <@editor.paragraph text="* Check Terms and Privacy Policy box" class="error_red"/>
     <#assign status="error"/>
</#if>

<#if ag != "1">
     <@editor.paragraph text="* Check age verification box" class="error_red"/>
     <#assign status="error"/>
</#if>

<@editor.spacer />

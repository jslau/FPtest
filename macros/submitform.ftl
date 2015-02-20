<!-- Submit Form -->

<!-- Used to display form. NOTE: When creating a new sweeps, the 'uuid' in the rules url below must be changed. If changing age limit, change in this page. -->

<#-- Function Name: checkemailaddress -->
<#-- Parameter: eaddr String value submitted for check -->
<#-- Check for correct email format -->
<#-- Return: String is empty if email address is valid. If error, return string indicates error detected. -->
<#function checkemailaddress eaddr >
  <#assign emailFrm = eaddr!''?trim />
  <#assign status='' />
  <#assign error=false />

  <#if emailFrm != ''>
    <#-- check for '@' symbol -->
    <#assign atPos = emailFrm?index_of("@",1) />                                             
    <#if atPos == -1>
      <#assign status = "Invalid email format, missing \'@\' char" />
      <#assign error = true />
    </#if>
    <#-- check for only 1 '@' symbol -->
    <#if emailFrm?index_of("@",atPos+1) != -1>
       <#assign status = "Invalid email format, duplicate \'@\' chars" />
       <#assign error = true />
    </#if>
    <#-- and at least one '.' after the '@' -->
    <#assign periodPos = emailFrm?index_of(".",atPos) />
    <#if periodPos == -1>
      <#assign status = "Invalid email format, no \'.\' found following \'@\'" />
      <#assign error = true />
    </#if>
    <#-- check for at least 1 char after '@' and before '.' -->
    <#if (atPos+1 >= periodPos) >
      <#assign status = "Invalid email format, no domain present" />
      <#assign error = true />
    </#if>
    <#-- must be at least 2 characters after the '.' -->
    <#if (periodPos+3 > emailFrm?length) >           {
      <#assign status = 'Invalid email format, no top-level domain found' />
      <#assign error = true />
    </#if>
  <#else>
    <#assign status = "Invalid email, empty string" />
    <#assign error = true />
  </#if>
  <#return status />
</#function>

<#macro spacer>
       <div class="spacer">&nbsp;</div>
</#macro>

<#macro sub first="" last="" street="" city="" state="" zip="" dob="" phone="" email="" terms="0" age="0" posturl="">
       <form action ="${posturl}">
              <@editor.paragraph text="* Required" class="error_small" />
<@spacer/>
              <@editor.paragraph text="*First Name:" class="normal" />
              <@editor.input name="first" value="${first?trim}" class="normal" />
              <@spacer/>
              <@editor.paragraph text="*Last Name:" class="normal" />
              <@editor.input name="last" value="${last?trim}" class="normal"/>
              <@spacer/>
<@editor.paragraph text="*Street Address:" class="normal" />
              <@editor.input name="street" value="${street?trim}" class="normal" />
              <@spacer/>
<@editor.paragraph text="*City:" class="normal" />
              <@editor.input name="city" value="${city?trim}" class="normal" />
              <@spacer/>
<@editor.paragraph text="*State:" class="normal" />
              <@editor.input name="state" value="${state?trim}" class="normal" />
              <@spacer/>
              <@editor.paragraph text="*Zip code:" class="normal" />
              <input type="text" name="zip" value="${zip?trim}" style='-wap-input-format: "NNNNN"' class="input"/>
              <@spacer/>
<@editor.paragraph text="*Date of Birth:" class="normal" />
              <@editor.paragraph text="(ex. MMDDYYYY)" class="normal" />
              <@editor.input name="dob" value="${dob?trim}" class="normal" />
              <@spacer/>
              <@editor.paragraph text="*Mobile Phone Number:" class="normal" />
              <@editor.paragraph text="(ex. 2223334444)" class="normal" />
              <input type="text" name="phone" value="${phone?trim}" style='-wap-input-format: "*N"' class="input"/>
              <@editor.paragraph text="*Email Address:" class="normal" />
              <@editor.input name="email" value="${email?trim}" class="normal"/>
              <@editor.spacer/>
              <#attempt>
                      <#assign accept=tool.util.getSession().get("accepted")/>
              <#recover>
                      <#assign accept="0"/>
              </#attempt>
          <!--    <@spacer/> -->
              <#if accept != "1">

<!-- When creating a new sweeps, the 'uuid' in the rules url below must be changed. -->

                      <table class="checkbox">
                              <td valign="top"><input type="checkbox" name="terms" id="checkbox" value="1" align="left"/></td>
                              <td>I have read and consent to the <a href="terms.ftl" class="error_red">Official Rules</a></td>
                      </table>
              <#else>
                      ${tool.util.getSession().put("accepted", "1")}
              </#if>
              <@spacer/>
                      <table class="checkbox">
                              <td valign="top"><input type="checkbox" name="age" id="checkbox" value="1" align="left"/></td>
                              <td>I hereby attest I am 18 years of age or older.</td>
                      </table>

              <@spacer/>
              <@editor.hidden name="action" value="validate"/>
<#attempt>
<#assign width=tool.device.info.displayDimensions.width/>
<#if (width<=320)>
		<#assign size='320'/>
	<#elseif ((width>320) && (width<=480))>
		<#assign size='480'/>
	<#elseif (width>480)>
		<#assign size='640'/>
	<#else>
		<#assign size='320'/>
</#if>
<#recover>
		<#assign size='480'/>
</#attempt>
              <input type="submit" postmethod="post" formaction="${posturl}" value="" class="submit_${size}" />
              <@spacer/>
       </form>
</#macro>
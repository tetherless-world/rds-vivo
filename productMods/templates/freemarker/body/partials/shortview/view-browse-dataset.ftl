<#--<#import "lib-properties.ftl" as p>-->
<#import "lib-vivo-properties.ftl" as p>

<li class="individual" role="listitem" role="navigation">
    <h1>
        <a href="${individual.profileUrl}" title="${i18n().view_profile_page_for} ${individual.name}}">${individual.name}</a>
    </h1>
<span class="title">Dataset</span>

<#if (details[0].leadResearcher)?has_content >
    <span class="title"><em>Lead Researcher:</em> <a href="${details[0].leadResearcher}">${details[0].leadResearcher_name}</a></span>
</#if>

<#if (details[0].keywords)?has_content >
    <span class="title"><em>Keywords:</em> ${details[0].keywords}</span>
</#if>

</li>


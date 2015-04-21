<#import "lib-vivo-properties.ftl" as p>

<a href="${individual.profileUrl}" title="${i18n().individual_name}">${individual.name}</a>
<span class="display-title">Dataset</span>
<#--<@p.displayTitle individual />-->

<p class="snippet">${individual.snippet}</p>


<#-- Template for adding a new dcat:Dataset from the Site Admin page: VIVO version -->

<#import "lib-vivo-form.ftl" as lvf>

<#assign typeName = editConfiguration.pageData.typeName/>
<#assign labelValue = lvf.getFormFieldValue(editSubmission, editConfiguration, "label")/>
<#assign descriptionValue = lvf.getFormFieldValue(editSubmission, editConfiguration, "description")/>

<#--If edit submission exists, then retrieve validation errors if they exist-->
<#if editSubmission?has_content && editSubmission.submissionExists = true && editSubmission.validationErrors?has_content>
    <#assign submissionErrors = editSubmission.validationErrors/>
</#if>

<h2>${i18n().create_new} ${typeName}</h2>

<#assign requiredHint = "<span class='requiredHint'> *</span>" />

<section id="newDataset" role="region">

    <form id="newDataset" class="customForm noIE67" action="${submitUrl}"  role="add new dataset">

        <p>
            <label for="label">${i18n().name_capitalized} ${requiredHint}</label>
            <input size="30" type="text" id="label" name="label" value="${labelValue}" />
        </p>

        <p>
            <label for="description">${i18n().description}</label>
            <textarea id="description" name="description">${descriptionValue}</textarea>
        </p>

        <#-- TODO add leadResearcher input -->

        <#-- TODO add contributors input -->

        <p class="submit">
            <input type="hidden" name = "editKey" value="${editKey}"/>
            <input type="submit" id="submit" value="${i18n().create_capitalized} ${typeName}"/>
            <span class="or"> ${i18n().or} </span><a class="cancel" href="${urls.base}/siteAdmin" title="${i18n().cancel_title}">${i18n().cancel_link}</a>
        </p>

        <p id="requiredLegend" class="requiredHint">* ${i18n().required_fields}</p>

    </form>
</section>

${stylesheets.add('<link rel="stylesheet" href="${urls.base}/templates/freemarker/edit/forms/css/customForm.css" />')}
${scripts.add('<script type="text/javascript" src="${urls.base}/templates/freemarker/edit/forms/js/newDatasetFormUtils.js"></script>')}


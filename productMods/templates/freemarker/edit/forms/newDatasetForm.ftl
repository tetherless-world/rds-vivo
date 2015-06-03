
<#-- Template for adding a new dcat:Dataset from the Site Admin page: VIVO version -->

<#import "lib-vivo-form.ftl" as lvf>

<#assign typeName = "Dataset"/>
<#assign labelValue = lvf.getFormFieldValue(editSubmission, editConfiguration, "label")/>
<#assign descriptionValue = lvf.getFormFieldValue(editSubmission, editConfiguration, "description")/>

<#assign personLabelValue = lvf.getFormFieldValue(editSubmission, editConfiguration, "personLabel") />
<#assign personLabelDisplayValue = lvf.getFormFieldValue(editSubmission, editConfiguration, "personLabelDisplay") />
<#assign existingPersonValue = lvf.getFormFieldValue(editSubmission, editConfiguration, "existingPerson") />

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
            <input type="text" id="label" name="label" size="50" value="${labelValue}" />
        </p>

        <p>
            <label for="description">${i18n().description}</label>
            <textarea id="description" name="description" rows="5">${descriptionValue}</textarea>
        </p>

        <p>
            <label for="leadResearcher">Lead Researcher</label>
            <input id="leadResearcher" name="leadResearcher"
                   type="text"
                   class="acSelector"
                   acGroupName="leadResearcher"
                   size="50"
                   value="${personLabelValue}"
                   placeholder="Select an existing person or create a new one"/>

            <input class="display" type="hidden"
                   acGroupName="leadResearcher"
                   id="personDisplay"
                   name="personLabelDisplay"
                   value="${personLabelDisplayValue}" />

        <div class="acSelection" acGroupName="leadResearcher">
            <p class="inline">
                <label>Selected Lead Researcher:</label>
                <span class="acSelectionInfo"></span>
                <a href="" class="verifyMatch"  title="${i18n().verify_match_capitalized}">(${i18n().verify_match_capitalized}</a> ${i18n().or}
                <a href="#" class="changeSelection" id="changeSelection">${i18n().change_selection})</a>
            </p>
        </div>

        <input class="acUriReceiver" type="hidden" id="leadResearcherUri"
               name="existingLeadResearcher"
               flagClearLabelForExisting="true"
               value="${existingPersonValue}" />
        </p>

        <#--
        <p>
            <label for="leadResearcher">Lead Researcher</label>
            <input class="acSelector" size="50" type="text" acGroupName="person" id="leadResearcher" name="personLabel" value="${personLabelValue}"/>
            <input type="text" size="50"  id="maskLabelBuilding" name="maskLabelBuilding" value="" style="display:none" >
            <input  size="30"  type="text" id="firstName" name="firstName" value="${firstNameValue}" ><br />
            <input type="hidden" id="lastName" name="lastName" value="">
            <input class="display" type="hidden" acGroupName="person" id="personDisplay" name="personLabelDisplay" value="${personLabelDisplayValue}" >
        </p>

        <div class="acSelection" acGroupName="person">
            <p class="inline">
                <label>${i18n().selected_person}:</label>
                <span class="acSelectionInfo"></span>
                <a href="" class="verifyMatch"  title="${i18n().verify_match_capitalized}">(${i18n().verify_match_capitalized}</a> ${i18n().or}
                <a href="#" class="changeSelection" id="changeSelection">${i18n().change_selection})</a>
            </p>
            <input class="acUriReceiver" type="hidden" id="personUri" name="existingPerson" value="${existingPersonValue}" ${flagClearLabelForExisting}="true" />
        </div>
        -->

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


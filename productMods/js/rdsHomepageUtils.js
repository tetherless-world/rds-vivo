
$(document).ready(function(){

    $.extend(this, urlsBase);
    $.extend(this, i18nStrings);

    buildSelectedData();

    function buildSelectedData() {

        var datasetCount = datasets.length;
        var html = "";

        if( datasetCount == 0 ) {
            html = "<ul style='list-style:none'><p><li style='no-datasets-found'>"
            + i18nStrings.noDatasetsFound + "</li></p></ul>";
        } else {

            html = "<ul>";

            for ( var i = 0; i < datasetCount; i++) {
                html += "<li><a href='" + urlsBase + "/individual"
                + datasets[i].uri + "'>"
                + datasets[i].name + "</a></li>";
            }

            html += "</ul><ul style='list-style:none'>"
            + "<li style='all-datasets-link'><a href='"
            + urlsBase
            + "/data#http://www.w3.org/ns/dcat#Dataset' alt='"
            + i18nStrings.viewAllDatasets + "'>"
            + i18nStrings.viewAllString + "</a></li></ul>";
        }

        $('div#selected-data').html(html);
    }

});
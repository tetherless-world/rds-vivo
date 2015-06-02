/**
 * Created by szednik on 5/22/15.
 */

function updateEditForm(dropdown) {

    var newIndividualFormGenerator = "edu.cornell.mannlib.vitro.webapp.edit.n3editing.configuration.generators.NewIndividualFormGenerator";

    var dcatDatasetURI = "http://www.w3.org/ns/dcat#Dataset";
    var newDatasetFormGenerator = "edu.cornell.mannlib.vitro.webapp.edit.n3editing.configuration.generators.NewDatasetFormGenerator";

    if(dropdown.value == dcatDatasetURI) {
        document.getElementById("editForm").value = newDatasetFormGenerator;
    } else {
        document.getElementById("editForm").value = newIndividualFormGenerator;
    }
}
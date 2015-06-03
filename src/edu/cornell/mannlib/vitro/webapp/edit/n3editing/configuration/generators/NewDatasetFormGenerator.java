package edu.cornell.mannlib.vitro.webapp.edit.n3editing.configuration.generators;

import com.hp.hpl.jena.vocabulary.XSD;

import edu.cornell.mannlib.vitro.webapp.controller.VitroRequest;

import edu.cornell.mannlib.vitro.webapp.edit.n3editing.VTwo.EditConfigurationUtils;
import edu.cornell.mannlib.vitro.webapp.edit.n3editing.VTwo.EditConfigurationVTwo;
import edu.cornell.mannlib.vitro.webapp.edit.n3editing.VTwo.fields.FieldVTwo;

import edu.cornell.mannlib.vitro.webapp.edit.n3editing.configuration.validators.AntiXssValidation;

import edu.cornell.mannlib.vitro.webapp.utils.FrontEndEditingUtils;
import edu.cornell.mannlib.vitro.webapp.utils.generators.EditModeUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

/**
 * @author szednik
 */

public class NewDatasetFormGenerator extends BaseEditConfigurationGenerator implements EditConfigurationGenerator {

    private Log log = LogFactory.getLog(NewDatasetFormGenerator.class);

    final static String template = "newDatasetForm.ftl";

    final static String RDF = "http://www.w3.org/1999/02/22-rdf-syntax-ns#";
    final static String RDFS = "http://www.w3.org/2000/01/rdf-schema#";
    final static String DCAT = "http://www.w3.org/ns/dcat#";
    final static String DCT = "http://purl.org/dc/terms/";
    final static String RDS = "http://purl.org/twc/ns/rds#";
    final static String FOAF = "http://xmlns.com/foaf/0.1/";

    final static String N3_PREFIX =
            "@prefix dcat: <"+DCAT+"> ."
            + " @prefix rdf: <"+RDF+"> ."
            + " @prefix rdfs: <"+RDFS+"> ."
            + " @prefix dct: <"+DCT+"> ."
            + " @prefix rds: <"+RDS+"> . ";

    final static String personQuery  =
            "PREFIX rdfs: <"+RDFS+">"
                    + " PREFIX foaf: <"+FOAF+">"
                    + " SELECT ?person WHERE {"
                    + " ?person a foaf:Person ."
                    + " }";

    final static String personLabelQuery  =
            "PREFIX rdfs: <"+RDFS+">"
                    + " PREFIX foaf: <"+FOAF+">"
                    + " SELECT ?personLabel WHERE {"
                    + " ?person rdfs:label ?personLabel ."
                    + " ?person a foaf:Person ."
                    + " }";

    @Override
    public EditConfigurationVTwo getEditConfiguration(VitroRequest vreq, HttpSession session) {

        EditConfigurationVTwo config = new EditConfigurationVTwo();

        config.setTemplate(template);

        config.setN3Required(list(
                N3_PREFIX + "?newDataset rdf:type dcat:Dataset . \n"
                        + "?newDataset rdfs:label ?label . \n"
                        + "?newDataset dct:title ?label . \n"
        ));

        config.setN3Optional(list(
                N3_PREFIX + "?newDataset dct:description ?description . \n",
                N3_PREFIX + "?newDataset rds:leadResearcher ?leadResearcher . \n"
        ));

        config.addNewResource("newDataset", vreq.getWebappDaoFactory().getDefaultNamespace());

        config.setUrisOnform(list("leadResearcher"));
        config.setLiteralsOnForm(list("label", "description"));

        config.addSparqlForExistingUris("person", personQuery);

        config.addSparqlForExistingLiteral("personLabel", personLabelQuery);

        config.addField(new FieldVTwo().
                setName("label").
                setRangeDatatypeUri(XSD.xstring.getURI()).
                setValidators(list("nonempty", "datatype:" + XSD.xstring.toString())));

        config.addField(new FieldVTwo().
                setName("description").
                setRangeDatatypeUri(XSD.xstring.getURI()).
                setValidators(list("datatype:" + XSD.xstring.toString())));

        config.addField( new FieldVTwo().
                setName("leadResearcherLabel").
                setRangeDatatypeUri(XSD.xstring.toString() ).
                setValidators(list("datatype:" + XSD.xstring.toString())));

        config.addField(new FieldVTwo()
                .setName("leadResearcher")
                .setValidators(list()));

        config.addValidator(new AntiXssValidation());

        String formUrl = EditConfigurationUtils.getFormUrlWithoutContext(vreq);
        config.setFormUrl(formUrl);

        config.setEntityToReturnTo(" ?newDataset ");

        config.setFormSpecificData(getFormSpecificData(vreq));
        prepare(vreq, config);
        return config;
    }

    public HashMap<String, Object> getFormSpecificData(VitroRequest vreq) {
        HashMap<String, Object> formSpecificData = new HashMap<String, Object>();
        formSpecificData.put("editMode", getEditMode(vreq).name().toLowerCase());
        return formSpecificData;
    }

    public FrontEndEditingUtils.EditMode getEditMode(VitroRequest vreq) {
        List<String> predicates = new ArrayList<String>();
        predicates.add("http://purl.obolibrary.org/obo/RO_0000053");
        return EditModeUtils.getEditMode(vreq, predicates);
    }

}

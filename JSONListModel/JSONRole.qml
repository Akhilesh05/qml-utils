import QtQuick 2.4
import "jsonpath.js" as JSONPath

Item {
    property string query: ""
    property string name: ""
    property string json: parent.json

    onJsonChanged: updateJSONModel()

    function updateJSONModel() {
        if ( parent.json === "" )
            return;

        var objectArray = parseJSONString(parent.json, parent.query + query);
        var i = 0;
        for ( var key in objectArray ) {
            var jo = objectArray[key][0];
            parent.model.setProperty(i, name, jo[name]);
            i++;
        }
    }

    function parseJSONString(jsonString, jsonPathQuery) {
        var objectArray = JSON.parse(jsonString);
        if ( jsonPathQuery !== "" )
            objectArray = JSONPath.jsonPath(objectArray, jsonPathQuery);
        return objectArray;
    }
}

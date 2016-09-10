/*
    |------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
	| Parameter     | Required | Type    | Default | Description                                                                                                                                           |
    |------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
	| table         | Yes      | string  |         | existing table name                                                                                                                                   |
	| columnType    | Yes      | string  |         | type of column to add                                                                                                                                 |
	| columnName    | No       | string  |         | name for new column, required if columnType is not 'reference'                                                                                        |
	| referenceName | No       | string  |         | name for new reference column, see documentation for references function, required if columnType is 'reference'                                       |
	| default       | No       | string  |         | default value for column                                                                                                                              |
	| null          | No       | boolean |         | whether nulls are allowed                                                                                                                             |
	| limit         | No       | number  |         | character or integer size limit for column                                                                                                            |
	| precision     | No       | number  |         | precision value for decimal columns, i.e. number of digits the column can hold                                                                        |
	| scale         | No       | number  |         | scale value for decimal columns, i.e. number of digits that can be placed to the right of the decimal point (must be less than or equal to precision) |
    |------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|

    EXAMPLE:
*/
component extends="[extends]" hint="[description]" {

	function up() {
	  	hasError = false;
		transaction {
		  	try{
				addColumn(table='tableName', columnType='', columnName='columnName', default='', null=true);
			}
			catch (any ex){
				hasError = true;
				catchObject = ex;
			}

			if (!hasError) {
				transaction action="commit";
			else {
				transaction action="rollback";
				throw(errorCode="1" detail=catchObject.detail message=catchObject.message type="any");
			}
		}
	}

	function down() {
	  	hasError = false;
		transaction {
		  	try{
				removeColumn(table='tableName',columnName='columnName');
			}
			catch (any ex){
				hasError = true;
				catchObject = ex;
			}

			if (!hasError) {
				transaction action="commit";
			else {
				transaction action="rollback";
				throw(errorCode="1" detail=catchObject.detail message=catchObject.message type="any");
			}
		}
	}

}

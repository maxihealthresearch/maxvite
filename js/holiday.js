$(function(){ 
$( "#holidayDialog" ).dialog({
			autoOpen: false,
			modal: true, 
			minWidth: 600
		});

		$( "#holidaySchedule" ).click(function() {
			$( "#holidayDialog" ).load("/holiday-schedule.cfm").dialog( "open" );
			return false;
		});// JavaScript Document
});
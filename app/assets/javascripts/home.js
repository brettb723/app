// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/


/* Mobile BugHerd Fix Attempts */
// var clicked = false;
// $('*').on('click', function(event) {
// 	if (!clicked) {
// 		event.preventDefault();
// 		var element = $(event.target);
// 		element.hover();
// 		element.mouseenter();
// 		clicked = true;
// 		element.click();
// 	} else {
// 		clicked = false;
// 	}
// });

// function checkDOMChange()
// {
// 	alert($('*').size());
//     // check for any new element being inserted here,
//     // or a particular node being modified
//
//     // call the function again after 100 milliseconds
//     setTimeout( checkDOMChange, 3000 );
// }
var metricTypeFormatters = {
	'Count': function(number) {
		return accounting.formatNumber(number, 2, ",");
	},
	'Dollars': function(number) {
		return accounting.formatMoney(number, "$", 2, ",", ".");
	}
};

$(function() {
	// $.get('/flowdata.csv', function(csv) {
  // 		var data = Papa.parse(csv);
	// 	var rawData = data['data'];
	//
	// 	var metrics = [
	// 		"TripsScheduled",
	// 		"TripsPerformed",
	// 		"TripsBilled",
	// 		"TripsPaid",
	// 		"DaysToCash",
	// 		"OnTimePerformance",
	// 	];
	//
	// 	var thisYear = new Date().getFullYear().toString();
	//
	// 	var months = [
	// 			"Jan",
	// 			"Feb",
	// 			"Mar",
	// 			"Apr",
	// 			"May",
	// 			"Jun",
	// 			"Jul",
	// 			"Aug",
	// 			"Sep",
	// 			"Oct",
	// 			"Nov",
	// 			"Dec",
	// 	];//.map(function(month, i) {return month + " " + thisYear}); //TODO fix (causing calculations to become NaN)
	//
	// 	var columns = [
  //           "Measurement",
	// 		"Trend"
  //       ].concat(months);
	//
	// 	var accumulateMetricTypeData = function(metricType, metric, month, valueRowIndex) {
	// 		return function(outcome, row) {
	// 			var monthNumStr = (months.indexOf(month) + 1);
	// 			monthNumStr = monthNumStr < 10 ? '0' + monthNumStr : monthNumStr;
	// 			var dateStr = thisYear + '-' + monthNumStr + '-'
	// 			var monthMatch = row[0].indexOf(dateStr) != -1
	// 			var metricMatch = row[1] == metric;
	// 			var metricTypeMatch = row[2] == metricType;
	// 			if (!(monthMatch && metricMatch && metricTypeMatch)) return outcome;
	// 			var valueToAdd = parseFloat(row[valueRowIndex]);
	// 			if (isNaN(valueToAdd)) valueToAdd = 0;
	// 			return outcome + valueToAdd;
	// 		};
	// 	}
	//
	// 	var calculateTableData = function(metricType) {
	// 		return metrics.map(function(metric, i) {
	// 			var rowHash = months.reduce(function(output, month) {
	// 				var addedNumerators = rawData.reduce(accumulateMetricTypeData(metricType, metric, month, 4), 0);
	// 				var addedDenominators = rawData.reduce(accumulateMetricTypeData(metricType, metric, month, 5), 0);
	// 				var value = addedDenominators == 0 ? addedNumerators : addedNumerators / addedDenominators;
	// 				output[month] = value != 0 && !!value ? metricTypeFormatters[metricType](value) : 'N/A';
	// 				return output;
	// 			}, {});
	// 			rowHash['Measurement'] = _.string.humanize(metric) + ' ('+metricType+')';
	// 			return rowHash;
	// 		});
	// 	}
	//
	//
	// 	var setupTable = function(metricType) {
	//
	// 		var dataHashes = calculateTableData(metricType);
	//
	// 		var detailInit = function(e) {
	// 			//TODO only one row (Trips performed has a nested trips billed)
	// 		    $("<div/>").appendTo(e.detailCell).kendoGrid({
	// 			        dataSource: {
	// 			            data: dataHashes.slice(0, 3),
	// 			            schema: {
	// 			                model: {
	// 			                    fields: {
	// 									MeasurementDate: {type: "string" },
	// 									metric: {type: "string" },
	// 									metrictype: {type: "string" },
	// 									Agency: {type: "string" },
	// 									Numerator: {type: "integer" },
	// 									denominator: {type: "integer" }
	// 			                    }
	// 			                }
	// 			            },
	// 			            pageSize: 10,
	// 			        },
	//
	// 		        scrollable: false,
	// 		        sortable: false,
	// 		        pageable: false,
	// 		    });
	// 		};
	//
	//   		$("#grid-" + metricType).kendoGrid({
	// 	        height: 550,
	// 	        sortable: true,
	// 	        dataSource: {
	// 	            data: dataHashes,
	// 	            schema: {
	// 	                model: {
	// 	                    fields: {
	// 							MeasurementDate: {type: "string" },
	// 							metric: {type: "string" },
	// 							metrictype: {type: "string" },
	// 							Agency: {type: "string" },
	// 							Numerator: {type: "integer" },
	// 							denominator: {type: "integer" }
	// 	                    }
	// 	                }
	// 	            },
	// 	            pageSize: 20,
	// 	        },
	// 						height: 500,
	//             scrollable: true,
	//             sortable: true,
	//             filterable: true,
	//             resizable: true,
	//             pageable: {
	//                 input: true,
	//                 numeric: false
	//             },
	//             columns: columns,
	// 			//detailInit: detailInit,
	//             //dataBound: function() {
	//             //    this.expandRow(this.tbody.find("tr.k-master-row").first());
	//             //},
	//             // dataBound: function() {
	//             // 	$('.progress-bar').hide(0);
	//             // },
	//         });
	//
	// 	};
	//
	// 	setupTable('Count');
	// setupTable('Dollars');

		var selectedMetricType = function() {
			return $('input[type=radio][name=metricType]:checked').val();
		}
		var selectedPeriodType = function() {
			return $('input[type=radio][name=periodType]:checked').val();
		}
		$('.grid-container-Dollars-week, .grid-container-Count-month, .grid-container-Dollars-month').hide(0);
		var refreshSelectedTable = function() {
			$('.grid-container').hide(0);
			$('#grid-container-' + selectedMetricType() + '-' + selectedPeriodType()).show(0);
		};
		$('input[type=radio]').change(refreshSelectedTable);
		refreshSelectedTable();

	// });
});

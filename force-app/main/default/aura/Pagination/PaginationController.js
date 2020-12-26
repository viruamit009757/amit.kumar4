({
    doInit: function (component, event, helper) {
		var defaultPageNum = component.get('v.entriesOnPage');
		var availablePageNums = component.get('v.entriesOnPageList');
		var selectOptions = [];
		availablePageNums.forEach((pageNum, index) => {
			selectOptions.push({ label: pageNum, value: pageNum, selected: pageNum === defaultPageNum });
		});
		// console.log('pagination options: ');
		// console.log(selectOptions);
		component.find('inputSelectEntriesOnPageList').set('v.options', selectOptions);
		$A.enqueueAction(component.get('c.resetPagination'));
		// console.log('current obj', component.get('v.currentObjects'));
		// console.log('component.get("v.allObjects") ', component.get("v.allObjects"));
		// console.log('compName ' + component.get("v.compName"));
    },

    resetPagination: function (component, event, helper) {
		// console.log('resetPagination');
        helper.setTotalPages(component);
        helper.setCurrentPage(component);
        component.set("v.currentPage", 1);
    },

    setPage: function (component, event, helper) {
        console.log('setPage = ');
        helper.setCurrentPage(component);
    },

    previousPage: function (component, event, helper) {
        var currentPage = component.get("v.currentPage");
        if(currentPage > 1){
            component.set("v.currentPage", --currentPage);
        }
    },

    nextPage:function (component, event, helper){
        var currentPage = component.get("v.currentPage");
        var totalPages = component.get("v.totalPages");
        if(currentPage < totalPages){
            component.set("v.currentPage", ++currentPage);
        }
    },

    onChangeEntriesOnPageList : function(component, event, helper) {
		var value = event.getSource().get("v.value");
		// console.log('rows on page: ' + value);
		component.set("v.entriesOnPage", value);
         },
});
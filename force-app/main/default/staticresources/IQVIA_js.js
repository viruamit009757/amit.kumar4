(function(w){

    var service = {

        piCurrentStudyId: null,

        scrCurrentSiteId: null,

        isCurrentStudyEmpty: function(){
            //todo remove
            return false;
        },

        navigateToPage: function (pageName) {
            console.log('Navigate to page: ' + pageName);
            var url;
            if (pageName.substring(0, 8) === 'https://' || pageName.substring(0, 7) === 'http://') { // for external urls
                url = pageName;
            } else if (pageName.substring(0, 1) === '/') {   // for relative urls
                url = pageName;
            } else {                                        // for page names
                url = '/' + pageName;
            }

            var urlEvent = $A.get("e.force:navigateToURL");
            urlEvent.setParams({url: url});
            urlEvent.fire();
        },

        redirectToPage: function (document, pageName) {
            console.log('Redirect to page: ' + pageName);
            document.location.href = document.communityURLPathPrefix + '/' + pageName;
        },

        // get parameters as an object from url in any form. i.e.:
        // parseUrlParams("?v=123&p=hello") = {v: "123", p: "hello"};
        // more: https://developer.mozilla.org/en-US/docs/Web/API/URL/searchParams#Example
        parseUrlParams: function (url) {
            var parsedUrl = new URL(url);
            return parsedUrl.searchParams;
        },

        // get specific key from parsed params. i.e.:
        // getUrlParam("?v=123&p=hello", "p") = "hello";
        // more: https://developer.mozilla.org/en-US/docs/Web/API/URL/searchParams#Example
        getUrlParam: function (url, key) {
            var parsedUrl = new URL(url);
            return parsedUrl.searchParams.get(key);
        },

        // old version of getUrlParam
        getUrlParameter: function (document, sParam) {
            var sPageURL = document.location.search.substring(1),
                sURLVariables = sPageURL.split('&'),
                sParameterName,
                i;
            for (i = 0; i < sURLVariables.length; i++) {
                sParameterName = sURLVariables[i].split('=');
                if (sParameterName[0] === sParam) {
                    return sParameterName[1] === undefined ? true : sParameterName[1];
                }
            }
        },

        // use in JS callback (if response.getState()=='ERROR'): iqviaMethods.logCallbackError(response)
        logCallbackError: function (response) {
            var errors = response.getError();
            if (errors && errors[0] && errors[0].message) {
                console.log("Error: " + errors[0].message);
            } else {
                console.log("Unknown error");
            }
        },

        // generate new url with updated parameter. examples:
        // ('http://google.com/?sh=1', 'q', 'text') -> 'http://google.com/?sh=1&q=text'
        // ('http://google.com/?sh=1&q=text', 'q', 'another') -> 'http://google.com/?sh=1&q=another'
        updateUrlParameter: function (uri, key, value) {
            var re = new RegExp("([?&])" + key + "=.*?(&|$)", "i");
            var separator = uri.indexOf('?') !== -1 ? "&" : "?";
            if (uri.match(re)) {
                return uri.replace(re, '$1' + key + "=" + value + '$2');
            }
            else {
                return uri + separator + key + "=" + value;
            }
        },

        reloadComponent: function () {
            $A.get('e.force:refreshView').fire();
        },

        htmlDecode: function (s) {
            var doc = new DOMParser().parseFromString(s, "text/html");
            return doc.documentElement.textContent;
        },

        navigateToSObject: function(recordId){
            var navEvt = $A.get("e.force:navigateToSObject");
            navEvt.setParams({
                "recordId": recordId
            });
            navEvt.fire();
        },

        updateBreadcrumbs: function(label, pageName, firstBreadcrumb=false){
            var evt = $A.get("e.c:VT_D2_BreadcrumbsChanged");
            evt.setParams({
                "label": label,
                "pageName": pageName,
                "firstBreadcrumb": firstBreadcrumb
            });
            evt.fire();
        },
    };

    w.iqviaMethods = service;
})(window);

// Lightning Utilities $LU - helper module -----------------------------------------------------------------------------
(function (w){
    var debugMode = true;

    var service = {

        executeAction: function(component, actionName, params, successCallback, errorCallback, finalCallback){
            service.logError(function () {
                var action = component.get('c.' + actionName);
                if(params) action.setParams(params);
                action.setCallback(service, function (response) {
                    try{
                        if (response.getState() === "SUCCESS") {
                            successCallback(response.getReturnValue());
                        } else {
                            if(errorCallback) errorCallback(response);
                            var errMessage = service.getErrorMessage(response);
                            if(debugMode) errMessage = 'Action: ' + actionName + ', Error: ' + errMessage;
                            throw new Error(errMessage);
                        }
                    }catch (e) {
                        console.error(e);
                        var message = e.message;
                        var error = $A.get("$Label.c.VTR3_Error");
                        if(!debugMode) message = e.message.split('\n')[0];
                        if(e.message.valueOf('Disconnected or Canceled')!= -1){

                            message = $A.get("$Label.c.VTR3_Disconnected_or_Canceled");
                        }

                        service.showErrorToast(error, message, 3);


                        //throw e;
                    }finally {
                        if(finalCallback) finalCallback();
                    }
                });
                $A.enqueueAction(action);
            })
        },

        logError: function(loggedLogic){
            try{
                loggedLogic();
            }catch (e) {
                console.error(e);
                service.showErrorToast('Error', e.message);
            }
        },

        getFullPageName: function () {
            if(document.location.href.slice(-1) === '/') return '';
            var urlParts = document.location.href.split('/');
            if(urlParts.length > 0) return urlParts[urlParts.length - 1];
        },

        getUrlParameter: function (sParam) {
            var sPageURL = document.location.search.substring(1),
                sURLVariables = sPageURL.split('&'),
                sParameterName,
                i;
            for (i = 0; i < sURLVariables.length; i++) {
                sParameterName = sURLVariables[i].split('=');
                if (sParameterName[0] === sParam) {
                    return sParameterName[1] === undefined ? true : sParameterName[1];
                }
            }
        },

        getPageName: function() {
            var fullPageName = service.getFullPageName();
            var nameParts = fullPageName.split('?');
            return nameParts[0];
        },

        getSandboxPrefix: function() {
            var prefix = window.location.pathname.split('/')[1];
            return ['patient','pi','scr'].indexOf(prefix)!==-1? '/'+prefix : '';
        },

        navigateToPage: function(pageName){
            var urlEvent = $A.get("e.force:navigateToURL");
            urlEvent.setParams({
                url: '/' + pageName
            });
            console.log('Navigate to page: ' + pageName);
            urlEvent.fire();
        },

        navigateToHome: function(){
            service.navigateToPage('');
        },

        redirectToPage: function (pageName) {
            console.log('Redirect to page: ' + pageName);
            document.location.href = communityURLPathPrefix + '/' + pageName;
        },

        createRetString: function () {
            return encodeURIComponent(service.getFullPageName());
        },

        getRetPage: function (retString) {
            return decodeURIComponent(retString);
        },

        getErrorMessage: function(response) {
            var errorMsg = 'Unknown Error';
            var errors = response.getError();
            if (errors && errors[0] && errors[0].message) errorMsg = errors[0].message;
            return errorMsg;
        },

        showToast: function (title, type, message, duration) {
            var toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
                title: title,
                message: message,
                type: type,
                duration: duration ? duration : undefined,
                mode: duration ? 'dismissible' : 'sticky'
            });
            toastEvent.fire();
        },

        showErrorToast: function (title, errorMessage, duration) {
            service.showToast(title, "error", errorMessage, duration);
        },

        showSuccessToast: function(title, message, duration){
            service.showToast(title, 'success', message, duration);
        },

        showWarningToast: function(title, message, duration){
            service.showToast(title, 'warning', message, duration);
        },

        showInfoToast: function(title, message, duration){
            service.showToast(title, 'info', message, duration);
        },

        showErrorToastFromResponse: function (response) {
            service.showErrorToast('Error', service.getErrorMessage(response));
        },

        setCookie: function(name,value,days) {
            var expires = "";
            if (days) {
                var date = new Date();
                date.setTime(date.getTime() + (days*24*60*60*1000));
                expires = "; expires=" + date.toUTCString();
            }
            document.cookie = name + "=" + (value || "")  + expires + "; path=/";
        },

        getCookie: function(name) {
            var matches = document.cookie.match(new RegExp(
                "(?:^|; )" + name.replace(/([\.$?*|{}\(\)\[\]\\\/\+^])/g, '\\$1') + "=([^;]*)"
            ));
            return matches ? decodeURIComponent(matches[1]) : undefined;
        },

        formatString: function(string) {
            var outerArguments = arguments;
            return string.replace(/{(\d+)}/g, function() {
                return outerArguments[parseInt(arguments[1]) + 1];
            });
        },

        formatPhone: function(origValue) {
            if (!origValue) return null;

            // var codes = [1, 33, 34, 39, 44, 52];
            // var countryCode = '+';
            // if (origValue.indexOf(countryCode) === 0) {
            //     origValue = origValue.substring(countryCode.length);
            // }
            console.log('!!!origValue = ', origValue);
            var digits = origValue.replace(/\D/g, '');
            console.log('!!!digits = ', digits);
            //var match = digits.match(/(1|2|3[349]?|4[349]?|5[2]?|6|7|8|9)(\d{0,3})(\d{0,3})(\d{0,4})/);
            var match = digits.match(/([1-9](?:\d{0,3}(?=\d{10,}))?)(\d{0,3})(\d{0,3})(\d{0,4})/);
            var newValue = '';
            console.log('phone match', match);
            if (digits.length && match) {
                if (match[1]) {
                    newValue += '+' + match[1];
                }
                if (match[2].length > 0) {
                    newValue += ' (' + match[2];
                }
                if (match[3].length > 0) {
                    newValue += ') '+ match[3];
                }
                if (match[4].length > 0) {
                    newValue += '-'+match[4];
                }
            }
            console.log('!!!newValue = ', newValue);
            return newValue;
        },

        callActionAsPromise: function(cmp, apexAction, params) {
            return new Promise($A.getCallback((resolve , reject) => {
                const action = cmp.get(apexAction);
                action.setParams(params);
                action.setCallback(this , function(actionResult) {
                    if(actionResult.getState() === 'SUCCESS') {
                        resolve(actionResult.getReturnValue() );
                    } else {
                        reject(actionResult.getError());
                    }
                });
                $A.enqueueAction(action);
            }));
        },

        checkIsMobile: function () {
            const SIZE = 460;
            return (/IQVIAMOBILE/.test(navigator.userAgent) || screen.width <= SIZE || screen.height <= SIZE);
        },

        // generate UUID: https://stackoverflow.com/a/2117523
        generateUuid: function() {
        return ([1e7] + -1e3 + -4e3 + -8e3 + -1e11).replace(/[018]/g, c =>
            (c ^ crypto.getRandomValues(new Uint8Array(1))[0] & 15 >> c / 4).toString(16)
        )
    }


};
    w.$LU = service;

}(window)); 
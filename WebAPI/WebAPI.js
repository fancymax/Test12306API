var request = new XMLHttpRequest();

var JSESSIONID = '';
var route = '';
var BIGipServerotn = '';

function sleepFor(sleepDuration) {
    var now = new Date().getTime();
    while (new Date().getTime() < now + sleepDuration) { /* do nothing */ }
}

function waitForResult() {
    while (request.readyState !== XMLHttpRequest.DONE) {
        sleepFor(100);
    }
}

function setCookie() {
    var cookieValue = ''
    var hasCookie = false;
    if (JSESSIONID !== '') {
        cookieValue += 'JSESSIONID=' + JSESSIONID + '; ';
        hasCookie = true;
    }

    if (BIGipServerotn !== '') {
        cookieValue += 'BIGipServerotn=' + BIGipServerotn + '; ';
        hasCookie = true;
    }

    if (route !== '') {
        cookieValue += 'route=' + route;
        hasCookie = true;
    }


    if (hasCookie) {
        request.setRequestHeader('Cookie', cookieValue);
    }
    log(cookieValue)
}

function getCookieValue(searchKey,headers) {
    let regex = new RegExp(searchKey);
    let cookie = regex.exec(headers);
    if (cookie === null) {
        return
    }
    let cookieValue = cookie[1];
    if (cookieValue !== null) {
        return cookieValue;
        log(cookieValue);
    }
}

function leftTicket_init() {
    request.open('GET', 'https://kyfw.12306.cn/otn/leftTicket/init');
    setCookie();
    request.setRequestHeader('User-Agent', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13) AppleWebKit/604.1.38 (KHTML, like Gecko) Version/11.0 Safari/604.1.38');
    request.send();

    waitForResult();

    if (request.readyState === XMLHttpRequest.DONE && request.status === 200) {

        var regex = new RegExp("var CLeftTicketUrl = '([^']+)'");
        var leftUrl = regex.exec(request.responseText)[1];
        log(leftUrl);

        regex = new RegExp("var isSaveQueryLog='([^']+)'");
        let isSaveQueryLogStr = regex.exec(request.responseText)[1];
        log(isSaveQueryLogStr);

        regex = new RegExp("src=\"/otn/dynamicJs/([^\"]+)\"");
        let dynamicJs = regex.exec(request.responseText)[1];
        log(dynamicJs);

        let headers = request.getAllResponseHeaders();
        var cookieValue = getCookieValue("JSESSIONID=([^;]+)",headers);
        if ((cookieValue !== null) && (cookieValue !== undefined)) {
            JSESSIONID = cookieValue;
        }

        cookieValue = getCookieValue("route=([^;]+)",headers);
        if ((cookieValue !== null) && (cookieValue !== undefined)){
            route = cookieValue;
        }

        cookieValue = getCookieValue("BIGipServerotn=([^;]+)",headers);
        if ((cookieValue !== null) &&(cookieValue !== undefined)){
            BIGipServerotn = cookieValue;
        }

        return {
            leftUrl: leftUrl,
            isSaveQueryLogStr: isSaveQueryLogStr,
            dynamicJs: dynamicJs
        };
    }

    return
}

function requestDynamicJs(jsName) {
    let url = 'https://kyfw.12306.cn/otn/dynamicJs/' + jsName;
    request.setRequestHeader('refer', 'https://kyfw.12306.cn/otn/leftTicket/init');
    setCookie();
    request.setRequestHeader('User-Agent', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13) AppleWebKit/604.1.38 (KHTML, like Gecko) Version/11.0 Safari/604.1.38');
    request.open('GET', url);
    request.send();

    waitForResult();
}

function leftTicket_Log(url) {
    request.setRequestHeader('refer', 'https://kyfw.12306.cn/otn/leftTicket/init');
    request.setRequestHeader('If-Modified-Since', '0');
    request.setRequestHeader('Cache-Control', 'no-cache');

    request.open('GET', url);
    request.send();

    waitForResult();
}

function leftTicket_Query(url) {
    request.setRequestHeader('refer', 'https://kyfw.12306.cn/otn/leftTicket/init');
    request.setRequestHeader('If-Modified-Since', '0');
    request.setRequestHeader('Cache-Control', 'no-cache');
    setCookie();
    request.setRequestHeader('User-Agent', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13) AppleWebKit/604.1.38 (KHTML, like Gecko) Version/11.0 Safari/604.1.38');

    request.open('GET', url);
    request.send();

    waitForResult();
    if (request.readyState === XMLHttpRequest.DONE && request.status === 200) {
        log(request.responseText);
    }
}

function queryTicketFlow() {
    var res = leftTicket_init();

    let train_date = '2018-02-13';
    let from_station = 'SZQ';
    let to_stationCode = 'SHH';
    let purpose_codes = 'ADULT';
    let params = 'leftTicketDTO.train_date=' + train_date + '&leftTicketDTO.from_station=' + from_station + '&leftTicketDTO.to_station=' + to_stationCode + '&purpose_codes=' + purpose_codes;

    requestDynamicJs(res.dynamicJs);

    if (res.isSaveQueryLogStr === 'Y') {
        let logUrl = 'https://kyfw.12306.cn/otn/leftTicket/log?' + params
        leftTicket_Log(logUrl);
    }

    let queryUrl = 'https://kyfw.12306.cn/otn/' + res.leftUrl + '?' + params;
    leftTicket_Query(queryUrl);
}




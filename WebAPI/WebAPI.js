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
        let json = JSON.parse(request.responseText);
        // log(request.responseText);
        // log(json.data.result);
        // log(json.data.map);
        let tickets = parseTickets(json.data.result,json.data.map);

        return convertTickets(tickets)
    }
}

function convertTickets(tickets) {
    let dtos = [];
    log(tickets.length);
    for (let i = 0; i < tickets.length; i++) {
        let dto = QueryLeftNewDTO.createNew();
        dto.train_no = tickets[i].queryLeftNewDTO.train_no;
        dto.train_code = tickets[i].queryLeftNewDTO.station_train_code;
        
        dtos.push(dto);
    }

    return dtos;
}

function parseTickets(result, map) {
    var cs = [];
    for (var cr = 0; cr < result.length; cr++) {
        var cw = [];
        var cq = result[cr].split("|");
        cw.secretHBStr = cq[36];
        cw.secretStr = cq[0];
        cw.buttonTextInfo = cq[1];
        var cu = [];
        cu.train_no = cq[2];
        cu.station_train_code = cq[3];

//        log(cu.station_train_code);

        cu.start_station_telecode = cq[4];
        cu.end_station_telecode = cq[5];
        cu.from_station_telecode = cq[6];
        cu.to_station_telecode = cq[7];
        cu.start_time = cq[8];
        cu.arrive_time = cq[9];
        cu.lishi = cq[10];
        cu.canWebBuy = cq[11];
        cu.yp_info = cq[12];
        cu.start_train_date = cq[13];
        cu.train_seat_feature = cq[14];
        cu.location_code = cq[15];
        cu.from_station_no = cq[16];
        cu.to_station_no = cq[17];
        cu.is_support_card = cq[18];
        cu.controlled_train_flag = cq[19];
        cu.gg_num = cq[20] ? cq[20] : "--";
        cu.gr_num = cq[21] ? cq[21] : "--";
        cu.qt_num = cq[22] ? cq[22] : "--";
        cu.rw_num = cq[23] ? cq[23] : "--";
        cu.rz_num = cq[24] ? cq[24] : "--";
        cu.tz_num = cq[25] ? cq[25] : "--";
        cu.wz_num = cq[26] ? cq[26] : "--";
        cu.yb_num = cq[27] ? cq[27] : "--";
        cu.yw_num = cq[28] ? cq[28] : "--";
        cu.yz_num = cq[29] ? cq[29] : "--";
        cu.ze_num = cq[30] ? cq[30] : "--";
        cu.zy_num = cq[31] ? cq[31] : "--";
        cu.swz_num = cq[32] ? cq[32] : "--";
        cu.srrb_num = cq[33] ? cq[33] : "--";
        cu.yp_ex = cq[34];
        cu.seat_types = cq[35];
        cu.exchange_train_flag = cq[36];
        cu.from_station_name = map[cq[6]];
        cu.to_station_name = map[cq[7]];
        cw.queryLeftNewDTO = cu;
        cs.push(cw)
    }
    return cs
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
    return leftTicket_Query(queryUrl);
}




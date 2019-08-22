<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<%@ include file="comm.jsp" %>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
      content="width=device-width,initial-scale=1,user-scalable=0">
<title>赛诚在线办公</title>
<style type="text/css">
    .page__hd {
        margin: 0 auto;
        height: 100px;
        padding: 10px;
        padding-left: 50px;
        overflow: hidden;
        background-color: #84ccc9;
    }

    .page__desc {
        color: #005982;
        font-size: 30px;
        font-family: Microsoft Yahei;
    }

    .img {
        border-radius: 9px;
        -webkit-border-radius: 9px;
        -moz-border-radius: 9px;
        width: 70px;
        height: 70px;
        border-radius: 50%;
        -webkit-border-radius: 50%;
        -moz-border-radius: 50%;
        margin-top: 15px;
    }

    .weui-grid__label {
        display: block;
        text-align: center;
        font-weight: bold;
        color: #000;
        font-size: 14px;
        white-space: nowrap;
        text-overflow: ellipsis;
        overflow: hidden;
    }
</style>
<script type="text/javascript">
    var user;
    $(function () {
        loadMsg();
        getuser();
    })

    var getuser = function () {
        $.ajax({
            url: "<%=root%>/login/getuserinfo",
            type: "POST",
            dataType: "json",
            success: function (json) {
                if (json != null) {
                    user = json;
                }
            },
            error: function () {
            }
        });
    }

    var loadMenus = function () {
        $.ajax({
            url: "<%=root%>/login/getMenu",
            type: "POST",
            success: function (menus) {
                $('#content').empty();
                var content = "";
                var userinfo = '<div class="page__hd">'
                    + '<p><img src=" ' + user.headimgurl + ' " alt="" class="img" style="float:left"></p><br>'
                    + '<p style="text-indent:1em" class="page__desc">' + user.nickname + '</p>'
                    + '</div>'
                $('#content').append(userinfo);
                for (var i = 0; i < menus.length; i++) {
                    content = "";
                    var menu = menus[i];
                    var code = menu.code;
                    content += '<a id=' + menu.code + ' class="weui-flex__item" data-id="list"  href="javascript:;">'
                            + '<p class="weui-grid__label">' + menu.name + '</p>'
                            + '</a>';
                    $('#content').append(content);
                    $.ajax({
                        url: "<%=root%>/login/getSubMenu?menuCode=" + code,
                        type: "POST",
                        async:false,
                        success: function (submenus) {
                            content = '<div class="weui-grids">';
                            for (var j = 0; j < submenus.length; j++) {
                                var submenu = submenus[j];
                                content += '<a id=' + submenu.code + ' class="weui-grid" data-id="list" onclick="gotoPage(' + submenu.code + ')">'
                                    + '<div style="width:60px;height:60px;margin:0 auto;">'
                                    + '<img src="<%=root%>/img/icon_nav_cell.png" alt="" style="display:block;width:100%;height:100%">'
                                    + '</div>'
                                    + '<p class="weui-grid__label">' + submenu.name + '</p>'
                                    + '</a>';
                            }
                            content += '</div>';
                            $('#content').append(content);
                        }
                    });
                    $('#content').append();
                }

            }
        });
    }
    var loadMsg = function () {
        $('#userinfo').empty();
        $('#content').empty();
        $.ajax({
            url: "<%=root%>/msg/myMsg",
            type: "POST",
            async:false,
            success: function (msgList) {
                $('#msgCount').empty();
                $('#content').empty();
                $('#msgCount').append(msgList.length);
                var content = ""
                content += '<div>'
                    + '<a class="weui-cell weui-cell_access js_item" data-id="list" onclick="getAllMsg()">'
                    + '<p>' + "全部消息" + '</p>'
                    + '<div class="weui-cell__ft"></div>'
                    + '</a>';
                for (var i = 0; i < msgList.length; i++) {
                    var msg = msgList[i];
                    content += '<a class="weui-cell weui-cell_access js_item" data-id="list" onclick="msgDetail(' + msg.rid + ')">'
                        + '<div class="weui-cell__bd">'
                        + '<p>' +'&nbsp;&nbsp;&nbsp;&nbsp;'+ msg.messageNote +'</p>'
                        + '</div>'
                        + '<div class="weui-cell__bd">'
                        + '<p align="right">' + timestamp(msg.createDate).substr(2) + '</p>'
                        + '</div>'
                        + '<div class="weui-cell__ft"></div>'
                        + '</a>';
                }
                content += '</div>';
                $('#content').append(content);
            }
        });
        $.ajax({
            url: "<%=root%>/msg/mySchedule",
            type: "POST",
            async:false,
            success: function (scheduleList) {
                var content = ""
                content += '<div>'
                    + '<a class="weui-cell weui-cell_access js_item" data-id="list" onclick="getAllSchedule()">'
                    + '<p>' + "待办事项" + '</p>'
                    + '<div class="weui-cell__ft"></div>'
                    + '</a>';
                for (var i = 0; i < scheduleList.length; i++) {
                    var schedule = scheduleList[i];
                    content += '<a class="weui-cell weui-cell_access js_item" data-id="list" onclick="scheduleDetail(' + schedule.rid + ')">'
                        + '<div class="weui-cell__bd">'
                        + '<p>' +'&nbsp;&nbsp;&nbsp;&nbsp;'+ schedule.skdSubject + '</p>'
                        + '</div>'
                        + '<div class="weui-cell__bd">'
                        + '<p align="right">' + timestamp(schedule.createDate).substr(2) + '</p>'
                        + '</div>'
                        + '<div class="weui-cell__ft"></div>'
                        + '</a>';
                }
                content += '</div>';
                $('#content').append(content);
            }
        });
        $.ajax({
            url: "<%=root%>/msg/getNotice",
            type: "POST",
            async:false,
            success: function (noticeList) {
                var content = ""
                content += '<div>'
                    + '<a class="weui-cell weui-cell_access js_item" data-id="list" onclick="getAllNotice()">'
                    + '<p>' + "新闻公告" + '</p>'
                    + '<div class="weui-cell__ft"></div>'
                    + '</a>';
                for (var i = 0; i < noticeList.length; i++) {
                    var notice = noticeList[i];
                    var type;
                    if(notice.ntcType == 0){
                        type = "[通知]";
                    }
                    if(notice.ntcType == 1){
                        type = "[新闻]";
                    }
                    content += '<a class="weui-cell weui-cell_access js_item" data-id="list" onclick="noticeDetail(' + notice.rid + ')">'
                        + '<div class="weui-cell__bd">'
                        + '<p>' + '&nbsp;&nbsp;&nbsp;&nbsp;'+ type + notice.ntcSubject + '</p>'
                        + '</div>'
                        + '<div class="weui-cell__bd">'
                        + '<p align="right">' + timestamp(notice.createDate).substr(2) + '</p>'
                        + '</div>'
                        + '<div class="weui-cell__ft"></div>'
                        + '</a>';
                }
                content += '</div>';
                $('#content').append(content);
            }
        });
    }

    var timestamp = function(timestamp) {
        var date = new Date(timestamp);
        var Y = date.getFullYear() + '-';
        var M = (date.getMonth()+1 < 10 ? '0'+(date.getMonth()+1) : date.getMonth()+1) + '-';
        var D = date.getDate() + ' ';
        var h = date.getHours() + ':';
        var m = date.getMinutes() + ':';
        var s = date.getSeconds();
        return Y+M+D+h+m+s;
    }

    var getAllMsg = function () {
        window.location.href = "<%=root%>/msg/allMsg";
    }

    var getAllSchedule = function () {
        window.location.href = "<%=root%>/msg/allSchedule";
    }

    var getAllNotice = function () {
        window.location.href = "<%=root%>/msg/allNotice";
    }

    var gotoPage = function (menuCode) {
        console.dir(menuCode);
        $("#gotoPageMenuCode").val(menuCode);
        $("#gotoPageForm").submit();
    }

    var clockIn = function () {
        window.location.href = "<%=root%>/my/attendance";
    }

    var msgDetail = function (rid) {
        $.ajax({
            url: "<%=root%>/msg/msgtype/" + rid,
            type: "GET",
            async: false,
            success: function (skdtype) {
                if (skdtype == 40) {
                    window.location.href = "<%=root%>/msg/questionDetail/" + rid;
                } else {
                    $.ajax({
                        url: "<%=root%>/msg/msgDetail/" + rid,
                        type: "GET",
                        success: function (note) {
                            var msgnote = note;
                            $.modal({
                                title: "查看详情",
                                text: msgnote,
                                buttons: [
                                    {
                                        text: "查看详情", onClick: function () {
                                            window.location.href = "<%=root%>/login/approving/" + rid;
                                        }
                                    },
                                    {
                                        text: "标记为已读", onClick: function () {
                                            window.location.href = "<%=root%>/msg/setRead/" + rid;
                                            $.toptip('操作成功', 2000, 'success');
                                        }
                                    },
                                    {
                                        text: "取消", className: "default", onClick: function () {
                                            $.closeModal();
                                        }
                                    },
                                ]
                            });
                        }

                    });
                }
            }
        })
    }
    var scheduleDetail = function (rid) {
        $.ajax({
            url: "<%=root%>/msg/scheduleNote/" + rid,
            type: "GET",
            success: function (note) {
                var msgnote = note;
                $.modal({
                    title: "查看详情",
                    text: msgnote,
                    buttons: [
                        {
                            text: "查看详情", onClick: function () {
                                window.location.href="<%=root%>/msg/scheduleDetail/" + rid;
                            }
                        },
                        {
                            text: "取消", className: "default", onClick: function () {
                                $.closeModal();
                            }
                        },
                    ]
                });
            }

        });
    }

    var noticeDetail = function (rid) {
        window.location.href = "<%=root%>/msg/noticeDetail/" + rid;
    }
</script>
</head>
<body ontouchstart>

<div id='menus'>
    <div class="weui-tab__panel" id='content'>

    </div>
    <div class="weui-tabbar" style="position: fixed;">
        <a href="javascript:;" class="weui-tabbar__item weui-bar__item_on" onclick="loadMsg()">
            <span style="display: inline-block;position: relative;">
                <img src="<%=root %>/img/icon_nav_flow.png" alt="" class="weui-tabbar__icon">
                <span id='msgCount' class="weui-badge" style="position: absolute;top: -2px;right: -13px;">8</span>
            </span>
            <p class="weui-tabbar__label">我的消息</p>
        </a>

        <a href="javascript:;" class="weui-tabbar__item" onclick="clockIn()">
            <img src="<%=root %>/img/icon_nav_icons.png" alt="" class="weui-tabbar__icon">
            <p class="weui-tabbar__label">我要打卡</p>
        </a>

        <a href="javascript:;" class="weui-tabbar__item" onclick="loadMenus()">
            <img src="<%=root %>/img/icon_nav_panel.png" alt="" class="weui-tabbar__icon">
            <p class="weui-tabbar__label">功能列表</p>
        </a>
    </div>
</div>
<div style="display: none;">
    <form id="gotoPageForm" action="<%=root%>/login/gotoPage">
        <input type="text" name='menuCode' value="" id="gotoPageMenuCode">
    </form>
</div>
</body>
</html>
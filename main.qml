import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.12
import QtPositioning 5.12
import Qt.labs.settings 1.0

ApplicationWindow {
    id: window
    visible: true
    width: Screen.width
    height: Screen.height
    title: qsTr("FT User")

    property string uid: "RTC"
    property Item lastItem: gk

    background: Rectangle {
        color: "#FFFFFF"
    }

    TopTabPanel {
        id: topPanel
        visible: false
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        onAboutMAClicked: {
            lastItem = (stackView.currentItem == gk) ? gk : (stackView.currentItem == kp) ? kp  : bs
            stackView.push(about)
            about.visible = true
            topPanel.visible = false
            bottomPanel.visible = false
        }
        titleText: "Gidan Kwano"
//        onProfileMAClicked: {
//            menu.visible = true
//            login.visible = false
//            signup.visible = false
//            gk.visible = false
//            kp.visible = false
//            bs.visible = false
//        }
    }

    BottomPanelThree {
        id: bottomPanel
        visible: false
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        // @disable-check M16
        onFirstTabMAClicked: {
            if(stackView.currentItem === gk) {
                null
            }
            else {
                stackView.pop()
                stackView.push(gk)
                gk.visible = true
                sel = "a"
                topPanel.titleText = "Gidan Kwano"
                bs.visible = false
                kp.visible = false
            }
        }
        // @disable-check M16
        onSecondTabMAClicked: {
            if(stackView.currentItem === kp) {
                null
            }
            else {
                stackView.pop()
                stackView.push(kp)
                kp.visible = true
                sel = "b"
                topPanel.titleText = "Kpakungu"
                bs.visible = false
                gk.visible = false
            }
        }
        // @disable-check M16
        onThirdTabMAClicked: {
            if(stackView.currentItem === bs) {
                null
            }
            else {
                stackView.pop()
                stackView.push(bs)
                bs.visible = true
                sel = "c"
                topPanel.titleText = "Bosso"
                kp.visible = false
                gk.visible = false
            }
        }
    }

    StackView {
        id: stackView
        initialItem: splash
        anchors.fill: parent
    }

    SplashScreen {
        id: splash
        visible: true
    }

    About {
        id: about
        visible: false
        onCloseMAClicked: {
            stackView.pop()
            visible = false
            topPanel.visible = true
            bottomPanel.visible = true
        }
    }

    Signup {
        id: signup
        visible: false
        onLoginBtnClicked: {
            stackView.pop()
            visible = false
            login.visible = true
        }
        onSignupBtnClicked: {
            signupCom(nameText, emailText, passwordText)
        }
    }

    Login {
        id: login
        visible: false
        onLoginBtnClicked: {
            loginCom(emailText, passwordText)
        }
        onSignupBtnClicked: {
            if (stackView.depth === 1) {
                stackView.push(signup)
                visible = true
                login.visible = false
            }
        }
    }

    Station {
        id: gk
        visible: false
    }

    StationKP {
        id: kp
        visible: false
    }

    Station {
        id: bs
        visible: false
    }

    Settings {
        id: settings
        property string name: "None"
    }

    Timer {
        id: backgroundTimer
        interval: 15000
        running: false
        repeat: true
        onTriggered: {
            if (running)
                dataCall()
        }
    }

    Timer {
        interval: 5000
        running: true
        repeat: false
        onTriggered: {
            stackView.replace(splash, gk)
            stackView.replace(splash, gk)
            stackView.pop(splash)
            splash.visible = false
            gk.visible = true
            topPanel.visible = true
            bottomPanel.visible = true
            backgroundTimer.running = true
        }
    }

    function loginCom(par, val) {
        request('http://dcraz8317.pythonanywhere.com/login?email='+par+'&password='+val+'&type=student', function (o) {
            // log the json response
            var myJsonObject = JSON.parse(o.responseText)
            console.log(myJsonObject.status)
            if (myJsonObject.status) {
                stackView.replace(login, gk)
                stackView.replace(login, gk)
                stackView.pop(login)
                login.visible = false
                gk.visible = true
                topPanel.visible = true
                bottomPanel.visible = true
                backgroundTimer.running = true
            }
        });
    }

    function signupCom(par, val, pas) {
        request('http://dcraz8317.pythonanywhere.com/signupd?name='+par+'&email='+val+'&password='+pas+'&type=student', function (o) {
            // log the json response
            var myJsonObject = JSON.parse(o.responseText)
            console.log(myJsonObject.status)
            if (myJsonObject.status) {
                settings.name = myJsonObject.id
                signup.visible = false
                stackView.pop()
                login.visible = true
                gk.visible = false
                topPanel.visible = false
                bottomPanel.visible = false
            }
        });
    }

    function dataCall() {
        request('http://dcraz8317.pythonanywhere.com/station', function (o) {
            // log the json response
            var myJsonObject = JSON.parse(o.responseText)
            console.log(myJsonObject.status)
            if (myJsonObject.status) {
                bs.modelA.clear()
                gk.modelA.clear()
                kp.modelA.clear()
                for (var i = 0; i < myJsonObject.data["bs"]; i++) {
                    var num = Number(myJsonObject.data["bosso"][i]["eta"])
                    var decia = (num % 60)
                    var deci = formatSeconds(decia)
                    bs.modelA.append({"time": getTimes(num), "busID": myJsonObject.data["bosso"][i]["id"], "pos": myJsonObject.data["bosso"][i]["pos"], "eta": String(formatSeconds(Math.floor(myJsonObject.data["bosso"][i]["eta"] / 60))) + String(":") + String(deci), "status": myJsonObject.data["bosso"][i]["status"]})
                }
                for (var l = 0; l < myJsonObject.data["gk"]; l++) {
                    var numb = Number(myJsonObject.data["gidan"][l]["eta"])
                    var decib = (numb % 60)
                    var decis = formatSeconds(decib)
                    gk.modelA.append({"time": getTimes(numb), "busID": myJsonObject.data["gidan"][l]["id"], "pos": myJsonObject.data["gidan"][l]["pos"], "eta": String(formatSeconds(Math.floor(myJsonObject.data["gidan"][l]["eta"] / 60))) + String(":") + String(decis), "status": myJsonObject.data["gidan"][l]["status"]})
                }
                for (var h = 0; h < myJsonObject.data["kp"]; h++) {
                    var numbs = Number(myJsonObject.data["kpaku"][h]["eta"])
                    var decid = (numbs % 60)
                    var decij = formatSeconds(decid)
                    kp.modelA.append({"time": getTimes(numbs), "destination": myJsonObject.data["kpaku"][h]["destination"], "busID": myJsonObject.data["kpaku"][h]["id"], "pos": myJsonObject.data["kpaku"][h]["pos"], "eta": String(formatSeconds(Math.floor(myJsonObject.data["kpaku"][h]["eta"] / 60))) + String(":") + String(decij), "status": myJsonObject.data["kpaku"][h]["status"]})
                }
                gk.modelA.layoutChanged()
                bs.modelA.layoutChanged()
                kp.modelA.layoutChanged()
            }
        });
    }

    function getTimes(val) {
        var ti = new Date()
        ti.setSeconds(ti.getSeconds() + val)
        return String(formatSeconds(ti.getHours())) + String(":") + String(formatSeconds(ti.getMinutes())) + String(":") + String(formatSeconds(ti.getSeconds()))
    }

    function formatSeconds(val) {
        var decis = ""
        if (val < 10) {
            decis = String("0" + String(val))
        }
        else {
            decis = String(val)
        }
        return decis
    }

    function request(url, callback) {
        var xhr = new XMLHttpRequest();
        xhr.onreadystatechange = (function(myxhr) {
            return function() {
                if (myxhr.readyState === 4)
                    callback(myxhr);
            }
        })(xhr);
        xhr.open('GET', url, true);
        xhr.send('');
    }

    Component.onCompleted: {
        uid = settings.name
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
